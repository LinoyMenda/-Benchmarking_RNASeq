#!/bin/bash

IDS_SAMPLES_FILE='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_75bp_single_end/ID.txt'
TRUST4_PATH='/dsi/sbm/linoym/ovarian_tumor/trust4'
INPUT_FILES_PATH='/dsi/sbm/linoym/ovarian_tumor/trust4/rna_seq_75bp_se_no_editing'

for sample_id in $(cat ${IDS_SAMPLES_FILE}); do
   # Loop through each SRR accession and download data
    echo "~~ start working on $sample_id ~~ "
    #echo ${INPUT_FILES_PATH}/${sample_id}/${sample_id}.bam
    run-trust4 -b ${INPUT_FILES_PATH}/${sample_id}/${sample_id}.bam -f ${TRUST4_PATH}/hg38_bcrtcr.fa --ref ${TRUST4_PATH}/human_IMGT+C.fa --od ${INPUT_FILES_PATH}/${sample_id}
done

echo "### FINISH SCRIPT ###"
