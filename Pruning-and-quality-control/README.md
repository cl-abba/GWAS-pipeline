# 2. Pruning and quality control (QC)

## Script order and output notes

- Before the not imputed files can be used for Step 1 of SAIGE they must be pruned, and before the imputed files can be used for Step 2 of SAIGE they must go through a series of quality control (QC) steps
- Note inputs for SAIGE:
1. Genotype file (PLINK binary, not imputed)
2. Genotype file (indexed, .bgen (or.vcf) imputed)
3. Phenotype file (.txt wit headers – covariates in this example will be age, sex and first 10 principal components (PCs))

### Preparing SAIGE Step 1 files

- Pruning:
    * For generating PCA plots remove markers that are tightly linked in Linkage Disequilibrium (LD)
    * Can use the pruning recommendations by PLINK (e.g., 50, 5 and 0.1; note that 0.1 represents the r squared value of LD and is the most stringent setting)
    * PLINK can select which markers to keep by randomly selecting between two markers that are closely linked, conversely, you can also use missing information and tell PLINK to keep the marker of higher quality, but since QC has already been performed PLINK’s random selection will be fine
    * This wil generates 2 files: 
    1. **{outputprefix}.in** 
    2. **{outputprefix}.out**
    * This example illustrates how to use the .in file to generate a new dataset with just the pruned markers

***pruning1.sh***

***pruning2.sh***

- This will generate:
    1. **{outputprefix_notimputed_Sampleswithphenoextracted_pruned}.bed**
    2. **{outputprefix_notimputed_Sampleswithphenoextracted_pruned}.bim**
    3. **{outputprefix_notimputed_Sampleswithphenoextracted_pruned}.fam**
- Can now perform principal component analysis (PCA):

***PCA.sh***

- This will generate:
    1. **{outputprefix_notimputed_Sampleswithphenoextracted_pruned}.eigenval**
    2. **{outputprefix_notimputed_Sampleswithphenoextracted_pruned}.eigenvec**
- The first 10 PCs will be used as covariates to control for population structure when running SAIGE
- Add the PCs to phenotype file:

***addPCs-pheno.R***

### Preparing SAIGE Step 2 files

- Before beginning the QC based on Marees et al., complete a few filtering steps: 
    1. To remove low imputed markers (INFO > 0.8)
    2. Ensure that there are only SNPs in the dataset (no indels or other types of polymorphisms)
    3. Remove any duplicated markers in the dataset (when markers are imputed the server usually splits multiallelic SNPs, so they need to be removed them)

***filtering.sh***

- This will generate:
    1. **{i}{outputprefix_imputed_Sampleswithphenoextracted_filtered}.vcf.gz**
- Check the log/output files to see how many (if any) markers were removed at each command

- Now perform the rest of the QCs - since variants below the desired threshold have already been removed the only two steps remaining are as follows:
    * hwe 1e-6 (Hardy-weinberg equilbrium test) 
    * maf 0.01 (Apply minor allele frequency filters)
- If an investigator is interested in performing all of the QC within PLINK, this link is helpful for learning PLINK's order of operations: https://www.cog-genomics.org/plink/2.0/order 

***vcftools-QC.sh***

- For more information on vcftools: https://vcftools.github.io/index.html
- This will generate:
    1. **{i}{outputprefix_imputed_Sampleswithphenoextracted_filtered_QCvcftools}.recode.vcf**
- Next, convert to .bgen because SAIGE does not recognize some flags in vcf files (newer versions may have resolved this)

***vcf2bgen.sh***

***indexbgen.sh***

- Indexing is an important step, it is almost like creating a dictionary for your files, it is required to run the GWAS with SAIGE
- This will generate:
    1. **{i}{outputprefix_imputed_Sampleswithphenoextracted_filtered_QCvcftools}.bgen**
- As well as an index file (.bgi) for each
- Note that when indexing .bgen files, a .sample file is also generated.  SAIGE requires this for .bgen input.
- For more information on bgenix: https://enkre.net/cgi-bin/code/bgen/doc/trunk/doc/wiki/bgenix.md

