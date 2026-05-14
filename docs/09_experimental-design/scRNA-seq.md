---
title: "scRNA-seq"
linkTitle: "scRNA-seq"
date:
summary: >
weight: 3
---

## Experimental Design Considerations

*Note: This section covers standard droplet-based single-cell RNA-seq protocols. For spatial transcriptomics approaches, see [Spatial RNA-seq](../spatial-rna-seq/) and [10X Visium](../visium/).*

### Replication Strategy
Plan for at least 2-3 biological replicates per condition when possible. Balance sample size with cell number - fewer samples with more cells per sample may be preferable for rare cell type detection, while more samples with fewer cells provide better population-level inference.

### Sample Preparation
- **Cell viability**: Maintain >80% viability throughout processing. Dead cells can create ambient RNA contamination
- **Single-cell suspension**: Ensure complete dissociation without excessive stress. Optimize dissociation protocols for your tissue type
- **Processing time**: Minimize time from dissociation to capture (<30 minutes) to reduce stress-induced gene expression changes
- **Cell concentration**: Target 700-1,200 cells/μL for optimal capture efficiency

### Platform Considerations
- **10X Genomics**: Most common platform, good for large cell numbers (500-10,000 cells)
- **Smart-seq protocols**: Better gene coverage per cell, suitable for smaller cell numbers with deeper profiling
- **Cell capture targets**: Plan for 3,000-10,000 cells per sample, accounting for ~65% capture efficiency

### Quality Control Expectations
- **Genes per cell**: Expect 1,000-4,000 detected genes per cell for mammalian samples
- **UMI counts**: Target 1,000-10,000 UMIs per cell depending on cell type and platform
- **Mitochondrial gene expression**: <20% for healthy cells (higher may indicate cell stress/death)
- **Doublet rates**: Expect 0.4-1.6% per 1,000 cells captured

### Batch Effects and Experimental Design
- **Multiplexing**: Consider cell hashing or genetic multiplexing to reduce batch effects
- **Processing batches**: Balance conditions across processing days when multiple batches are necessary
- **Ambient RNA**: Account for background contamination, especially important for tissue samples

### ENCODE Guidelines
While ENCODE standards for bulk RNA-seq provide general guidance, single-cell specific considerations include the [Human Cell Atlas guidelines](https://www.humancellatlas.org/) for standardized sample processing and metadata collection.

## Data Processing Workflow
[Link to your analysis pipeline documentation]
