#!bin/sh -u
set -e

#####################
# This script scans the dbSNP table, 
# finds rows with more than one "alt" entries, and
# split such rows into multiple rows, each with just one "alt" entry
#####################

FILE_SOURCE=$1
FILE_OUT=$2
rm -f "$FILE_OUT"

while read LINE_SOURCE; do
	IFS=$'\t' read -ra FIELDS <<< "$LINE_SOURCE"

	# If the split should be done
	if [[ ${FIELDS[4]} == *","* ]]; then
		ALT_ALLELES=${FIELDS[4]}
		IFS="," read -r -a ALT_ALLELES <<< "$ALT_ALLELES"
		for ALT in "${ALT_ALLELES[@]}"; do
		  # Replace the fifth field with the i-th character of the fifth field
		  FIELDS[4]=$ALT
		  # Join the fields back into a tab-separated string
		  LINE_OUTPUT=$(IFS=$'\t'; echo "${FIELDS[*]}")
		  # Print the modified line
		  echo "$LINE_OUTPUT" >> "$FILE_OUT"
		done
	else
		echo "$LINE_SOURCE" >> "$FILE_OUT"
	fi
done < "$FILE_SOURCE"



