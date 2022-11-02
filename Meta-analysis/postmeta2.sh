#!/bin/bash

##SBATCH --account=your-CC-account
#SBATCH --time=1:00:00
#SBATCH --job-name=generate-meta-files
#SBATCH --output=generate-meta-files.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=3G

# Create files for QQ plot, Manhattan plot and list of top SNPs for fixed and random effects models:

# Generate file with only p-values (used for Q-Q plot):
awk '{print $6}' meta-pheno-clean.out > meta_FE_pvalQQ.out # Note: print $11 if you wish this file to be based on RE2 p values, and print $14 if you wish this file to beased on Q p values

# Generate file with chr, pos and p-value (used for Manhattan plot):
awk '{print $1, $2, $6}' meta-pheno-clean.out > meta_FE_pvalManhattan.out # Note: print $1, $2, $11 for RE2 p values and print $1, $2, $14 for Q p values

# Filter file for p-value threshold 1e-6 (which suggests an association):
awk 'NR==1; $6 < 0.00001' meta-pheno-clean.out > meta_FE_topSNPs.out # Note: $11 < 0.00001 for top SNPs based on RE2 p values and $14 < 0.00001 for top SNPs based on Q p values
