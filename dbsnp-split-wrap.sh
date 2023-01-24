#!bin/sh -u
set -e

#####################
# This script executes "dbsnp-split.sh" in a parallel manner.
#####################


DIR_SOURCE=dbsnp/25/per-chromosome/
DIR_OUT=dbsnp/25/split/


echo ""
echo "Split dbSNP entries with multiple alt alleles..."


rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"

bash dbsnp-split.sh "$DIR_SOURCE"1.csv "$DIR_OUT"1.csv &
bash dbsnp-split.sh "$DIR_SOURCE"2.csv "$DIR_OUT"2.csv &
bash dbsnp-split.sh "$DIR_SOURCE"3.csv "$DIR_OUT"3.csv &
bash dbsnp-split.sh "$DIR_SOURCE"4.csv "$DIR_OUT"4.csv &
bash dbsnp-split.sh "$DIR_SOURCE"5.csv "$DIR_OUT"5.csv &
bash dbsnp-split.sh "$DIR_SOURCE"6.csv "$DIR_OUT"6.csv &
bash dbsnp-split.sh "$DIR_SOURCE"7.csv "$DIR_OUT"7.csv &
bash dbsnp-split.sh "$DIR_SOURCE"8.csv "$DIR_OUT"8.csv &
bash dbsnp-split.sh "$DIR_SOURCE"9.csv "$DIR_OUT"9.csv &
bash dbsnp-split.sh "$DIR_SOURCE"10.csv "$DIR_OUT"10.csv &
bash dbsnp-split.sh "$DIR_SOURCE"11.csv "$DIR_OUT"11.csv &
bash dbsnp-split.sh "$DIR_SOURCE"12.csv "$DIR_OUT"12.csv &
bash dbsnp-split.sh "$DIR_SOURCE"13.csv "$DIR_OUT"13.csv &
bash dbsnp-split.sh "$DIR_SOURCE"14.csv "$DIR_OUT"14.csv &
bash dbsnp-split.sh "$DIR_SOURCE"15.csv "$DIR_OUT"15.csv &
bash dbsnp-split.sh "$DIR_SOURCE"16.csv "$DIR_OUT"16.csv &
bash dbsnp-split.sh "$DIR_SOURCE"17.csv "$DIR_OUT"17.csv &
bash dbsnp-split.sh "$DIR_SOURCE"18.csv "$DIR_OUT"18.csv &
bash dbsnp-split.sh "$DIR_SOURCE"19.csv "$DIR_OUT"19.csv &
bash dbsnp-split.sh "$DIR_SOURCE"20.csv "$DIR_OUT"20.csv &
bash dbsnp-split.sh "$DIR_SOURCE"21.csv "$DIR_OUT"21.csv &
bash dbsnp-split.sh "$DIR_SOURCE"22.csv "$DIR_OUT"22.csv &
bash dbsnp-split.sh "$DIR_SOURCE"23.csv "$DIR_OUT"23.csv &
bash dbsnp-split.sh "$DIR_SOURCE"24.csv "$DIR_OUT"24.csv &
bash dbsnp-split.sh "$DIR_SOURCE"25.csv "$DIR_OUT"25.csv &

wait

echo "Done."