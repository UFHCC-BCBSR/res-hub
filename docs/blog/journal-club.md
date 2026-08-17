---
title: "Journal Club Papers"
linkTitle: "Journal Club Papers"
date: 2026-08-17
summary: >
  Papers for BCB-SR journal club discussions. The current Fall 2026 lightning-style series is listed first, followed by an archive of past series and topic collections covering method reviews, benchmarking studies, reproducibility, and spatial transcriptomics.
---

## Fall 2026 Series

_The UFHCC BCB-SR Bioinformatics and Computational Biology Journal Club is running a lightning-style format this fall. Each meeting features short presentations on two papers: a **technical paper** covering a new method (e.g. benchmarking studies) and an **applications paper** (e.g. an innovative approach developed and applied to an important cancer research question)._

**To join our email distribution list for updates, newsletters, and more, email <UFHCC-BCB-SR@ad.ufl.edu>.**

---

### September 11, 2026 — First Meeting

**Technical paper:**  
[Accurate chromatin marks peak calling with Omnipeak](https://academic.oup.com/nar/article/54/1/gkaf1454/8418219) — _Shpynov & Artyomov, Nucleic Acids Research, January 2026_

Introduces Omnipeak, an unsupervised peak caller built on a constrained three-state hidden Markov model, designed as a single tool that handles the full range of chromatin signal widths rather than specializing in narrow or broad marks. The authors benchmark it against eight existing peak callers across more than 550 public and 300 synthetic datasets, spanning conventional ChIP-seq, ultra-low-input ChIP-seq, and ATAC-seq, and evaluate replicate consistency, agreement with ground truth, tolerance to noise, and behavior when control tracks are missing.

**Applications paper:**  
[Explainable machine learning-guided integrated multiomics analysis reveals macrophage-driven immune suppression in breast cancer](https://www.nature.com/articles/s41467-026-73617-9) — _Azimzade et al., Nature Communications, May 2026_

Applies an explainable machine learning pipeline (SHAP values derived from random survival forests and survival SVMs) to deconvolved cell-type fractions across roughly 5,000 METABRIC and TCGA samples, producing a "Survival Score" for each cell type. The analysis surfaces a dichotomy in which macrophages track positively with chemotherapy response but negatively with relapse-free survival in ER+ and luminal subtypes. The authors then integrate imaging mass cytometry and scRNA-seq data to link a specific HLA-ABC-high macrophage population to immunosuppressive niches and candidate interaction targets.

---

## Archive

_Materials from past series and standing topic collections._

### Spatial Transcriptomics Journal Club

_Previously hosted monthly by the UFHCC BCB-SR._

#### Power Analysis Topic

**General Power Analysis:**  
[Power Analysis for Designing Bulk, Single-Cell, and Spatial Transcriptomics Experiments: Review, Tutorial, and Perspectives](https://doi.org/10.3390/biom13020221)

**ST Power Analysis:**  
[PoweREST: Statistical power estimation for spatial transcriptomics experiments to detect differentially expressed genes between two conditions](https://doi.org/10.1371/journal.pcbi.1013293)

**scRNA-seq Power Analysis:**
- [Maximizing statistical power to detect differentially abundant cell states with scPOST](https://doi.org/10.1016/j.crmeth.2021.100120)
- [scPower accelerates and optimizes the design of multi-sample single cell transcriptomic studies](https://doi.org/10.1038/s41467-021-26779-7)

**Bulk RNA-seq Power Analysis:**  
[Sample size calculation while controlling false discovery rate for differential expression analysis with RNA-sequencing experiments](https://doi.org/10.1186/s12859-016-0994-9)

**Discussion Questions:**  
[Discussion Questions](https://ufhcc-bcbsr.github.io/res-hub/docs/19_blog/discussion-questions/) - _Structured questions to guide journal club conversations_

**Slides:**  
[Presentation Slides](https://ufhcc-bcbsr.github.io/res-hub/presentations/st4us-power-v2.html)

---

#### Xenium Data Analysis

[Presentation by Dr. Jeff Bylund, Senior Science & Technology Advisor, 10X Genomics](https://cancer.ufl.edu/events/20032/spatial-transcriptomics-for-us-st4us-journal-club/1764957600/)

**Presentation Recording:**  
[Recording](https://www.dropbox.com/scl/fi/tqqlohsoesco8wv2821xj/St4us-20251204-recording-10xXenium.mp4?rlkey=015gogh2qxei4d8asiulim9uy&dl=0) - _only accessible when logged into Dropbox with UF e-mail_

**Papers from the Presentation:**  
[Optimizing Xenium In Situ data utility by quality assessment and best-practice analysis workflows](https://www.nature.com/articles/s41592-025-02617-2)  
[Cell segmentation-free inference of cell types from in situ transcriptomics data](https://www.nature.com/articles/s41467-021-23807-4)

---

### Review Papers

*Comprehensive reviews that provide foundational knowledge and current state-of-the-art in key bioinformatics areas*

[Chromatin accessibility profiling methods](https://www.nature.com/articles/s43586-020-00010-1)

---

### Benchmarking Papers

*Benchmarking papers compare methods to determine, based on a set of parameters and often empirical and simulated data, what the "best" tool is for a particular analysis. Tools are evaluated on speed and accuracy, usually. (Keep in mind these papers are often published to introduce a new tool, and therefore may be biased.)*

- [Benchmarking RNA-seq differential expression analysis methods using spike-in and simulation data](https://pmc.ncbi.nlm.nih.gov/articles/PMC7192453/)
- [Benchmarking scRNA-seq copy number variation callers](https://www.nature.com/articles/s41467-025-62359-9)

---

### Reproducibility

*Understanding the importance of and tools for reproducibility is critical for bioinformatics work.*

[The five pillars of computational reproducibility: bioinformatics and beyond](https://doi.org/10.1093/bib/bbad375)

---

### Multi-omics

*Integrating diverse biological data types (genomics, transcriptomics, proteomics, metabolomics) to gain comprehensive insights into complex biological systems*

[Multi-Omics Data Integration in Cancer Research](https://www.nature.com/research-intelligence/nri-topic-summaries/multi-omics-data-integration-in-cancer-research-micro-62206)

---

### Eye on Relevant New Methods

*Recently published methods and tools that represent significant advances or novel approaches in computational biology*

- [hUSI is a robust transcriptome-based cellular senescence prediction tool](https://www.nature.com/articles/s43587-025-00894-2)
- [Novel cancer subtyping method guided by tumor-normal sample in latent space of transcriptomic variational autoencoder](https://www.nature.com/articles/s41598-025-07813-w)

---
