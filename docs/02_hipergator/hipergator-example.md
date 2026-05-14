+++
title = "HiPerGator Demo"
category = "Computing"
+++

# HiPerGator Quick Start Guide

As a way to demonstate some of the most commonly used linux commands and HiPerGator utilities, this walkthrough demonstrates running FastQC quality control on sequencing data using HiPerGator, from login to job completion.

## Step 1: Login to HiPerGator

    ssh ufid@hpg2.rc.ufl.edu

After authentication, you'll see the login message:

    Welcome to UF Research Computing                        
                            ________________________________                        
             The user agrees to comply with Research Computing's policies.          
                     https://www.rc.ufl.edu/documentation/policies/                 
                                     Backup Policy                                  
                                     _____________                                  
    Data on Research Computing storage systems is NOT backed up without investment
    in backup services.  Please visit the link below for more information.
                 https://www.rc.ufl.edu/documentation/policies/storage/             
                                   UFIT Policy Notice                               
                                   __________________                               
    The user understands and acknowledges that the computer and the network are the
    property of the University of Florida (UF). The user agrees to comply with the
    UF Acceptable Use Policy and Guidelines. UF monitors computer and network
    activities without user authorization. UF may provide information about computer
    or network usage to UF officials, including law enforcement when warranted.
    Therefore, the user should have limited expectations of privacy.
    [ufid@login7 ~]$

## Step 2: Navigate and Explore

Check your current location:

    [ufid@login7 ~]$ pwd
    [ufid@login7 ~]$ ls

Output:

    /home/ufid
    bin  bin/  perl5/  R/

Navigate to your group's blue storage:

    [ufid@login7 ~]$ cd /blue/my-group/ufid
    [ufid@login7 ufid]$ ls

Output:

    project1/  project2/  reference-genomes/

## Step 3: Set Up Project Directory

Create a new project directory:

    [ufid@login7 ufid]$ mkdir fastqc-demo
    [ufid@login7 ufid]$ cd fastqc-demo
    [ufid@login7 fastqc-demo]$ ls -la

Output:

    total 2
    drwxr-xr-x  2 ufid my-group   40 Oct  9 13:15 .
    drwxr-xr-x 15 ufid my-group 4096 Oct  9 13:15 ..

## Step 4: Create Data Links

Make a directory for data links and create symlinks to your sequencing data.

**Why flatten the file structure?**

Sequencing data is often delivered in complex nested directory structures that are cumbersome to reference when running bioinformatics tools. For example:

    lane1/sample1/sample1_R1.fastq.gz
    lane1/sample1/sample1_R2.fastq.gz  
    lane2/sample2/sample2_R1.fastq.gz
    lane2/sample2/sample2_R2.fastq.gz

When all we really care about for our analysis is:

    sample1_R1.fastq.gz
    sample1_R2.fastq.gz
    sample2_R1.fastq.gz  
    sample2_R2.fastq.gz

This nested structure isn't always the case, but while we're learning, let's see how to flatten this to make our scripts simpler and more readable.

    [ufid@login7 fastqc-demo]$ mkdir raw-data-links
    [ufid@login7 fastqc-demo]$ cd raw-data-links

Use `ls` to test out a filepath that matches the files we want to create symlinks to:

    [ufid@login7 raw-data-links]$ ls /orange/my-group/seq-project-2024/*sample*

Output:

    /orange/my-group/seq-project-2024/sample-1_7-369_5-321_L002:
    sample-1_S1_L002_R1_001.fastq.gz  sample-1_S1_L002_R2_001.fastq.gz
    
    /orange/my-group/seq-project-2024/sample-2_7-370_5-322_L002:
    sample-2_S2_L002_R1_001.fastq.gz  sample-2_S2_L002_R2_001.fastq.gz
    
    /orange/my-group/seq-project-2024/sample-3_7-371_5-323_L002:
    sample-3_S3_L002_R1_001.fastq.gz  sample-3_S3_L002_R2_001.fastq.gz
    
    /orange/my-group/seq-project-2024/sample-4_7-372_5-324_L002:
    sample-4_S4_L002_R1_001.fastq.gz  sample-4_S4_L002_R2_001.fastq.gz
    
    /orange/my-group/seq-project-2024/sample-5_7-373_5-325_L002:
    sample-5_S5_L002_R1_001.fastq.gz  sample-5_S5_L002_R2_001.fastq.gz

Create the symlinks with `find`, `exec`, and `ln -s`:

    # find searches directories recursively
    # -name "*.fastq.gz" finds files ending in .fastq.gz
    # -exec runs a command on each found file
    # {} represents each found file
    # \; ends the -exec command
    [ufid@login7 raw-data-links]$ find /orange/my-group/seq-project-2024/*sample* -name "*.fastq.gz" -exec ln -s {} . \;

Check the output:

    [ufid@login7 raw-data-links]$ ls -l

Output:

    total 40
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-1_S1_L002_R1_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-1_7-369_5-321_L002/sample-1_S1_L002_R1_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-1_S1_L002_R2_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-1_7-369_5-321_L002/sample-1_S1_L002_R2_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-2_S2_L002_R1_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-2_7-370_5-322_L002/sample-2_S2_L002_R1_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-2_S2_L002_R2_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-2_7-370_5-322_L002/sample-2_S2_L002_R2_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-3_S3_L002_R1_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-3_7-371_5-323_L002/sample-3_S3_L002_R1_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-3_S3_L002_R2_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-3_7-371_5-323_L002/sample-3_S3_L002_R2_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-4_S4_L002_R1_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-4_7-372_5-324_L002/sample-4_S4_L002_R1_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-4_S4_L002_R2_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-4_7-372_5-324_L002/sample-4_S4_L002_R2_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-5_S5_L002_R1_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-5_7-373_5-325_L002/sample-5_S5_L002_R1_001.fastq.gz
    lrwxrwxrwx 1 ufid my-group 160 Oct  9 13:42 sample-5_S5_L002_R2_001.fastq.gz -> /orange/my-group/seq-project-2024/sample-5_7-373_5-325_L002/sample-5_S5_L002_R2_001.fastq.gz

Count your samples by piping the output of `ls` to `wc -l`:

    [ufid@login7 raw-data-links]$ ls | wc -l

Output:

    10

So we have 10 files (5 samples, R1/R2 pairs).

## Step 5: Start Development Session

Go back to project directory and start an interactive session:

    [ufid@login7 raw-data-links]$ cd ../
    [ufid@login7 fastqc-demo]$ srundev --time 01:00:00 --cpus-per-task=2 --mem=16GB

You'll see:

    Starting an interactive session in the hpg-dev partition
    Command: srun -p hpg-dev --time=01:00:00 --mem=6gb --time 01:00:00 --cpus-per-task=2 --mem=16GB --pty -u bash -i
    srun: job 15258881 queued and waiting for resources
    srun: job 15258881 has been allocated resources
    [ufid@c0709a-s30 fastqc-demo]$

Notice the prompt changed - you're now on a compute node! Understand that what node you are "on" is unrelated to where you are working in the filesystem.

## Step 6: Test FastQC

Load FastQC and get some information about it to understand how to run it. You can use this flag `--help` for any module loaded.

    [ufid@c0709a-s30 fastqc-demo]$ module load fastqc
    [ufid@c0709a-s30 fastqc-demo]$ fastqc --help

Output:

                FastQC - A high throughput sequence QC analysis tool
    
    SYNOPSIS
    
        fastqc seqfile1 seqfile2 .. seqfileN
    
        fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
               [-c contaminant file] seqfile1 .. seqfileN
    
    DESCRIPTION
    
        FastQC reads a set of sequence files and produces from each one a quality
        control report consisting of a number of different modules, each one of 
        which will help to identify a different potential type of problem in your
        data.
        
        If no files to process are specified on the command line then the program
        will start as an interactive graphical application.  If files are provided
        on the command line then the program will run with no user interaction 
        required.  In this mode it is suitable for inclusion into a standardised 
        analysis pipeline.
        
        The options for the program as as follows:
        
        -h --help       Print this help file and exit
        
        -v --version    Print the version of the program and exit
        
        -o --outdir     Create all output files in the specified output directory.
                        Please note that this directory must exist as the program
                        will not create it.  If this option is not set then the 
                        output file for each sequence file is created in the same
                        directory as the sequence file which was processed.
                        ......

Create a directory for output:

    [ufid@c0709a-s30 fastqc-demo]$ mkdir fastqc-results
    [ufid@c0709a-s30 fastqc-demo]$ ls

Output:

    fastqc-results  raw-data-links

Test on one sample pair, make sure to use -t 2 to use multi-threading for two samples. If you do not do this, the analysis will run one after the other and take twice as long (note multi-threading does not always scale that way).

    [ufid@c0709a-s30 fastqc-demo]$ fastqc -t 2 raw-data-links/sample-1_S1_L002_R1_001.fastq.gz raw-data-links/sample-1_S1_L002_R2_001.fastq.gz -o fastqc-results/

Output:

    application/gzip
    application/gzip
    Started analysis of sample-1_S1_L002_R1_001.fastq.gz
    Started analysis of sample-1_S1_L002_R2_001.fastq.gz
    Approx 5% complete for sample-1_S1_L002_R1_001.fastq.gz
    Approx 5% complete for sample-1_S1_L002_R2_001.fastq.gz
    ...
    Analysis complete for sample-1_S1_L002_R1_001.fastq.gz
    Analysis complete for sample-1_S1_L002_R2_001.fastq.gz

Great! FastQC worked. However, it took about ten minutes to run on both files, even with -t 2. Next, we'll make the most of our HiPerGator resources to enable maximum multi-threading and run it using the SLURM scheduler so we don't have to stay connected to the terminal session/dev node for the entire run.

First, exit the dev session:

    [ufid@c0709a-s30 fastqc-demo]$ exit

You're back on the login node:

    [ufid@login7 fastqc-demo]$

## Step 7: Prepare for Batch Job

Create log directory. This isn't technically required as you could write log files to your current working directory, but is best practice for organization.

    [ufid@login7 fastqc-demo]$ mkdir logs
    [ufid@login7 fastqc-demo]$ ls

Output:

    fastqc-results/  logs/  raw-data-links/

## Step 8: Create Batch Script

Create the job script:

    [ufid@login7 fastqc-demo]$ nano fastqc-job.sbatch

In nano, type:

    #!/bin/bash
    #SBATCH --job-name=fastqc
    #SBATCH --output=logs/fastqc_%A_%a.out
    #SBATCH --error=logs/fastqc_%A_%a.err
    #SBATCH --mail-type=ALL
    #SBATCH --mail-user=ufid@ufl.edu
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=2
    #SBATCH --mem=4gb
    #SBATCH --time=2:00:00
    #SBATCH --partition=hpg-default
    #SBATCH --array=1-5%2
    
    # Load module
    module load fastqc
    
    # Get sample name based on array task ID
    sample=$(ls raw-data-links/*_R1_*.fastq.gz | sed -n "${SLURM_ARRAY_TASK_ID}p" | sed 's/.*\///; s/_R1_.*/.fastq.gz//')
    
    # Run FastQC on both R1 and R2
    fastqc -t 2 --outdir=fastqc-results raw-data-links/${sample}_R1_001.fastq.gz raw-data-links/${sample}_R2_001.fastq.gz
    
    echo "Completed FastQC for sample: $sample"

Save and exit nano (Ctrl+X, Y, Enter).

## Step 9: Submit Job

Submit the job:

    [ufid@login7 fastqc-demo]$ sbatch fastqc-job.sbatch

Output:

    Submitted batch job 12345679

Check job status:

    [ufid@login7 fastqc-demo]$ squeue -u $USER

Output:

                 JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            12345679_1   hpg-def   fastqc     ufid  R       0:15      1 c25a-s29
            12345679_2   hpg-def   fastqc     ufid  R       0:15      1 c25a-s30
            12345679_3   hpg-def   fastqc     ufid PD       0:00      1 (Resources)

## Step 10: Monitor Progress

Check completed jobs:

    [ufid@login7 fastqc-demo]$ ls logs/

Output:

    fastqc_12345679_1.err  fastqc_12345679_1.out  fastqc_12345679_2.err  fastqc_12345679_2.out

Check a log file:

    [ufid@login7 fastqc-demo]$ more logs/fastqc_12345679_1.out

Output:

    Started analysis of sample-1_S1_L002_R1_001.fastq.gz
    Approx 15% complete for sample-1_S1_L002_R1_001.fastq.gz
    Approx 30% complete for sample-1_S1_L002_R1_001.fastq.gz
    ...
    Analysis complete for sample-1_S1_L002_R1_001.fastq.gz
    Started analysis of sample-1_S1_L002_R2_001.fastq.gz
    ...
    Analysis complete for sample-1_S1_L002_R2_001.fastq.gz
    Completed FastQC for sample: sample-1_S1_L002

Check output directory:

    [ufid@login7 fastqc-demo]$ ls fastqc-results/ | head -8

Output:

    sample-1_S1_L002_R1_001_fastqc.html
    sample-1_S1_L002_R1_001_fastqc.zip
    sample-1_S1_L002_R2_001_fastqc.html
    sample-1_S1_L002_R2_001_fastqc.zip
    sample-2_S2_L002_R1_001_fastqc.html
    sample-2_S2_L002_R1_001_fastqc.zip
    sample-2_S2_L002_R2_001_fastqc.html
    sample-2_S2_L002_R2_001_fastqc.zip

## Step 11: Check Final Status

Once all jobs complete:

    [ufid@login7 fastqc-demo]$ squeue -u $USER

Output:

                 JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)

Count output files:

    [ufid@login7 fastqc-demo]$ ls fastqc-results/*.html | wc -l

Output:

    10

Perfect! We have FastQC reports for all 5 samples (10 files total).

## Step 12: Download Results

You can now download the HTML reports to view quality control results, or proceed with the next steps in your analysis pipeline.

### Option A: Using scp from your local terminal

Open a new terminal on your local machine and navigate to where you want the files:

    cd ~/Desktop/fastqc-results
    scp -r ufid@hpg2.rc.ufl.edu:/blue/my-group/ufid/fastqc-demo/fastqc-results/ .

Or download just the HTML files:

    scp ufid@hpg2.rc.ufl.edu:/blue/my-group/ufid/fastqc-demo/fastqc-results/*.html .

### Option B: Using MobaXterm

If you are using MobaXterm, you can directly download from the terminal sidebar:

1. In MobaXterm, use the built-in file browser (left panel)
2. Navigate to `/blue/my-group/ufid/fastqc-demo/fastqc-results/`
3. Select all HTML files (Ctrl+click multiple files)
4. Right-click and choose "Download" or drag files to your local folder

You can now open the HTML files in your web browser to review the quality control results for each sample.