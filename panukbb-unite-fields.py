#####################
# Each of the per-phenotype files downloaded from Pan-UKBB
# has a different set of fields (columns), depending on:
# 	Whether the phenotype is categorical or numerical
# 	Whether the GWAS passed QCs
# Therefore, before joining these per-phenotype files,
# some empty fields (columns) must be inserted to
# produce the same set of fields.
#####################

import os
import pandas as pd
import shutil
os.chdir("per-phenotype")

l_cols_all = ["phenotype_file",
              "significant_field", "chr", "pos", "ref", "alt",
          "af_meta", "af_cases_meta", "af_controls_meta", 
          "beta_meta", "se_meta", "pval_meta", "pval_heterogeneity",
          "af_meta_hq", "af_cases_meta_hq", "af_controls_meta_hq", 
          "beta_meta_hq", "se_meta_hq", "pval_meta_hq", "pval_heterogeneity_hq",
          "af_AFR", "af_AMR", "af_CSA", "af_EAS", "af_EUR", "af_MID", 
          "af_cases_AFR", "af_cases_AMR", "af_cases_CSA", 
          "af_cases_EAS", "af_cases_EUR", "af_cases_MID",
          "af_controls_AFR", "af_controls_AMR", "af_controls_CSA",
          "af_controls_EAS", "af_controls_EUR", "af_controls_MID", 
          "beta_AFR", "beta_AMR", "beta_CSA", "beta_EAS", "beta_EUR", "beta_MID",
          "se_AFR", "se_AMR", "se_CSA", "se_EAS", "se_EUR", "se_MID",
          "pval_AFR", "pval_AMR", "pval_CSA", "pval_EAS", "pval_EUR", "pval_MID", 
          "low_confidence_AFR", "low_confidence_AMR", "low_confidence_CSA",
          "low_confidence_EAS", "low_confidence_EUR", "low_confidence_MID"
         ]


print()
print("Unite the format of per-phenotype files")
print("Message will be shown for every 1,10,100 files")

dir_source = "significant"
dir_out = "fields-united"

if os.path.exists(dir_out):
	shutil.rmtree(dir_out)
os.makedirs(dir_out)


# Print the progress
i_iter = 0

l_files = os.listdir(dir_source)
l_files = sorted(l_files)

for file_source in l_files:
    i_iter += 1
    
    if (i_iter < 10):
        print("Processing file #", i_iter, ":", file_source)
    
    if (i_iter < 100) and (i_iter % 10 == 0):
        print("Processing file #", i_iter, ":", file_source)
    
    if i_iter % 100 == 0:
        print("Processing file #", i_iter, ":", file_source)
    
    path_source = os.path.join(dir_source, file_source)
    # Skip empty files
    if os.stat(path_source).st_size == 0:
        continue
    # Read as str to avoid any automatic conversion
    df_source = pd.read_csv(path_source, sep=' ', dtype=str)
    # Skip empty files
    if df_source.shape[0] == 0:
        continue
        
    # Add columns
    df_source['phenotype_file'] = file_source
    l_cols_source = list(df_source.columns)
    if not set(l_cols_source).issubset(set(l_cols_all)):
        print("Part of the columns is not included in the new file!")
    df_reordered = df_source.reindex(columns=l_cols_all)
    
    # Save
    path_out = os.path.join(dir_out, file_source)
    df_reordered.to_csv(path_out, index=False, sep=" ")


print()
print("Done.")