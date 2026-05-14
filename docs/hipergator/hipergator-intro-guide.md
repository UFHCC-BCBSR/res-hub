+++
title = "HiPerGator for Bioinformatics"
category = "Computing"
+++

## Getting Started with Bioinformatics on HiPerGator

This guide introduces bioinformatics researchers to high-performance computing (HPC) using UF's HiPerGator system. Whether you're new to bioinformatics or ready to scale up your analyses, HiPerGator provides the computational power and memory needed for modern genomic research.

## Why Use HPC for Bioinformatics?

Bioinformatics analyses are naturally suited for HPC because they typically involve:

- **Large datasets**: Genomic files (FASTQ, BAM, VCF) can be hundreds of GB to TB in size
- **Memory-intensive processes**: Genome assembly, variant calling, and large matrix operations often require 100GB+ of RAM
- **Parallel processing**: Many bioinformatics tools can utilize multiple cores simultaneously
- **Long-running analyses**: Genome assemblies, phylogenetic analyses, and population genomics can take days to weeks

HiPerGator servers have up to 1TB of memory and 128 cores per node - far beyond what's available on personal computers.

## What is HiPerGator?

HiPerGator is UF's supercomputer consisting of hundreds of powerful servers managed by a job scheduler called Slurm. Instead of running analyses on your laptop, you submit jobs to a queue where they run on dedicated compute nodes with the resources you specify.

## Getting Started: Essential Steps

### 1. Get Access
Request a HiPerGator account [here](https://www.rc.ufl.edu/get-started/hipergator/request-hipergator-account/). You'll need UF faculty sponsorship.

### 2. Learn Basic Command Line
HiPerGator uses the Linux command line. If you're new to this:
- Try the [Data Carpentry Unix tutorial](https://swcarpentry.github.io/shell-novice/)
- Complete [HiPerGator training materials](https://docs.rc.ufl.edu/training/)

### 3. Transfer Your Data
Use these methods based on data size:
- **Small files (<1GB)**: `scp` or `rsync` commands
- **Large genomic datasets**: [Globus transfer](https://docs.rc.ufl.edu/data_transfer/globus_transfer/)

### 4. Set Up Your Software Environment
Most bioinformatics tools are pre-installed:
    
    module load samtools
    module load blast
    module load bwa

For Python/R packages, use conda environments:
    
    module load conda
    conda create -n myanalysis -c bioconda fastqc multiqc
    conda activate myanalysis

### 5. Write Your Analysis Script
Your analysis should run from start to finish without interaction. For example:
    
    #!/bin/bash
    # Quality control
    fastqc *.fastq.gz
    multiqc .
    
    # Alignment
    bwa mem reference.fa sample_R1.fastq.gz sample_R2.fastq.gz | samtools sort -o sample.bam
    samtools index sample.bam
    
    # Variant calling
    bcftools mpileup -f reference.fa sample.bam | bcftools call -mv -o sample.vcf

### 6. Create a Job Script
Tell Slurm what resources you need:
    
    #!/bin/bash
    #SBATCH --job-name=my_analysis
    #SBATCH --mail-type=ALL
    #SBATCH --mail-user=your.email@ufl.edu
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=8
    #SBATCH --mem=32gb
    #SBATCH --time=24:00:00
    #SBATCH --partition=hpg-default
    
    module load bwa samtools bcftools
    
    # Run your analysis
    bash my_analysis.sh

### 7. Submit and Monitor Your Job
    
    sbatch my_job.sbatch
    squeue -u $USER  # Check job status

## Optimizing for Bioinformatics

### Use Parallel Processing
Most bioinformatics tools support threading:
- BWA: `-t 8` for 8 threads
- BLAST: `-num_threads 8`
- SAMtools: `-@ 8`

Always match the thread count to your `--cpus-per-task` request.

### Process Multiple Samples
Use job arrays to process many samples simultaneously:
    
    #SBATCH --array=1-96  # For 96 samples
    sample=$(sed -n "${SLURM_ARRAY_TASK_ID}p" sample_list.txt)
    fastqc ${sample}_R1.fastq.gz ${sample}_R2.fastq.gz

### Request Appropriate Resources
- **Genome assembly**: 64+ cores, 500GB+ memory
- **RNA-seq alignment**: 8-16 cores, 32GB memory
- **Variant calling**: 4-8 cores, 16GB memory
- **Quality control**: 2-4 cores, 8GB memory

## Storage Considerations

- **Home directory**: Small files, scripts (40GB limit)
- **Blue storage**: Large datasets, long-term storage
- **Scratch space**: Temporary job outputs (auto-deleted after 31 days)

## Getting Help

- **UFRC Documentation**: https://docs.rc.ufl.edu/
- **Support tickets**: https://www.rc.ufl.edu/get-support/
- **Office hours**: Check UFRC website for current schedule

## Next Steps

Once comfortable with basic job submission:
1. Explore workflow managers like [Nextflow](https://docs.rc.ufl.edu/software/apps/nextflow/) or [Snakemake](https://docs.rc.ufl.edu/software/apps/snakemake/)
2. Learn about [GPU computing](https://docs.rc.ufl.edu/scheduler/gpu_access/) for machine learning applications
3. Set up automated pipelines for routine analyses

HiPerGator makes complex bioinformatics analyses accessible and efficient. Start with simple jobs and gradually increase complexity as you become more comfortable with the system.