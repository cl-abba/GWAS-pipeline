# Run GWAS

- Begin by ensuring the most recent version of SAIGE has been installed
- The GitHub with instructions and documentation for SAIGE can be found here: https://github.com/weizhouUMICH/SAIGE

## Script order and output notes

***install-SAIGE.sh***

***SAIGE-Step1-Linear.sh***

- This will generate:
    1. **{outputprefix_SAIGE_Step1}.rda** (this is the model file that will serve as input for Step 2)
    2. **{outputprefix_SAIGE_Step1}.varianceRatio.txt** (variance ratio file)
- Note: This applies a linear mixed model, here self-reported eye colour can be coded numerically (e.g., blue (1), green (2), hazel (3) and brown (4)).
    - In this model, a negative beta will be indicative of eye colour lightening and a positive beta of eye colour darkening.
- Optional output files include a sparse GRM file and the sample ID file for the sparse GRM (in the case of using .bgen).
- Logistic regression is provided in separate script (e.g., blue vs. non blue eyes coded as 0 and 1).

***SAIGE-Step1-Binary.sh***

- Use this script instead of ***SAIGE-Step1-Linear*** if you have binary phenotype data (e.g., blue vs. non-blue)

***SAIGE-Step2-Linear***

***SAIGE-Step2-Binary.sh***

- This will generate:
    1. **chr{i}{outputprefix_SAIGE_Step2}.out**

***merge-SAIGE-output.sh***

- This will generate:
    1. **{outputprefix_final_cleaned}.out**
    2. **{outputprefix_final_cleaned_topSNPs}.out**
    3. **{outputprefix_final_cleaned_pvaluesonly}.out**
    4. **{outputprefix_final_cleaned_rsid_chr_pos_pvalue}.out**
 - Files than end in pvalManhattan.out can be used to generate Manhattan plots.  Files that end in pvalQQ.out can be used to generate QQ plots.  Scripts for visualization will be described after the meta-analysis step, but it can be beneficial to illustrate these plots at the indivdiual GWAS stage as well.

