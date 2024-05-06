#!/bin/sh

IDS_SAMPLES_FILE='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_files/ID.txt'
DATA_PATH='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_files/merged_data_files'
OUTPUT_DATA_PATH='/dsi/sbm/linoym/ovarian_tumor/mixcr'
cd $DATA_PATH

for sample_id in $(cat ${IDS_SAMPLES_FILE}); do
   mkdir -p ${OUTPUT_DATA_PATH}/${sample_id}_v_4
   mixcr analyze rna-seq --species hs ${DATA_PATH}/${sample_id}_R1.fastq ${DATA_PATH}/${sample_id}_R2.fastq ${OUTPUT_DATA_PATH}/${sample_id}_v_4/${sample_id}_output
done
