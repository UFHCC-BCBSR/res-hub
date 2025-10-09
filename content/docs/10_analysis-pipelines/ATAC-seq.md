---
title: "ATAC-seq"
linkTitle: "ATAC-seq"
date:
summary: >
weight: 2
---

## ATAC-seq Analysis Overview

ATAC-seq analysis aims to identify regions of open chromatin and detect differential accessibility between conditions. The workflow involves: (1) **preprocessing and peak calling**, (2) **differential accessibility analysis**, and (3) **biological interpretation** through annotation and motif analysis.

The analysis path depends on your research questions and data characteristics, with key decision points around peak calling strategies and differential analysis methods.

## Analysis Workflows

### Primary Processing: nf-core/atacseq Pipeline

**What it does:** The [nf-core/atacseq](https://nf-co.re/atacseq) pipeline handles complete preprocessing from raw reads through peak calling, including adapter trimming, alignment (bowtie2), duplicate removal, QC reporting, and peak calling with MACS2.

**Input:** Raw FASTQ files  
**Output:** Aligned BAM files, QC reports, peak calls (BED files), fragment size distributions

**Recommendation:** Start with nf-core/atacseq for all projects - you can always use alternative peak callers or analysis methods on the BAM file outputs.

### Peak Calling Strategy

#### Use Default MACS2 Peaks from nf-core/atacseq
**Best for:** Most ATAC-seq projects with standard experimental designs

**Proceed to:** Differential analysis with peak-based methods

#### Alternative Peak Callers
**When to consider:** If MACS2 peaks don't capture your regions of interest

**Options:**
- **Genrich**: Optimized for ATAC-seq data, better replicate handling
- **HMMRATAC**: Uses fragment size information for improved peak detection

**Input:** BAM files from nf-core/atacseq  
**Output:** Alternative peak calls (BED files)

#### Skip Peak Calling Entirely (CSAW Approach)
**When to consider:** Unbiased genome-wide analysis, broad accessibility changes, or when peak calling may introduce bias

**Method:** [CSAW](https://nbisweden.github.io/workshop-archive/workshop-ChIP-seq/2018-11-07/labs/lab-csaw.html) uses sliding windows across the genome for differential analysis

**Input:** BAM files from nf-core/atacseq  
**Output:** Window-based differential accessibility results

### Differential Accessibility Analysis

#### Peak-Based Analysis
**Recommended:** [atacreportR](https://devufbcb-sr.rc.ufl.edu/atacreportr/) - UF-developed application for automated differential analysis and reporting

**Alternative:** [DiffBind](https://bioconductor.org/packages/release/bioc/html/DiffBind.html) for R-based analysis with custom parameters

**Input:** Peak files (BED) + BAM files + sample metadata  
**Output:** Differential accessibility results, statistical summaries, visualizations

#### Window-Based Analysis (CSAW)
**Method:** Direct differential testing on genomic windows using edgeR

**Input:** BAM files + experimental design  
**Output:** Window-level differential accessibility with specialized FDR control

### Biological Interpretation
**Tools:** [ChIPseeker](https://bioconductor.org/packages/release/bioc/html/ChIPseeker.html) for annotation, motif analysis tools

## Choosing Your Analysis Strategy

### Peak-Based vs. Window-Based Analysis

**Peak-Based Advantages:**
- Faster computation, standard approach
- Results interpretable as discrete regulatory elements
- Integrated reporting available (atacreportR)
- Extensive tool ecosystem

**Peak-Based Limitations:**
- Peak calling may miss broad regions or introduce bias
- Assumes discrete accessible regions

**Window-Based (CSAW) Advantages:**
- Unbiased genome-wide analysis
- Better for broad or diffuse changes
- Specialized statistical methods for ChIP-seq-like data

**Window-Based Limitations:**
- Computationally intensive
- Complex result interpretation
- Manual R implementation required

## Recommended Workflows

### Standard Workflow
**Best for:** Most ATAC-seq projects

1. **Run nf-core/atacseq pipeline** → Complete preprocessing and peak calling
2. **Differential analysis with atacreportR** → Automated analysis and comprehensive reporting
3. **Review results** → Interactive visualizations and downloadable reports

### Custom Peak Calling Workflow
**Best for:** Projects requiring specialized peak detection

1. **Run nf-core/atacseq pipeline** → Get BAM files and QC metrics
2. **Alternative peak calling** → Genrich, HMMRATAC, or custom parameters
3. **Differential analysis** → DiffBind or atacreportR with custom peaks

### Unbiased Discovery Workflow
**Best for:** Exploratory projects or broad accessibility changes

1. **Run nf-core/atacseq pipeline** → Get processed BAM files
2. **CSAW analysis** → Window-based differential accessibility
3. **Custom interpretation** → Manual R analysis of results

## Important Notes

- **Pipeline execution:** You run nf-core/atacseq yourself on HiperGator using SLURM
- **atacreportR access:** Private UF application requiring network access and coordination
- **Computational resources:** Use HiperGator's SLURM scheduler for all analyses

## Getting Started

Submit a [support request](https://cancer.ufl.edu/research/shared-resources/biostatistics-computational-biology-shared-resource/biostatistics-shared-resource-support-request-form/) to discuss your experimental design, choose the appropriate analysis strategy, and obtain access to UF-specific tools like atacreportR.
