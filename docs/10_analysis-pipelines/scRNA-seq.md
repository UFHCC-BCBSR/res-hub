---
title: "scRNA-seq"
linkTitle: "scRNA-seq"
date:
summary: >
weight: 3
---

## Recommended Analysis Workflows

### Primary Recommendation: nf-core/scrnaseq + Seurat
For most single-cell RNA-seq projects, we recommend using [nf-core/scrnaseq](https://nf-co.re/scrnaseq) for initial processing followed by [Seurat](https://satijalab.org/seurat/) for downstream analysis.

**Workflow Overview:**
1. **Raw data processing** → Run [nf-core/scrnaseq](https://nf-co.re/scrnaseq) on HiperGator using SLURM configuration
2. **Analysis & visualization** → Use [Seurat](https://satijalab.org/seurat/) via RStudio Server on HiperGator 
3. **Interactive exploration** → Generate .cloupe files with our [CloupeRator](/#) tool and explore data in [10X Loupe Browser](https://www.10xgenomics.com/support/software/loupe-browser/downloads)

### Alternative: 10X CellRanger + Seurat
For certain assays not optimally supported by nf-core/scrnaseq (such as specific 10X protocols or custom library preparations), we recommend:
- [10X CellRanger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger) for initial processing
- [Seurat](https://satijalab.org/seurat/) for downstream analysis

### Python Alternative: scanpy
While [scanpy](https://scanpy.readthedocs.io/) is an excellent Python-based option for single-cell analysis, **R/Seurat is our primary expertise** and we can provide more comprehensive support for R-based workflows.

## Best Practices & Considerations

**Data Quality:**
- Always perform thorough quality control metrics evaluation
- Consider batch effects early in experimental design
- Plan for appropriate controls and replicates

**Computational Resources:**
- Use HiperGator's SLURM scheduler for efficient resource allocation
- Scale computational requests based on cell count and complexity
- Consider memory requirements for large datasets (>50K cells)

**Analysis Depth:**
- Define biological questions before beginning analysis
- Plan integration strategies for multi-sample experiments  
- Consider trajectory analysis needs for developmental studies

## Getting Started
Submit a [support request](https://cancer.ufl.edu/research/shared-resources/biostatistics-computational-biology-shared-resource/biostatistics-shared-resource-support-request-form/) to discuss your specific scRNA-seq project needs and workflow requirements.
