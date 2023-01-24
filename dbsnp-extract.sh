#!bin/sh -u
set -e

#####################
# This script extracts per-chromosome dbSNP data.
#####################


echo ""
echo "Extract per chromosome..."

DIR_SOURCE=dbsnp/25/
DIR_OUT=dbsnp/25/per-chromosome/

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"

tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000001.10 >> "$DIR_OUT"1.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000002.11 >> "$DIR_OUT"2.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000003.11 >> "$DIR_OUT"3.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000004.11 >> "$DIR_OUT"4.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000005.9 >> "$DIR_OUT"5.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000006.11 >> "$DIR_OUT"6.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000007.13 >> "$DIR_OUT"7.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000008.10 >> "$DIR_OUT"8.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000009.11 >> "$DIR_OUT"9.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000010.10 >> "$DIR_OUT"10.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000011.9 >> "$DIR_OUT"11.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000012.11 >> "$DIR_OUT"12.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000013.10 >> "$DIR_OUT"13.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000014.8 >> "$DIR_OUT"14.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000015.9 >> "$DIR_OUT"15.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000016.9 >> "$DIR_OUT"16.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000017.10 >> "$DIR_OUT"17.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000018.9 >> "$DIR_OUT"18.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000019.9 >> "$DIR_OUT"19.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000020.10 >> "$DIR_OUT"20.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000021.8 >> "$DIR_OUT"21.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000022.10 >> "$DIR_OUT"22.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000023.10 >> "$DIR_OUT"23.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_000024.9 >> "$DIR_OUT"24.csv &
tabix "$DIR_SOURCE"GCF_000001405.25.gz NC_012920.1 >> "$DIR_OUT"25.csv &
#

wait

echo ""
echo "Done."