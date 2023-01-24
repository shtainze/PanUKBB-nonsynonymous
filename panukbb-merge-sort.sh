#!bin/sh -u
set -e

#####################
# This script merges all the files in the specified directory
# After the merge, this script sorts the entries according to:
# $3: chr
# $4: pos
# $5: ref
# $6: alt
# And writes the result to $FILE_SORTED
#####################

#cd per_phenotype/fields-united


DIR_SOURCE=per-phenotype/fields-united/
DIR_OUT=per-phenotype/merged/
FILE_MERGED="$DIR_OUT"merged.txt

# Delete files
rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"


echo ""
echo "Merge..."

# Count up iterations to produce intermediate outputs
ITER=0

# Get the header row (from an arbitrary file)
HEADER=$(head -n 1 "$DIR_SOURCE"categorical-1707-both_sexes-1.txt | tr '\n' ' ')
HEADER=$(echo "$HEADER" | tr '\r' ' ')
echo "$HEADER" > "$FILE_MERGED"

# Iterate over all the files in the directory except for the output file
for FILE in $(find "$DIR_SOURCE" -not -name "$FILE_MERGED" -type f); do
  # Print message for every 100 files
  ITER=$((ITER + 1))
  if [ $((ITER % 100)) -eq 0 ]; then
    echo "Processing file" "$ITER:" "$FILE"
  fi

  # Concatenate the file to the output file
  tail -n +2 "$FILE" >> "$FILE_MERGED"
done

echo "Split to chromosomes..."

for CHR in `seq 1 22`
do
  FILE_OUT="$DIR_OUT""$CHR".txt
  echo "$HEADER" > "$FILE_OUT"
  cat "$FILE_MERGED" | awk -F' {1}' -v CHR=$CHR '{if ($3 == CHR) {print $0}}' | sort -k3,3 -k4,4 -k5,5 -k6,6 -n >> "$FILE_OUT" &
done

# Chromosome X
FILE_OUT="$DIR_OUT"X.txt
echo "$HEADER" > "$FILE_OUT"
cat "$FILE_MERGED" | awk -F' {1}' '{if ($3 == "X") {print $0}}' >> "$FILE_OUT" &

wait

echo ""
echo "Done."