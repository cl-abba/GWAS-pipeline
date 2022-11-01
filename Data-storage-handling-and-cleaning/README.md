# Data storage, handling and cleaning 

- If the project only requires a subset of individuals from the genotype files, PLINK or bcftools can be used to exctract the desired samples (Remember to use PLINK2.0 if you want to preserve dosage and phase information) - this example illustrates how to extract individuals with a certain genotype at a particular locus
- Note the #SBATCH lines, accounts and names can be changed for project or script relevance
- For this example, both imputed and not imputed files are utilized (each serve different purposes)
- For more information on PLINK: https://www.cog-genomics.org/plink/2.0/
- For more information on bcftools:https://samtools.github.io/bcftools/bcftools.html

## Script and output notes

***extract-snp.sh****

- This will generate:
    1. **{outputprefix_imputed_Samplesextracted}.bed**
    2. **{outputprefix_imputed_Samplesextracted}.bim**
    3. **{outputprefix_imputed_Samplesextracted}.fam**
- Moved .fam files to local machine, converted to .txt and used R to create a list of individuals:

***generate-sample-file.R***

- Add a header “IID” if planning to use PLINK2 binary files, otherwise can leave without a header
- Next, take the two list of individuals, and use the newly created text file to filter out the individuals for which there is corresponding phenotype data for (can also convert to .csv insteaf of .txt because some R programs, like dplyr work best with .csv files)

***filter-pheno.R***

- Now these .txt files will be used on the original imputation data (all 22 chromosomes) and not imputed files to ensure only individuals with the desired genotype (for which phenotype data is available for) are used
- Can use for loops or job array 

***samples2keep-notimputed.sh

***notimputed-makebed.sh***

- This will generate:
    1. **{outputprefix_notimputed_Sampleswithphenoextracted}.bed**
    2. **{outputprefix_notimputed_Sampleswithphenoextracted}.bim**
    3. **{outputprefix_notimputed_Sampleswithphenoextracted}.fam**

***samples2keep-imputed.sh***

- This will generate:
    1. **{outputprefix_imputed_Sampleswithphenoextracted}.vcf.gz**
