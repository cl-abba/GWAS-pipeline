# Visualization

- This pipeline was applied to two different arrays for over 5,000 Canadian individuals (CanPath) for which self-reported eye colour data was available.  **Figure 1** in the corresponding methods paper illustrates the eye colour distribution among these individuals.  

## Script order and output notes

***qqplot-function.R***

***qqplot-compute.R***

- Some refresher notes regarding QQ plots:
    - From a gerneral perspective, a QQ plot conducts a cmparison of data with a null distribution by plotting quantiles against each other.  In the case of a GWAS, observed p-values are plotted against expected p-values in order to compare the GWAS p-values to those expected of a null distribution.  
    - If the points deviate from the null distribution (solid diagonal line) then this serves as evidence to support true associations (as opposed to p-values that are very low simply due to chance alone)
- **Figure 2** illustrates the QQ plot that was generated with the above R scripts from a meta-analyss of two linear GWAS (from two different genotyping arrays) of eye colour (blue=1, green=2, hazel=3, brown=4) of over 5,000 CanPath participants 

***manhattan-function.R***

***manhattan-compute.R***

- **Figure 3** in the corresponding methods paper illustrates the Manhattan plot that was generated with the above R scripts from a meta-analysis of eye colour (blue=1, green=2, hazel=3, brown=4) of over 5,000 CanPath participants 
