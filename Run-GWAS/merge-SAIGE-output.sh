#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=1:00:00
#SBATCH --job-name=merge-SAIGE-output
#SBATCH --output=merge-SAIGE-output.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=3G

# Get header (first) row:
awk 'NR==1' /path-to-SAIGE-output/chr1.out > /path-to-output/tmp_output.out

# Merge all chromosomes into one file:
for i in {1..22}
do 
awk 'NR>1' /path-to-SAIGE-output/chr${i}filename.out >> /path-to-output/tmp_output.out
done

# Create compressed file with raw output (.tar.gz):
tar -cvzf /path-to-tmp-files/tmp_output.tar.gz /path-to-output/tmp_output.out

# Remove where p-value = NA:
awk '$13!=”NA”' /path-to-tmp-files/tmp_output.out > /path-to-output/tmp1_output.out

# Remove SNPs with effect size = NA:
awk '$10!=”NA”' /path-to-tmp-files/tmp1_output.out > /path-to-output/tmp2_output.out

# Remove SNPs that did not converge:
awk '$15!=0'/path-to-tmp-files/tmp2_output.out > /path-to-output/tmp3_output.out

# Arrange columns:
awk '{print $3, $1, $2, $4, $5, $7, $8, $9, $10, $11, $13}' /path-to-tmp-files/tmp3_output.out > /path-to-output/tmp4_output.out

# Filter file with INFO threshold of 0.3:
awk '$7 > 0.3' /path-to-tmp-files/tmp4_output.out > /path-to-output/tmp5_output.out

# Filter file with MAF threshold 0.01 (recommended by SAIGE), this will be the final clean file:
awk '$6 > 0.01' /path-to-tmp-files/tmp5_output.out > /path-to-output/clean-output.out

# Filter file for p-value threshold 1e-6 (which suggests an association):
awk 'NR==1; $11 < 0.00001' /path-to-cleaned-file/clean-output.out > /path-to-output/output-topSNPs.out

# Generate file with only p-values (used for Q-Q plot):
awk '{print $11}' /path-to-cleaned-files/clean-output.out > /path-to-output/output-pvalQQ.out

# Generate file with rsid, chr, pos and p-value (used for Manhattan plot):
awk '{print $1, $2, $3, $11}' /path-to-cleaned-files/clean-output.out > /path-to-output/output-pvalManhattan.out
