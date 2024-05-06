#!/bin/sh

SAMPLES_FILE='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_75bp_single_end/ID.txt'
DATA_DIR='/dsi/sbm/linoym/ovarian_tumor/rna_seq_data_75bp_single_end/merged_data_files'
OUTPUT_DIR='/dsi/sbm/linoym/ovarian_tumor/salmon/rna_seq_75bp_se_no_editing'
SERVICE_NAME='salmon_service'

#curl https://ftp.ensembl.org/pub/current_fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz -o homo.fa.gz
##Build an index on transcriptome:
#salmon index -t homo.fa.gz -i homo_index

mkdir -p ${OUTPUT_DIR}
cd $DATA_DIR
sampels=$(cat ${SAMPLES_FILE})
for sample in $sampels;
do
   # ignore chace directory and others files or folders that do not start with SRR"
   echo "running on sample : $sample"
   # paier end reads
   #docker compose run $SERVICE_NAME salmon quant -i homo_index -l A -1 ${DATA_DIR}/${sample}_R1.fastq -2 ${DATA_DIR}/${sample}_R2.fastq -p 8 --validateMappings -o $OUTPUT_DIR/${sample}_quant
   #single end reads
   docker compose run $SERVICE_NAME salmon quant -i homo_index -l A -r ${DATA_DIR}/${sample}_R1_001.fastq.gz -p 8 --validateMappings -o $OUTPUT_DIR/${sample}_quant
   # -l A tells salmon that it should automatically determine the library type of the sequencing reads (e.g. stranded vs. unstranded etc.)
   # -p 8 argument tells salmon to make use of 8 threads and the -o argument specifies the directory where salmon’s quantification results sould be written
done

