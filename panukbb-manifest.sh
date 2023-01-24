#!bin/sh -u
set -e

#####################
# This script downloads the Pan-UKBB manifest file.
#####################

DIR_OUT=manifest/
FILE_MANIFEST=manifest/phenotype_manifest.tsv
FILE_LINK=manifest/download_links.tsv

echo ""
echo "Download Pan-UKBB manifest file..."

rm -rf "$DIR_OUT"
mkdir -p "$DIR_OUT"
wget -q https://pan-ukb-us-east-1.s3.amazonaws.com/sumstats_release/phenotype_manifest.tsv.bgz -P "$DIR_OUT"
mv "$DIR_OUT"phenotype_manifest.tsv.bgz "$DIR_OUT"phenotype_manifest.tsv.gz

echo "Extract..."
gzip -d -k "$DIR_OUT"phenotype_manifest.tsv.gz

# Extract the download links for Pan-UKBB per-phenotype files
cat "$FILE_MANIFEST" |
awk -F'\t' '{gsub("s3://pan-ukb-us-east-1", "https://pan-ukb-us-east-1.s3.amazonaws.com", $77)
print $77}' | tail -n +2 >> "$FILE_LINK"

echo "Done."