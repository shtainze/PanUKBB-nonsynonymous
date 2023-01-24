#!bin/sh -u
set -e


# The number of parallel jobs
# Change according to your local environment
N_PARALLEL=20


# Prepare Pan-UKBB data
bash panukbb-manifest.sh
# It is safe to run the download process more than once, as massive download may fail on the way
bash panukbb-download.sh "$N_PARALLEL" 1
bash panukbb-download.sh "$N_PARALLEL" 0
bash panukbb-download.sh "$N_PARALLEL" 0
bash panukbb-filter-significant-wrap.sh "$N_PARALLEL"
python panukbb-unite-fields.py
bash panukbb-merge-sort.sh
bash panukbb-format-for-join.sh


# Prepare dbSNP data
bash dbsnp-download.sh
bash dbsnp-extract.sh
bash dbsnp-split-wrap.sh
bash dbsnp-format-for-join.sh


# Combine Pan-UKBB + dbSNP
bash link-dbsnp-wrap.sh

# Do some tricks on the combined dataset
bash sieve-gene-region.sh