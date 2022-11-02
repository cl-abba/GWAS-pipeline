# Conditional and joint analysis of association (COJO)

- COJO analysis conducted with GCTA-COJO: multi-SNP-based conditional & joint association analysis using GWAS summary data
- More information on GCTA: https://yanglab.westlake.edu.cn/software/gcta/#COJO
- INPUT: Columns are SNP, the effect allele, the other allele, frequency of the effect allele, effect size, standard error, p-value and sample size. The headers are not keywords and will be omitted by the program. Important: "A1" needs to be the effect allele with "A2" being the other allele and "freq" should be the frequency of "A1".
- OUTPUT: Columns are chromosome; SNP; physical position; frequency of the effect allele in the original data; the effect allele; effect size, standard error and p-value from the original GWAS or meta-analysis; estimated effective sample size; frequency of the effect allele in the reference sample; effect size, standard error and p-value from a joint analysis of all the selected SNPs; LD correlation between the SNP i and SNP i + 1 for the SNPs on the list

## Script order and output notes

***precojo.R***

***cojo-makebfile.sh***

***runcojo.sh***

- Note: --cojo-slct = Perform a stepwise model selection procedure to select independently associated SNPs. Results will be saved in a *.jma file with additional file *.jma.ldr showing the LD correlations between the SNPs.
- This will generate:
    1. **chr{i}{outputprefix_cojo}.jma**
    2. **chr{i}{outputprefix_cojo}.ldr**
    3. **chr{i}{outputprefix_cojo}.badsnps** (if the program cannot match SNPs in reference data, those snps will be placed in these files, that is okay because not all chromosomes will have output)

***postcojo.sh***

