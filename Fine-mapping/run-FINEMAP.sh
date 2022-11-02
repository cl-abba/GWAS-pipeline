#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --job-name=finemap-GG
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem-per-cpu=5G
#SBATCH --time=1:0:0
#SBATCH --output=finemap.out
#SBATCH --error=finemap.err

# Can change the --n-causal-snps for any value between 1 and 20.
# Similar to LDstore, you can specify --dataset the subset you want to run (the default is all)
# The --force-n-samples is used when the sample size in the BGEN file is different from the GWAS sample size (indicated in the masterfiles for LDstore and FINEMAP).

./finemap_v1.4_x86_64 --sss --in-files masterfile-FINEMAP-GG.txt --log --n-causal-snps 10 --std-effects --n-threads 5 --force-n--samples
