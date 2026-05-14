---
title: "Pathway Analysis"
linkTitle: "Pathway Analysis"
date: 
summary: 
weight: 1
---

Pathway Enrichment Analysis (PEA) is a widely used method to interpret large-scale omics datasets by identifying biological pathways that are overrepresented among a list of differentially expressed genes, proteins, or other features. This page gathers presentations, tools, and readings to help you apply PEA thoughtfully and avoid common pitfalls.

[BCB-SR Pathway Enrichment Analysis Presentation](https://ufhcc-bcbsr.github.io/pathway-enrichment-presentation/)

**Web Tool Summary Table**

| Tool | ORA | GSEA | Topology | GO | KEGG | Reactome | MSigDB | Other Databases |
|--------|:------:|:------:|:------:|:------:|:------:|:------:|:------:|--------|
| [g:Profiler](https://biit.cs.ut.ee/gprofiler/) | ✅ | 🔶 |  | ✅ | ✅ | ✅ | ✅ | TRANSFAC, miRTarBase, WikiPathways |
| [Enrichr](https://maayanlab.cloud/Enrichr/) | ✅ |  |  | ✅ | ✅ | ✅ | ✅ | ChEA, DrugMatrix, TF/miRNA |
| [DAVID](https://david.ncifcrf.gov/) | ✅ |  |  | ✅ | ✅ | ✅ |  | Panther, BioCarta |
| [WebGestalt](https://www.webgestalt.org/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | WikiPathways, user-defined sets |
| [Reactome](https://reactome.org/) | ✅ | ✅ |  |  |  | ✅ |  |  |
| [PantherDB](http://pantherdb.org/) | ✅ | ✅ |  | ✅ |  |  |  | Panther Pathways |
| [Metascape](https://metascape.org/) | ✅ |  |  | ✅ | ✅ | ✅ | ✅ | CORUM, WikiPathways |
| [ShinyGO](http://bioinformatics.sdstate.edu/go/) | ✅ |  |  | ✅ | ✅ |  | 🔸 | Limited subset of MSigDB |
| [PathDIP](http://ophid.utoronto.ca/pathDIP) | ✅ |  | ✅ | ✅ | ✅ | ✅ |  | PID, BioCarta, PPI-aware pathways |
| [GSEA-MSigDB](https://www.gsea-msigdb.org/) |  | ✅ |  | ✅ | ✅ | ✅ | ✅ | Hallmark, C1–C7 collections |
| [ExpressAnalyst](https://www.expressanalyst.ca/) | ✅ | ✅ |  | ✅ | ✅ | ✅ | ✅ | BioCarta, WikiPathways |
| [Cytoscape EnrichMap](https://apps.cytoscape.org/apps/enrichmap) |  | ✅ |  | Any | Any | Any | Any | Visualization |

