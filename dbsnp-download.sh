#!bin/sh -u
set -e

#####################
# This script downloads the dbSNP data.
#####################


echo ""
echo "Download dbSNP data..."

DIR_OUT=dbsnp/

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"
cd "$DIR_OUT"

mkdir -p 25
cd 25
wget -q https://ftp.ncbi.nih.gov/snp/archive/b155/VCF/GCF_000001405.25.gz &
wget -q https://ftp.ncbi.nih.gov/snp/archive/b155/VCF/GCF_000001405.25.gz.tbi &
cd ..

mkdir -p 39
cd 39
wget -q https://ftp.ncbi.nih.gov/snp/archive/b155/VCF/GCF_000001405.39.gz &
wget -q https://ftp.ncbi.nih.gov/snp/archive/b155/VCF/GCF_000001405.39.gz.tbi &
cd ..

wait

echo "Done."
echo ""