#!bin/sh -u
set -e

##########################
# This script executes panukbb-filter-significant.sh in a parallel manner
# The number of jobs is kept constant to $N_PARALLEL
##########################

PATH_SOURCE=per-phenotype/raw/
PATH_OUT=per-phenotype/significant/

rm -rf "$PATH_OUT"
mkdir -p "$PATH_OUT"

# Set the maximum number of parallel jobs
N_PARALLEL=$1

# Create a list of files to process
FILES_SOURCE=$(find "$PATH_SOURCE" -type f | sort)

# Initialize a counter for the number of jobs
JOB_COUNT=0

# Count up iterations to produce intermediate outputs
ITER=0


echo ""
echo "Extract the significant entries from Pan-UKBB per-phenotype files..."
echo "Criteria: P < 5e-8"
echo "Message will be shown for every 100 files"


# Iterate over the list of files
for FILE_SOURCE in $FILES_SOURCE; do

  # Print message for every 100 files
  ITER=$((ITER + 1))
  if [ $((ITER % 100)) -eq 0 ]; then
    echo "$ITER:" "$FILE_SOURCE"
  fi

  FILE_OUT=$(echo "$FILE_SOURCE" | sed "s|$PATH_SOURCE|$PATH_OUT|g")
  FILE_OUT=$(echo "$FILE_OUT" | sed 's|tsv.bgz|txt|')

  echo "$FILE_SOURCE", "$FILE_OUT"

  # Process the file in the background
  #bash panukbb-filter-significant.sh "$FILE_SOURCE" "$FILE_OUT" &

  # Increment the job count
  JOB_COUNT=$((JOB_COUNT+1))

  # If the job count has reached the maximum, wait for one job to finish
  if [ "$JOB_COUNT" -ge "$N_PARALLEL" ]; then
    wait -n
    JOB_COUNT=$((JOB_COUNT-1))
  fi
done

# Wait for all remaining jobs to finish
wait

echo "All files have been processed."