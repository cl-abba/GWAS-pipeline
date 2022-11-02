#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=1:00:00
#SBATCH --job-name=qctool-subset
#SBATCH --array=1-3
#SBATCH --output=slurm-qctool-subset.out
#SBATCH --error=slurm-qctool-subset.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=5G
#SBATCH --ntasks=3

# Note: the number of batch arrays (see header of script above), corresponds to the number of regions or subset to finemap.

# Extract the chromosome number for each region:
chr=$(sed -n ${SLURM_ARRAY_TASK_ID}p FINEMAP_regions.txt | awk '{print $1}')

# Step 1: convert from VCF to BGEN, which retains the imputation information:
module load StdEnv/2020
module load qctool/2.2.0

qctool_v2.2.0 \
        -g /home/abbatan1/projects/def-eparra/CPTP/imputation-data/GSA5300/${chr}.vcf.gz -vcf-genotype-field GP \
        -incl-rsids rsids-sumstats-for-finemap-subset${SLURM_ARRAY_TASK_ID}.out \
        -og finemap-subset${SLURM_ARRAY_TASK_ID}.bgen \
        -os finemap-subset${SLURM_ARRAY_TASK_ID}.sample

# Step 2: Generate a file with the SNP information in the new files, to check that there is a full overlap between the SNPs in the BGEN subset files and the summary statistics subset files.
    ## Note: This is important because LDstore requires a full overlap of the SNPs, otherwise it will generate errors.

qctool_v2.2.0 \
        -g finemap-subset${SLURM_ARRAY_TASK_ID}.bgen -snp-stats -osnp finemap-subset${SLURM_ARRAY_TASK_ID}.txt
        
# Can check the overlap using the 'anti_join' function from Tidyverse on R, for example:
# check1 <- anti_join(rsids_bgen, rsids_sumstats, by = "rsid")
# check2 <- anti_join(rsids_sumstats, rsids_bgen, by = "rsid")
# If both are empty, everything afterwards should run correctly. Otherwise, check for SNPs that are missing rsIDs or duplicated SNPs.
