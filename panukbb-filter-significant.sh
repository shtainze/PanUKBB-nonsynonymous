#!bin/sh -u
set -e

##########################
# This script sifts a Pan-UKBB per-phenotype file
# Criteria: Any of the p-values is under 5e-8 (log2: -16.8112428315)
# p-values under investigation: pval_{meta_hq, meta, AFR, AMR, CSA, EAS, EUR, MID}
##########################


FILE_SOURCE="$1"
FILE_OUT="$2"

rm -f "$FILE_OUT"

zcat $FILE_SOURCE | head -n 1 | awk -F'\t' -v OFS=" " '{$1=$1; print "significant_field", $0}' > "$FILE_OUT"
# Process the downloaded file
# Get the column number of p-values
# pval_meta_hq
pos_meta_hq=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_meta_hq") {print i; exit}}'`
# pval_meta
pos_meta=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_meta") {print i; exit}}'`
# pval_AFR
pos_AFR=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_AFR") {print i; exit}}'`
# pval_AMR
pos_AMR=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_AMR") {print i; exit}}'`
# pval_CSA
pos_CSA=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_CSA") {print i; exit}}'`
# pval_EAS
pos_EAS=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_EAS") {print i; exit}}'`
# pval_EUR
pos_EUR=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_EUR") {print i; exit}}'`
# pval_MID
pos_MID=`zcat $FILE_SOURCE | head -n 1 | awk -F'\t' '{ for (i=1;i<=NF;i++) if ($i == "pval_MID") {print i; exit}}'`

# Sieve & output to "$file_out"
# At the same time, convert from tab-delimited to space-delimited
# pval_meta_hq
if [ -z "$pos_meta_hq" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_meta_hq  < -16.8112428315) {\$1=\$1; print \"pval_meta_hq\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi

# pval_meta
if [ -z "$pos_meta" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_meta  < -16.8112428315) {\$1=\$1; print \"pval_meta\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi

# pval_AFR
if [ -z "$pos_AFR" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_AFR  < -16.8112428315) {\$1=\$1; print \"pval_AFR\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi

# pval_AMR
if [ -z "$pos_AMR" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_AMR  < -16.8112428315) {\$1=\$1; print \"pval_AMR\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi

# pval_CSA
if [ -z "$pos_CSA" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_CSA  < -16.8112428315) {\$1=\$1; print \"pval_CSA\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi

# pval_EAS
if [ -z "$pos_EAS" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_EAS  < -16.8112428315) {\$1=\$1; print \"pval_EAS\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi

# pval_EUR
if [ -z "$pos_EUR" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_EUR  < -16.8112428315) {\$1=\$1; print \"pval_EUR\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi

# pval_MID
if [ -z "$pos_MID" ] 
then
  # If there's no corresponding field, do nothing
  :
else
  str_command="zcat \"$FILE_SOURCE\" | awk -v OFS=\" \" '(\$ $pos_MID  < -16.8112428315) {\$1=\$1; print \"pval_MID\",\$0}' >> \"$FILE_OUT\""
  str_command=${str_command//\$ /\$}
  str_command=${str_command/tsv _/tsv_}
  eval $str_command
fi