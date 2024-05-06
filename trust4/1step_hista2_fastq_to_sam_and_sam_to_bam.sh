#!/bin/sh

IDS_SAMPLES_FILE='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_75bp_single_end/ID.txt'
DATA_PATH='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_75bp_single_end/merged_data_files'
TRUST4_FILES_PATH='/dsi/sbm/linoym/ovarian_tumor/trust4'
OUTPUT_DATA_PATH='/dsi/sbm/linoym/ovarian_tumor/trust4/rna_seq_75bp_se_no_editing'

for sample_id in $(cat ${IDS_SAMPLES_FILE}); do
   mkdir -p $OUTPUT_DATA_PATH/$sample_id
   # fastq to bam -> paierd-end
   #hisat2 -q -x ${TRUST4_FILES_PATH}/grch38/genome -1 ${DATA_PATH}/${sample_id}_R1.fastq -2 ${DATA_PATH}/${sample_id}_R2.fastq -S ${OUTPUT_DATA_PATH}/${sample_id}/${sample_id}.sam
   # fastq tp bam -> single-end
   hisat2 -q -x ${TRUST4_FILES_PATH}/grch38/genome -U ${DATA_PATH}/${sample_id}_R1_001.fastq.gz -S ${OUTPUT_DATA_PATH}/${sample_id}/${sample_id}.sam --no-spliced-alignment
   # bam to sam
   samtools view -f -h -bS ${OUTPUT_DATA_PATH}/${sample_id}/${sample_id}.sam > ${OUTPUT_DATA_PATH}/${sample_id}/${sample_id}.bam
done

