#!bin/sh -u
set -e

#####################
# This script downloads all the Pan-UKBB per-phenotype files.
# The number of jobs is kept constant to $N_PARALLEL
#####################

FILE_LINK=manifest/download_links.tsv
DIR_OUT=per-phenotype/raw/

# The number of parallel jobs
N_PARALLEL=$1

# First round or the check round
FIRST_TIME=$2

# Initialize a counter for the number of jobs
JOB_COUNT=0


if [ "$FIRST_TIME" -eq 1 ]; then
  rm -rf "$DIR_OUT"
  mkdir -p "$DIR_OUT"
fi

echo ""
echo "Download Pan-UKBB per-phenotype files..."
echo "Message will be shown for every 100 files"


# Count up iterations to produce intermediate outputs
ITER=0

IFS=","
while read LINK; do
  PREFIX=https://pan-ukb-us-east-1.s3.amazonaws.com/sumstats_flat_files/
  FILE_DOWNLOADED=$(echo "$LINK" | sed "s|$PREFIX|$DIR_OUT|g")


  # Print message for every 100 files
  ITER=$((ITER + 1))
  if [ $((ITER % 100)) -eq 0 ]; then
    echo "$ITER", "$FILE_DOWNLOADED"
  fi
  

  # Check if the file exists locally
  if [ -f "$FILE_DOWNLOADED" ]; then
    # Get the size of the local file
    SIZE_LOCAL=$(stat --format=%s "$FILE_DOWNLOADED")
    # Get the size of the file on the server
    SIZE_SERVER=$(wget --spider --server-response "$LINK" 2>&1 | grep 'Content-Length' | awk '{print $2}')
    # Compare the sizes
    if [ "$SIZE_LOCAL" -ne "$SIZE_SERVER" ]; then
      # The file was not fully downloaded, so resume the download
      :
      wget -q --continue "$LINK" -O "$FILE_DOWNLOADED" -P "$DIR_OUT" &
      JOB_COUNT=$((JOB_COUNT+1))
    else
      # The file was fully downloaded
      :
    fi
  else
    # The file does not exist locally, so download it
    :
    wget -q "$LINK" -O "$FILE_DOWNLOADED" -P "$DIR_OUT" &
    JOB_COUNT=$((JOB_COUNT+1))
  fi


  # If the job count has reached the maximum, wait for one job to finish
  if [ "$JOB_COUNT" -ge "$N_PARALLEL" ]; then
    wait -n
    JOB_COUNT=$((JOB_COUNT-1))
  fi

done < "$FILE_LINK"

wait

echo "Done."