#!/bin/bash
#PBS -N cutadapt
#PBS -q normal
#PBS -l select=1:ncpus=24:mem=96G
#PBS -l walltime=12:00:00
#PBS -J 1-4
#PBS -m abe 
#PBS -M INSERT EMAIL HERE

# Set project identifier and PATH to binaries
PROJECT=INSERT PROJECT NAME HERE
PATH=${PATH}:${SCRATCH}/miniconda3/envs/dada2/bin

# Adapter trimming
# Set input and output directories
INP=${SCRATCH}/datasets/${PROJECT}/data/raw/shotgun_reads
OUT=${SCRATCH}/datasets/${PROJECT}/data/processed/1_adapters_trimmed
RUN=$(ls ${INP} | sed -n ${PBS_ARRAY_INDEX}p) 

# Loop through files and trim adapters
cd ${INP}/${RUN}
for R1 in $(ls | grep '_R1_') ; do
R2=${R1/_R1_/_R2_}
cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -e 0.2 -O 3 -n 1 -m 75 --max-n 0 --no-indels -j 24 \
-o ${OUT}/${RUN}/$(basename ${R1/_R1_/_R1_AT_}) \
-p ${OUT}/${RUN}/$(basename ${R2/_R2_/_R2_AT_}) \
${R1} ${R2}
done
