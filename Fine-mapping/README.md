# Fine-mapping

- FINEMAP is a program for
    1. identifying causal SNPs
    2. estimating effect sizes of causal SNPs
    3. estimating the heritability contribution of causal SNPs...
in genomic regions associated with complex traits and disease. FINEMAP is computationally efficient by using summary statistics from genome-wide association studies and robust by applying a shotgun stochastic search algorithm (Hans et al., 2007). It produces accurate results in a fraction of processing time of existing approaches. It is therefore the ideal tool for analyzing growing amounts of data produced in genome-wide association studies and emerging sequencing or biobank projects.
- More on FINEMAP and how to download/run at http://www.christianbenner.com/

# Script order and notes on output

Running FINEMAP steps adapted from Dr. Frida Lona Durazo: https://github.com/ape4fld/parra-lab/tree/main/FINEMAP

**Step 1:** Define the regions to FINEMAP -- for example +/- 500 kilobases of each lead or top SNP from the GWAS or meta analysis (take note of the chromosom and position of the lead SNP).  Depending on the goals of the investigator, may want to venture far out or keep it very small.

**Step 2:** Create subsets of the GWAS summary statistics and only include the top SNP +/- 500kb -- the ***'get-1Mb-regions.sh'*** script is designated for creating subset files for each top SNP.  These may be based on a previous analysis such as the results from a COJO.

**Step 3:** Create subsets of the genotype files, again only including the top SNP +/- kb and convert it to BGEN format.  The ***'get-bgen-subset.sh'*** script is designated for this.

- This will generate:
    1. **{outputprefix_finemap_subset}{i}.bgen**
    2. **{outputprefix_finemap_subset}{i}.sample**
    3. **{outputprefix_finemap_subset}{i}.txt**

**Step 4:** Index BGEN files.  The ***'index-bgen.sh'*** script is desginated for this.

- This will generate:
    1. **{outputprefix_finemap_subset}{i}.bgi**

***Step 5:*** Create master files for LDstore and FINEMAP.  Additional details are provided on the LDstore/FINEMAP website.  Importantly, these files must be in unix format. So if they have been generated with a Windows text editor, they will  need to be converted.  This can be done using 'dos2unix.exe' which is available in the Git shell. Additionally, be careful of not leaving spaces at the end of a row or blank rows at the end of the file, which will output errors!

***masterfile-LDstore.txt***

- If an investigator chooses to compute the local LD of one or several SNPs in a subset (e.g. the lead SNP) and the rest of the SNPs in the subset, it can be completed using LDstore.
- This is useful for creating a regional plot of the FINEMAP results (PIP or Bayes Factor) with the datapoints corresponding to the LD by colours.
- To compute local LD use the script 'run-LDstore-local.sh'. Note that a different masterfile is used 'masterfile-LDstore-local.txt', which outputs readable LD.

***masterfile-LDstore-local.txt***

**Step 6:** Calculate LD among SNPs on each subset using LDstore.  The ***'run-LDstore.sh'*** script is desginated for this. Some common errors are due to blank spaces/typos in the masterfile, or due to the GWAS summary statistics and BGEN files not having a full overlap. Be sure to check the 'ldstore.err' file and also the 'ldstore.out' for details if something went wrong.  It can also be helpful to check the size of the 'bcor' files if they are generated (with ls -l command). If empty, then it is likely is due to not full overlap.

- This will generate:
    1. **{outputprefix_finemap_subset}{i}.bcor**

***run-LDstore-local.sh***

- This will generate:
    1. **{outputprefix_finemap_subset}{i}.ld**

***masterfile-FINEMAP.txt***

**Step 7:** Run FINEMAP on each subset.  The ***'run-FINEMAP.sh'*** script is designated for this. If everything went fine with LDstore, there's normally no errors in FINEMAP (except due to typos that may be present in masterfile).

- This will generate:
    1. **{outputprefix_finemap_subset}{i}.snp** (a space-delimited text file. It contains the GWAS summary statistics and model-averaged posterior summaries for each SNP one per line.)
    2. **{outputprefix_finemap_subset}{i}.config** (a space-delimited text file. It contains the posterior summaries for each causal configuration one per line.)
    3. **{outputprefix_finemap_subset}{i}.cred** (a space-delimited text file. It contains the 95% credible sets for each causal signal in the genomic region. For each credible set, the following posterior summaries are provided.)
    4. **{outputprefix_finemap_subset}{i}.log**
- See http://www.christianbenner.com/#output for more information on the columns within each file

**Step 8:** Plot local FINEMAP results with ***plot-FINEMAP.R***

- **Figure 4** in corresponding methods paper illustrates a regional plot generated from a 1 Mb region on chromosome 14, corresponding to the pigmentation gene *SLC24A4*
