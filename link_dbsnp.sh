#!bin/sh -u
set -e

#####################
# This script merges the dbSNP table and the SNP lists from Pan-UKBB
# Both files have strings denoting "pos_ref_alt" in the first column (e.g. "15453119_T_A")
# The former file is non-redundant, while the latter file
# might contain multiple records with the same "pos_ref_alt" sequences, derived from 
# different Pan-UKBB GWAS.
# Therefore, a one-to-many match should be done here.
#####################

FILE_SOURCE=$1
FILE_SNP=$2
FILE_OUT=$3


FILE_SOURCE_SORTED=$(echo "$FILE_SOURCE" | sed 's|.txt|_sorted.txt|')
# somehow \r is included in the original file, so delete it

sed 's/\r//g' "$FILE_SOURCE" | sort -k1,1 > "$FILE_SOURCE_SORTED" &

FILE_SNP_SORTED=$(echo "$FILE_SNP" | sed 's|.txt|_sorted.txt|')
sort -k1,1 "$FILE_SNP" > "$FILE_SNP_SORTED" &

wait


# This awk command reads both file1 and file2 and
# stores the records of file1 in an array a indexed by the first field.
# Then, for each record in file2, it checks if 
# the first field is present in the array a.
# If it is, it prints the corresponding record from
# file1 (stored in the array) along with the current record from file2.

awk -F' {1}' '
# For each record in file1
NR==FNR {
  # Store the record in the array "a" using the first field as the key
  a[$1]=$0;
  # Skip to the next record
  next;
}

# For each record in file2
{
  # If the first field exists in the array "a"
  if($1 in a) {
    # Print the record from file1 (stored in the array "a") followed by the record from file2
    print a[$1], $0;
  }
}' "$FILE_SNP_SORTED" "$FILE_SOURCE_SORTED" > "$FILE_OUT"