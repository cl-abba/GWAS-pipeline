#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=30:00:00
#SBATCH --job-name=filter
#SBATCH --output=filter.sh
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=20G

module load StdEnv/2020 gcc/9.3.0 bcftools/1.13

for i in {1..22}
do

# Check to see how many markers there are initially:
    bcftools query -f '%POS\n' /path-to-vcf-files/chr${i}.vcf.gz | wc -l;

# Remove low imputed markers:
    bcftools filter -i 'INFO>0.8' /path-to-vcf-files/chr${i}.vcf.gz -Oz > chr${i}tmp1.vcf.gz;

# Check to see how many markers were removed - included at every stage to keep track of how many markers are removed with each filter:
    bcftools query -f '%POS\n' /path-to-tmp1-files/chr${i}tmp1.vcf.gz | wc -l;

# Remove SNPs that are multiallelic:
    bcftools filter -i 'TYPE="snp" && INFO>0.8' /path-to-tmp1-files/chr${i}tmp1.vcf.gz -Oz > chr${i}tmp2.vcf.gz;

# Check to see how many markers were removed:
    bcftools query -f '%POS\n' /path-to-tmp2-files/chr${i}tmp2.vcf.gz | wc -l;

# Ensure that there are only SNPs in the dataset:
    bcftools view -m2 -M2 -v snps /path-to-tmp2-files/chr${i}tmp2.vcf.gz -Oz > chr${i}tmp3.vcf.gz;

# Check to see how many markers were removed:
    bcftools query -f '%POS\n' /path-to-tmp3-files/chr${i}tmp3.vcf.gz | wc -l;

# Retrieve only chromosome and position from the vcf:
    bcftools query -f '%CHROM\t%POS\n' /path-to-tmp3-files/chr${i}tmp3.vcf.gz > pos-chr${i};

# Retrieve only duplicated positions:
    uniq -d /path-to-pos-file/pos-chr${i} > pos-chr${i}-duplicated;

# Remove duplicated positions from the vcf file:
    bcftools view -T ^pos-chr${i}-duplicated chr${i}tmp3.vcf.gz -Oz > chr${i}outputprefix.vcf.gz;
    
# Last check to see how many markers were removed:
    bcftools query -f '%POS\n' /path-to-final-output-files/chr${i}filename.vcf.gz | wc -l;

done
