#!/bin/sh

INPUT_DATA_PATH='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_75bp_single_end/merged_data_files'
OUTPUT_DATA_PATH='/dsi/sbm/linoym/ovarian_tumor/mixcr/rna_seq_75bp_se_no_editing'
SERVICE_NAME='mixcr_version4_service'

cd $INPUT_DATA_PATH
sampels=$(ls *.fastq.gz | cut -d'_' -f1-2 | sort -u)

for sample_id in $sampels; do
   mkdir -p ${OUTPUT_DATA_PATH}/${sample_id}_v_4
   docker compose run $SERVICE_NAME mixcr analyze rna-seq --species hs ${INPUT_DATA_PATH}/${sample_id}_R1_001.fastq.gz  ${OUTPUT_DATA_PATH}/${sample_id}_v_4/${sample_id}_output
done
