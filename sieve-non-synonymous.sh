#!bin/sh -u
set -e

#####################
# This script filters through the dbSNP-PanUKBB lists
# and returns only the non-synonymous mutations
# Criteria: the "VC" part of dbSNP annotation ($9) contains "NSF", "NSM", "NSN"
#####################


DIR_SOURCE=PanUKBB-dbSNP/gene-region/
DIR_OUT=PanUKBB-dbSNP/non-synonymous/


echo ""
echo "Extract non-synonymous variants..."

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"


for FILE_SOURCE in $(find "$DIR_SOURCE" -type f -not -name "merged.txt"); do
  FILE_OUT=$(echo "$FILE_SOURCE" | sed "s|$DIR_SOURCE|$DIR_OUT|g")

  HEADER=$(head -n 1 "$FILE_SOURCE" | tr '\n' ' ' | tr '\r' ' ')
  echo "$HEADER" > "$FILE_OUT"

  cat "$FILE_SOURCE" | awk -F' {1}' '
  { a=$9
    # One entry may have separate "GENEINFO" and "PSEUDOGENEINFO",
    # the latter of which must be omitted from consideration
    gsub( /PSEUDOGENE.*/, "", a ) 
    gsub( /.*VC=/, "", a )
    gsub( /FREQ=.*/, "", a )
    if ((a ~ "NSF") || (a ~ "NSM") || (a ~ "NSN")) {print $0}
  }' >> "$FILE_OUT" &
done

wait

echo "Merge..."

FILE_OUT="$DIR_OUT"merged.txt

echo "$HEADER" > "$FILE_OUT"

for CHR in `seq 1 22`
do
  FILE="$DIR_OUT""$CHR".txt
  cat "$FILE" | tail +2 >> "$FILE_OUT"
done

CHR="X"
FILE="$DIR_OUT""$CHR".txt
cat "$FILE" | tail +2 >> "$FILE_OUT"

echo "Done."