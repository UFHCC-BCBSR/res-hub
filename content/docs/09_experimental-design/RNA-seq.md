---
title: "RNA-seq"
linkTitle: "RNA-seq"
date:
summary: >
weight: 1
---

## Experimental Design Considerations

### Replication Strategy
Plan for at least 3 biological replicates per condition, with 5-6 replicates preferred for detecting smaller effect sizes. Technical replicates are generally unnecessary with modern RNA-seq protocols.

### Sample Collection and Storage
- **RNA integrity**: Target RIN scores >7 for optimal results, though degraded samples (RIN 5-7) can still provide useful data with appropriate analysis adjustments
- **Storage**: Flash freeze samples in liquid nitrogen and store at -80°C. Avoid freeze-thaw cycles
- **Batch effects**: Randomize sample processing across batches when possible

### Library Preparation Considerations
- **Poly(A) selection vs. rRNA depletion**: Choose based on research goals - poly(A) for mRNA focus, rRNA depletion for comprehensive transcriptome including non-coding RNAs
- **Strand-specific libraries**: Recommended for accurate transcript quantification and novel transcript discovery
- **PCR amplification**: Minimize PCR cycles during library preparation to reduce duplication bias. Monitor final library complexity and duplication rates
- **Read length**: 75-100bp paired-end reads are standard for most applications

### Sequencing Depth
Target 20-30 million paired-end reads per sample for human/mouse samples. Increase depth for:
- Novel transcript discovery (50+ million reads)
- Low-input samples
- Species with large genomes or high transcript diversity

### Spike-in Controls
Consider ERCC spike-ins for:
- Cross-sample normalization validation
- Technical performance assessment
- Absolute quantification needs

### Quality Control Metrics
Monitor key metrics including:
- Mapping rates (>80% for well-annotated genomes)
- Duplication rates (<30% for high-quality libraries)
- rRNA contamination (<10%)

### ENCODE Guidelines
Follow [ENCODE RNA-seq standards](https://www.encodeproject.org/rna-seq/) for experimental design and data processing. Key ENCODE benchmarks include >10 million uniquely mapped reads, <15% duplication rate, and strand-specificity >0.8 for stranded libraries.

## Data Processing Workflow
[Link to analysis pipeline documentation]

