#!/bin/bash
# in parent dir we need to find all sub directory that create from salmon running
FILE="_quant.sf"
PARENT_DIR="/dsi/sbm/linoym/ovarian_tumor/salmon/rna_seq_75bp_se_no_editing"
MATRIX_DIR="$PARENT_DIR/matrix"
ADDITIONAL_FILES='/dsi/sbm/linoym/ovarian_tumor/salmon'
cd $PARENT_DIR
#cretae folder if not exsit
mkdir -p "matrix"

# Loop over folders with "quant" in their names
for folder in $(find "$PARENT_DIR" -type d -name "*quant*"); do
   # extract sample id + string(=quant) from folder name
   folder_name=$(basename "$folder")
   # remove all section after "_" .Example:  SRR111_quant -> SR111
   SAMPLE_ID=$(echo "$folder_name" | sed 's|_.*||')
   # work on copy in order not to distroy the orginal data
   cp $PARENT_DIR/$folder_name/quant.sf $MATRIX_DIR/$SAMPLE_ID$FILE
   chmod 777 $MATRIX_DIR/$SAMPLE_ID$FILE
   # replace column name "TPM" with the sample name
   sed -i "s/TPM/${SAMPLE_ID}/g" "$MATRIX_DIR/$SAMPLE_ID$FILE"
done

# create one big matrix with columns [Name,x,x,TPM,x,Name,x,x,TMP,x...]
paste $MATRIX_DIR/*.sf > $MATRIX_DIR/combined.tsv
# remove unnecessary files
rm -r $MATRIX_DIR/*.sf
#cut -f $(seq -s, 1 5 $(head -n 1 "$MATRIX_DIR/combined.tsv" | awk '{print NF}')) "$MATRIX_DIR/combined.tsv" > $MATRIX_DIR/TPMonly.tsv
# for 20 sample (-f 1 is for column Name and then all others from TPM ) 
cut -f1,4,9,14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,89,94,99 $MATRIX_DIR/combined.tsv > $MATRIX_DIR/TPMonly.tsv
rm -r $MATRIX_DIR/combined.tsv

# This python script convert id from type "ENS..." to symnol name gene
python3 $ADDITIONAL_FILES/GeneSymbolConversion.py $ADDITIONAL_FILES/mart_export.txt $MATRIX_DIR/TPMonly.tsv > $MATRIX_DIR/converted.tsv
# tsv to csv file
tr '\t' ',' < $MATRIX_DIR/converted.tsv > $MATRIX_DIR/converted.csv
awk 'BEGIN {FS=OFS=","} {if (NR>1) $1=tolower($1)} 1' $MATRIX_DIR/converted.csv > $MATRIX_DIR/converted_small_letters.csv
rm -r $MATRIX_DIR/converted.csv

