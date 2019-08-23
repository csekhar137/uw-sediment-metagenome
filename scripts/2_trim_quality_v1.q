#!/bin/bash
#PBS -N quality
#PBS -q normal
#PBS -l select=1:ncpus=24:mem=96G
#PBS -l walltime=12:00:00
#PBS -J INSERT RANGE OF JOBS
#PBS -m abe 
#PBS -M INSERT EMAIL HERE

# Set project identifier and PATH to binaries
PROJECT=INSERT PROJECT NAME HERE
PATH=INSERT PATH TO BBTOOLS SCRIPTS

# quality filtering
# Set input and output directories
INP=${SCRATCH}/datasets/${PROJECT}/data/processed/1_adapters_trimmed
OUT=${SCRATCH}/datasets/${PROJECT}/data/processed/2_quality_trimmed
RUN=$(ls ${INP} | sed -n ${PBS_ARRAY_INDEX}p) 

# Loop through files and trim adapters
cd ${INP}/${RUN}
for R1 in $(ls | grep '_R1_') ; do
R2=${R1/_R1_/_R2_}
bbduk.sh in=${R1} in2=${R2} \
out=${OUT}/${RUN}/$(basename ${R1/_R1_AT_/_R1_QT_}) out2=${OUT}/${RUN}/$(basename ${R2/_R2_AT_/_R2_QT_}) \
trimq=20 qtrim=rl minlen=75
done
