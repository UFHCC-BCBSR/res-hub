---
title: "ST4US Journal Club Discussion Questions"
linkTitle: "ST4US Journal Club Discussion Questions"
summary: >
  Discussion guide for Statistical Power Analysis in Transcriptomics - UF Health Cancer Center BCB-SR Bioinformatics Unit
---

# ST4US Journal Club - October 10, 2025
**UF Health Cancer Center BCB-SR Bioinformatics Unit**

## Main Paper

**Jeon, H.; Xie, J.; Jeon, Y.; Jung, K.J.; Gupta, A.; Chang, W.; Chung, D.** *Statistical Power Analysis for Designing Bulk, Single-Cell, and Spatial Transcriptomics Experiments: Review, Tutorial, and Perspectives.* **Biomolecules** 2023, 13, 221. 

📖 [Read the paper](https://doi.org/10.3390/biom13020221)

## Additional Selected Methods Papers for Reference

### ST Power Analysis
- [PoweREST: Statistical power estimation for spatial transcriptomics experiments to detect differentially expressed genes between two conditions](https://doi.org/10.1371/journal.pcbi.1013293)

### scRNA-seq Power Analysis
- [Maximizing statistical power to detect differentially abundant cell states with scPOST](https://doi.org/10.1016/j.crmeth.2021.100120)
- [scPower accelerates and optimizes the design of multi-sample single cell transcriptomic studies](https://doi.org/10.1038/s41467-021-26779-7)

### Bulk RNA-seq Power Analysis
- [Sample size calculation while controlling false discovery rate for differential expression analysis with RNA-sequencing experiments](https://doi.org/10.1186/s12859-016-0994-9)

## Glossary

**Statistical Power:** The probability of correctly detecting a true effect (e.g., a differentially expressed gene) when it actually exists; essentially the ability to avoid false negatives.

**False Discovery Rate (FDR):** The expected proportion of false positives among all discoveries when testing multiple hypotheses simultaneously—critical for transcriptomics since thousands of genes are tested at once.

**Effect Size:** The magnitude of difference being tested (e.g., fold-change in gene expression between conditions); larger effect sizes are easier to detect with the same sample size. Without pilot data, researchers might determine this parameter based on similar studies in the field.

**Pilot Data:** Preliminary or existing transcriptomic data used to estimate key statistical parameters (like gene expression means, variances, and dispersion) that power analysis tools need to predict appropriate sample sizes for your planned experiment.

**Sequencing Depth:** The total number of reads obtained per sample; deeper sequencing provides more precise measurements but with diminishing returns and increased cost.

**Fields of View (FoVs):** The specific tissue regions captured in a spatial transcriptomics experiment. Size and number of FoVs are key experimental design parameters. The FoV is limited by physical constraints, e.g. slide size. Each FoV requires separate library preparation and has other technical differences. Requires deliberate decisions about which tissue regions to capture.

**Between-Replicate Variation:** The inherent differences in gene expression between biological replicates within the same experimental condition, caused by both biological factors (individual differences) and technical factors (batch effects, processing differences).

**Mixed Effects Models:** Statistical models that account for both fixed effects (experimental treatments) and random effects (individual/batch variation). This approach is theoretically ideal for single-cell data but computationally intensive.

**Pseudobulk:** A method that aggregates single-cell expression data (summing across cells within a sample/condition) to approximate bulk RNA-seq data for certain analyses.

**Pseudoreplication:** A problem of correlated samples where observations that are not truly independent (like cells from the same individual) are treated as independent samples, inflating statistical significance. In contrast to pseudo-bulk analysis, performing DE analysis of the cell x gene matrix is an example of pseudoreplication.

---

## Discussion Questions

### Why Does Power Analysis Matter?

#### The Big Picture
- Why should we care about power analysis when designing transcriptomic experiments? What happens if we get it wrong?
- Do you typically employ power analysis when designing a transcriptomics (bulk, scRNA, ST) experiment? If you review grant proposals etc., how commonly do you see researchers do this? How does this compare to power analysis for non-high dimensional data?

#### Cost vs. Discovery
- Transcriptomic experiments are expensive. This is often cited as a reason to arbitrarily pick "n=3" for bulk RNA-seq or doing a single-sample scRNA-seq/ST project. But how does power analysis help us avoid both wasting money (too many samples) and missing discoveries (too few samples)?

### Technology Differences: Bulk vs. Single-Cell vs. Spatial

#### Sample Size Confusion
- In bulk RNA-seq, "sample size" means number of biological replicates. In single-cell and ST, it could mean number of cells/spots OR number of biological replicates. How does this affect power analysis? How does this affect power?

#### The Zero Problem
- Single-cell data has more zeros than bulk data. How does this affect our ability to detect differences? To what extent does this apply to spatial transcriptomics?

#### Spatial Complications
- What new challenges does spatial transcriptomics add to power analysis that we don't have with bulk or single-cell RNA-seq?

### Practical Implementation

#### Pilot Data Problem
- How do you find and choose pilot data for a power analysis tool? What if you can't find any - what are your options? Where can you get parameter estimates?

#### Limited Methods for ST
- What are the major limitations for the one ST power analysis tool, PoweREST?
- Can you just use single-cell RNA-seq power analysis tools for spatial transcriptomics data? What are the limitations in doing this?

### Common Pitfalls

#### Pseudoreplication Problem
- [Squair et al. 2021](https://doi.org/10.1038/s41467-021-25960-2) demonstrated that many single-cell studies use inappropriate statistical methods that yield fake discoveries. How does this relate to power analysis?

#### Biological vs. Technical Replicates
- Why do the authors and the methods cited consistently recommend more biological replicates over more cells/spots? How does this apply to your experimental design?

#### Effect Size Reality Check
- Power analysis requires estimating effect sizes (fold-changes you want to detect). How do you pick realistic numbers?

### Moving Forward

#### Immediate Action
- Based on this discussion, what's one thing you'd change about how you design your next transcriptomic experiment?

#### Skipped Power Analysis
- If you skipped power analysis when designing your experiment, are these tools still useful? What can you learn from doing a power analysis of your experimental data?

#### Spatial Transcriptomics Specific
- If you're planning a spatial transcriptomics experiment, what are the 2-3 most important factors you need to consider for power?

#### When to Skip It
- Are there situations where you might reasonably skip formal power analysis? When is a "best guess" approach acceptable?

### Future Considerations

#### Technology Evolution
- Spatial transcriptomics technology is rapidly changing. How do you plan for power analysis when the technology might change by the time you do your experiment, and current power analysis tools (there is only one, PoweREST) don't apply to the platform you're using?

#### Integration Complexity
- As we start integrating spatial transcriptomics with other data types (imaging, proteomics), how will this affect power considerations?

---

## Key Takeaway Question

**What's your main barrier to actually using power analysis in your research - is it lack of tools, lack of pilot data, computational complexity, or something else?**