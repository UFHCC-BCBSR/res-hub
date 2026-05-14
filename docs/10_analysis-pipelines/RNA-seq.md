---
title: "RNA-seq"
linkTitle: "RNA-seq"
date:
summary: >
weight: 1
---

## Recommended Analysis Workflow

### Primary Recommendation: nf-core/rnaseq + DECODeR
For bulk RNA-seq projects, we recommend using [nf-core/rnaseq](https://nf-co.re/rnaseq) for initial processing followed by our [DECODeR](/decoder/) application for differential expression analysis and visualization.

**Workflow Overview:**
1. **Raw data processing** → Run [nf-core/rnaseq](https://nf-co.re/rnaseq) on HiperGator using SLURM configuration
2. **Quality control & differential analysis** → Upload count matrices to [DECODeR](/decoder/) for comprehensive QC and differential expression analysis
3. **Visualization & interpretation** → Explore results through DECODeR's interactive plots and downloadable reports

### Alternative R-based Analysis
For users preferring traditional R workflows, we recommend:
- [limma-voom](https://ucdavis-bioinformatics-training.github.io/2018-June-RNA-Seq-Workshop/thursday/DE.html) for differential expression
- [ComplexHeatmap](https://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html) for visualization
- Access via [RStudio Server on HiperGator](https://docs.rc.ufl.edu/software/apps/r/rstudio_server/)
- 
## Best Practices & Considerations

**Experimental Design:**
- Plan for adequate biological replicates (minimum 3 per condition)
- Consider batch effects and confounding variables
- Include appropriate controls for your experimental questions

**Data Quality:**
- Evaluate read quality and mapping rates from nf-core/rnaseq output
- Check for outlier samples using DECODeR's QC metrics
- Assess count distribution and normalization effectiveness

**Statistical Analysis:**
- Set appropriate significance thresholds (FDR < 0.05, |log2FC| > 1)
- Consider multiple testing correction methods
- Validate key findings with qPCR when possible

**Computational Resources:**
- Use HiperGator's SLURM scheduler for nf-core/rnaseq processing
- Scale resources based on sample count and read depth
- Plan storage needs for large fastq files and intermediate outputs

## Getting Started
Submit a [support request](https://cancer.ufl.edu/research/shared-resources/biostatistics-computational-biology-shared-resource/biostatistics-shared-resource-support-request-form/) to discuss your RNA-seq project design and analysis needs.

