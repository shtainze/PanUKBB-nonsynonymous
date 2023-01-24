#!bin/sh -u
set -e

#####################
# This script makes a dbSNP table compatible with the later `join` function.
# The `join` should be based on ALL of "pos,ref,alt",
# but the `join` function only accepts one field for comparison.
# Therefore, in this script, the "pos,ref,alt" fields are joined together to
# produce a new single field.
#####################


DIR_SOURCE=dbsnp/25/split/
DIR_OUT=dbsnp/25/formatted/

echo ""
echo "Format (for joining to Pan-UKBB database)..."

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"


function single {
	FILE_SOURCE=$1
	FILE_OUT=$2
	cat "$FILE_SOURCE" | awk -F'\t' -v OFS=" " '{$1=$1; print $2"_"$4"_"$5,$0}' > "$FILE_OUT"
}

single "$DIR_SOURCE"1.csv "$DIR_OUT"1.txt &
single "$DIR_SOURCE"2.csv "$DIR_OUT"2.txt &
single "$DIR_SOURCE"3.csv "$DIR_OUT"3.txt &
single "$DIR_SOURCE"4.csv "$DIR_OUT"4.txt &
single "$DIR_SOURCE"5.csv "$DIR_OUT"5.txt &
single "$DIR_SOURCE"6.csv "$DIR_OUT"6.txt &
single "$DIR_SOURCE"7.csv "$DIR_OUT"7.txt &
single "$DIR_SOURCE"8.csv "$DIR_OUT"8.txt &
single "$DIR_SOURCE"9.csv "$DIR_OUT"9.txt &
single "$DIR_SOURCE"10.csv "$DIR_OUT"10.txt &
single "$DIR_SOURCE"11.csv "$DIR_OUT"11.txt &
single "$DIR_SOURCE"12.csv "$DIR_OUT"12.txt &
single "$DIR_SOURCE"13.csv "$DIR_OUT"13.txt &
single "$DIR_SOURCE"14.csv "$DIR_OUT"14.txt &
single "$DIR_SOURCE"15.csv "$DIR_OUT"15.txt &
single "$DIR_SOURCE"16.csv "$DIR_OUT"16.txt &
single "$DIR_SOURCE"17.csv "$DIR_OUT"17.txt &
single "$DIR_SOURCE"18.csv "$DIR_OUT"18.txt &
single "$DIR_SOURCE"19.csv "$DIR_OUT"19.txt &
single "$DIR_SOURCE"20.csv "$DIR_OUT"20.txt &
single "$DIR_SOURCE"21.csv "$DIR_OUT"21.txt &
single "$DIR_SOURCE"22.csv "$DIR_OUT"22.txt &
single "$DIR_SOURCE"23.csv "$DIR_OUT"X.txt &
single "$DIR_SOURCE"24.csv "$DIR_OUT"Y.txt &
single "$DIR_SOURCE"25.csv "$DIR_OUT"MT.txt &

wait

echo "Done."