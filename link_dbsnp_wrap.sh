#!bin/sh -u
set -e

#####################
# This script executes "link_dbsnp.sh" in a parallel manner.
# Parallel execution could be done but it takes much memory,
# so it has not been implemented yet.
#####################


DIR_PANUKBB=per-phenotype/formatted/
DIR_DBSNP=dbsnp/25/formatted/
DIR_OUT=PanUKBB-dbSNP/linked/

echo ""
echo "Join Pan-UKBB & dbSNP databases..."

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"


function single {
  DIR_PANUKBB=$1
  DIR_DBSNP=$2
  DIR_OUT=$3
  CHR=$4

  FILE_SOURCE="$DIR_PANUKBB""$CHR".txt
  FILE_SNP="$DIR_DBSNP""$CHR".txt
  FILE_OUT="$DIR_OUT""$CHR".txt
  bash link_dbsnp.sh "$FILE_SOURCE" "$FILE_SNP" "$FILE_OUT"
}

single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 1 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 2 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 3 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 4 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 5 &
wait

# Chr6 is huge
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 6 &
wait

single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 7 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 8 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 9 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 10 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 11 &
wait

single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 12 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 13 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 14 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 15 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 16 &
wait

single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 17 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 18 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 19 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 20 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 21 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" 22 &
single "$DIR_PANUKBB" "$DIR_DBSNP" "$DIR_OUT" X &
wait

# for CHR in `seq 1 22`
# do
#   FILE_SOURCE="$DIR_PANUKBB""$CHR".txt
#   FILE_SNP="$DIR_DBSNP""$CHR".txt
#   FILE_OUT="$DIR_OUT""$CHR".txt
#   bash link_dbsnp.sh "$FILE_SOURCE" "$FILE_SNP" "$FILE_OUT"
# done

# CHR="X"
# FILE_SOURCE="$DIR_PANUKBB""$CHR".txt
# FILE_SNP="$DIR_DBSNP""$CHR".txt
# FILE_OUT="$DIR_OUT""$CHR".txt
# bash link_dbsnp.sh "$FILE_SOURCE" "$FILE_SNP" "$FILE_OUT"

# echo "Done."