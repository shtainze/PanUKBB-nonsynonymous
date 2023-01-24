#!bin/sh -u
set -e

#####################
# This script makes a dbSNP table compatible with the later `join` function.
# The `join` should be based on ALL of "pos,ref,alt",
# but the `join` function only accepts one field for comparison.
# Therefore, in this script, the "pos,ref,alt" fields are joined together to
# produce a new single field.
#####################

DIR_SOURCE=per-phenotype/merged/
DIR_OUT=per-phenotype/formatted/

echo ""
echo "Format (for joining to dbSNP database)..."

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"

function single {
	FILE_SOURCE=$1
	FILE_OUT=$2
	echo "Process" $FILE_SOURCE " -> " $FILE_OUT
	rm -f "$FILE_OUT"
	cat "$FILE_SOURCE" | awk -F' {1}' '{$1=$1; print $4"_"$5"_"$6,$0}' > "$FILE_OUT"
}

single "$DIR_SOURCE"1.txt "$DIR_OUT"1.txt &
single "$DIR_SOURCE"2.txt "$DIR_OUT"2.txt &
single "$DIR_SOURCE"3.txt "$DIR_OUT"3.txt &
single "$DIR_SOURCE"4.txt "$DIR_OUT"4.txt &
single "$DIR_SOURCE"5.txt "$DIR_OUT"5.txt &
single "$DIR_SOURCE"6.txt "$DIR_OUT"6.txt &
single "$DIR_SOURCE"7.txt "$DIR_OUT"7.txt &
single "$DIR_SOURCE"8.txt "$DIR_OUT"8.txt &
single "$DIR_SOURCE"9.txt "$DIR_OUT"9.txt &
single "$DIR_SOURCE"10.txt "$DIR_OUT"10.txt &
single "$DIR_SOURCE"11.txt "$DIR_OUT"11.txt &
single "$DIR_SOURCE"12.txt "$DIR_OUT"12.txt &
single "$DIR_SOURCE"13.txt "$DIR_OUT"13.txt &
single "$DIR_SOURCE"14.txt "$DIR_OUT"14.txt &
single "$DIR_SOURCE"15.txt "$DIR_OUT"15.txt &
single "$DIR_SOURCE"16.txt "$DIR_OUT"16.txt &
single "$DIR_SOURCE"17.txt "$DIR_OUT"17.txt &
single "$DIR_SOURCE"18.txt "$DIR_OUT"18.txt &
single "$DIR_SOURCE"19.txt "$DIR_OUT"19.txt &
single "$DIR_SOURCE"20.txt "$DIR_OUT"20.txt &
single "$DIR_SOURCE"21.txt "$DIR_OUT"21.txt &
single "$DIR_SOURCE"22.txt "$DIR_OUT"22.txt &
single "$DIR_SOURCE"X.txt "$DIR_OUT"X.txt &

wait

echo "Done."