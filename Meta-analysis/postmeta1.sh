#!/bin/bash
#SBATCH --account=your-CC-account
#SBATCH --time=01:00:00
#SBATCH --job-name=post-meta
#SBATCH --error=post-meta.err
#SBATCH --output=post-meta.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=1G

# After finishing the meta-analysis, run the following command to merge the chromosomes, and then create a short version (chr, pos, pvalue-R2, Q, pvalue-Q):

awk 'NR==1' meta-output-chr1.out > outputprefix-pheno.out

for i in {1..22}
do
    awk 'NR>1' meta-output-chr${i}.out >> outputprefix-pheno.out 
done

# Create clean file:
awk 'NR > 1 {print $1,$2,$3,$4,$5,$7,$8,$9,$13,$14,$15}' outputprefix-pheno.out >> tmp-pheno.out

# Can separate the CHR:POS afterwards, or find rsIDs afterwards as well.

# Separate the SNP IDs to recover chr, pos, A1 and A2:
sed -i 's/:/ /g' /tmp-pheno.out
sed -i 's/\t/ /g' /tmp-pheno.out

#Create a label.txt file with the header CHR POS A1 A2 STUDY PVALUE_FE BETA_FE STD_FE BETA_RE STD_RE PVALUE_RE2 I_SQUARE Q PVALUE_Q:
cat label.txt tmp-pheno.out > /meta-pheno-clean.out

