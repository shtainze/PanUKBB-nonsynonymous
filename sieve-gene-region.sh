#!bin/sh -u
set -e

#####################
# This script filters through the merged dbSNP-PanUKBB lists
# and returns only the variants affecting gene regions
# Criteria: dbSNP annotation ($9) contains "GENEINFO"
#####################

DIR_SOURCE=PanUKBB-dbSNP/linked/
DIR_TEMP=PanUKBB-dbSNP/temp/
DIR_OUT=PanUKBB-dbSNP/gene-region/

echo ""
echo "Extract the entries containing 'GENEINFO'..."

rm -rf "$DIR_TEMP"
mkdir -p "$DIR_TEMP"

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"


IFS=" "
FILES=$(find "$DIR_SOURCE" -mindepth 1 -maxdepth 1 -print0 | xargs -0)
read -a FILES <<< "$FILES"

for FILE_SOURCE in "${FILES[@]}"; do
  FILE_TEMP="$FILE_SOURCE"
  FILE_TEMP=$(echo "$FILE_TEMP" | sed "s|$DIR_SOURCE|$DIR_TEMP|g")

  # Write the header row
  HEADER=$(head -n 1 "$FILE_SOURCE" | tr '\n' ' ' | tr '\r' ' ')
  echo "$HEADER" > "$FILE_TEMP"

  cat "$FILE_SOURCE" | awk -F' {1}' '{if ($9 ~ "GENEINFO") {print $0}}' >> "$FILE_TEMP" &
done

wait

echo "Omit 'PSEUDOGENEINFO'..."

IFS=$'\n'

for FILE_TEMP in $(find "$DIR_TEMP" -type f); do
  FILE_OUT="$FILE_TEMP"
  FILE_OUT=$(echo "$FILE_OUT" | sed "s|$DIR_TEMP|$DIR_OUT|g")

  # Write the header row
  HEADER=$(head -n 1 "$FILE_TEMP" | tr '\n' ' ' | tr '\r' ' ')
  echo "$HEADER" > "$FILE_OUT"

  cat "$FILE_TEMP" | awk -F' {1}' '
  {
    a=$9
    gsub(/PSEUDOGENEINFO.*/, "", a)
    if (a ~ "GENEINFO") {print $0}
  }' >> "$FILE_OUT" &
done

wait

echo "Merge..."

FILE_OUT="$DIR_OUT"merged.txt
echo "$HEADER" > "$FILE_OUT"

for CHR in `seq 1 22`
do
  FILE="$DIR_TEMP"/"$CHR".txt
  cat "$FILE" | tail -n +2 >> "$FILE_OUT"
done

CHR="X"
FILE="$DIR_TEMP"/"$CHR".txt
cat "$FILE" | tail -n +2 >> "$FILE_OUT"

echo "Done."