#!/bin/bash

#SBATCH --account=your-account
#SBATCH --job-name=ldstore
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem-per-cpu=5G
#SBATCH --time=1:0:0
#SBATCH --output=ldstore.out
#SBATCH --error=ldstore.err

cd path-to-ldstore/ldstore_v2.0_x86_64/ # Note: If you have downloaded ldstore to a server in the tar format, do not forget to unpack it

./ldstore_v2.0_x86_64 --in-files masterfile-LDstore.txt --write-bcor --read-only-bgen 

# Note: The --dataset flag can be used to specificy which subsets (or lines) from the masterfile you want to run. You do not have to include this option if you want to run it for all subsets.
# Note: The output will be files with the 'bcor' extension that will be used as they are for FINEMAP.
