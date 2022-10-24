# GWAS-pipeline

This repository describes steps in genome-wide association studies (GWAS) and post-GWAS analyses.  Compliment to the methods paper, "From genetic association to forensic prediction: Computational methods and tools for identifying phenotypically informative SNPs".

## Materials and methods

To replicate this protocol the following materials are required:

1. Phenotype file
2. Imputed genotype file (or files if separated by chromosome)
3. This example utilizes both imputed and not imputed genotype files, but the protocol still applies if only imputed files are available
4. Storage and workspace that can be used to storing output files, running jobs and downloading programs

The methodology is as follows:

1. Data storage, handling and cleaning (if necessary) - PLINK, bcftools, R
2. Pruning and quality control (QC) - PLINK, bcftools, vcftools
3. GWAS - PLINK, SAIGE
4. Meta-analysis - Metasoft
5. Visualization - R
6. Postliminary analyses (COJO and FINEMAP examples) - GCTA, LDSTORE2, FINEMAP
