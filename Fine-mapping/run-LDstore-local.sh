#!/bin/bash

#SBATCH --account=your-account
#SBATCH --job-name=ldstore-local
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem-per-cpu=5G
#SBATCH --time=1:0:0
#SBATCH --output=ldstore-local.out
#SBATCH --error=ldstore-local.err

# This is one line per subset in the masterfile (defined with the --dataset flag) and the --rsids flag indicates the SNP(s) for which LD will be calculated.
# In this case, a new masterfile is needed to output the LD in text format and not in BCOR format.
# The output will be one file per subset with the 'ld' extension, and in the file one column per SNP indicated here.

cd ldstore_v2.0_x86_64/

./ldstore_v2.0_x86_64 --in-files masterfile-LDstore-local-GG.txt --write-text --read-only-bgen --dataset 1 --rsids rs123
./ldstore_v2.0_x86_64 --in-files masterfile-LDstore-local-GG.txt --write-text --read-only-bgen --dataset 2 --rsids rs456
./ldstore_v2.0_x86_64 --in-files masterfile-LDstore-local-GG.txt --write-text --read-only-bgen --dataset 3 --rsids rs789
