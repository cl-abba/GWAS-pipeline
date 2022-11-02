# Meta-analysis

- If it is relevant, perform a meta-analysis, this will help to increase the power to identify genome-wide signficant variants.
- Fixed vs. random – These are meta-analysis methods to combine data on a summary statistic level, across data silos and/or publications. Fixed effects meta-analyses are often useful for discovery analyses and generally more powerful, although some investigators prefer random effects models as they are more conservative and account for heterogeneity across data silos. Heterogeneity estimates – Often expressed as Cochrane’s Q or I2. Very important as they give an idea of outlier effect bias and generalizability of results.
- Lambdas – typically aiming for between 0.95 and 1.05, anything else and there may potentially be a problem.  It is good practice to apply a lambda correction to SE values. 
- More on Metasoft: https://github.com/jinghuazhao/software-notes/tree/master/docs/files/METASOFT
- The .jar, .py, .txt (p value table) and .R files are all required for running metasoft
- The .py file needs to be edited to account for SE, but it is included on the Metasoft GitHub

## Script order and output notes

***premeta1.R***

***plink2metasoft2.py***

- Then prepare a bash script containing the path to the summary statistics.  The bash script will call the python script (***plink2metasoft2.py***)

***premeta2.sh***

- This will generate:
    1. **chr{i}{outputprefix_premeta}.log**
    2. **chr{i}{outputprefix_premeta}.mmap**
    3. **chr{i}{outputprefix_premeta}.meta**

***runmeta.sh***

- This will generate:
    1. **chr{i}{outputprefix_meta}.log**
    2. **chr{i}{outputprefix_meta}.out**

***postmeta1.sh***

***postmeta2.sh***

- Use the following website if you want to determine if markers from meta analysis are in LD: https://analysistools.cancer.gov/LDlink/?tab=home
    - Use LDpair to insert two rsIDs that you want to create contingency tables for to look at LD
    - Use LDassoc to input summary statistics from your GWAS/meta to plot top SNPs
- Note: the pvalQQ.out files can be used to generate QQ plots and the pval_Manhattan files can be used to generate Manhattan plots for the meta analysis
