# Concatenate reads
# Single sample assemblies
# Set input and output directories
PROJECT=INSERT PROJECT NAME HERE
INP=${SCRATCH}/datasets/${PROJECT}/data/processed/2_quality_trimmed
OUT=${SCRATCH}/datasets/${PROJECT}/data/processed/3_assembly/ss_assemblies

for NC in $(ls | cut -c-6 | uniq) ; do
cat $(ls | grep ${NC} | grep '_R1_') > ${OUT}/${NC}_R1_QT.fastq.gz
cat $(ls | grep ${NC} | grep '_R2_') > ${OUT}/${NC}_R2_QT.fastq.gz
done

