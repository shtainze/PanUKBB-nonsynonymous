# PanUKBB-nonsynonymous
Extract non-synonymous mutations from Pan-UKBB database

## Summary
Pan-UKBB (https://pan.ukbb.broadinstitute.org/) is a massive GWAS database based on UKBiobank (https://www.ukbiobank.ac.uk/) data. It applyed a unified association analysis pipeline onto 7,228 non-bulk data fields of UKBiobank x 28,987,535 variants on human genome, resulting in = ~200 billion entries in total.

To make that huge data easier to handle and comprehend, the following filters are applied here:
- Statistically significant (P < 5e-8)
- Non-synonymous mutations

These filters effectively narrow down the ~209 billion entries to only ~0.4 million.

## Directory structure
- The final product containing the ~0.4 million entries can be found on:
`non_synonymous_all_info.txt`
- If you'd like to reproduce or modify the output, see "Pipeline" below.


## Pipeline
- The whole pipeline requires `bash` and `Python`.
- If you'd like to run the whole pipeline automatically, just run `bash process-all.sh`. To run the subprocesses independently, see what's called in that shell script.
