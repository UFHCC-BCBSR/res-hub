+++
title = "HiPerGator Intro Guide"
category = "Computing"
+++
Portions copied and adapted from [https://wiki.weecology.org/](https://wiki.weecology.org/docs/computers-and-programming/hipergator-intro-guide/)

## So you want to run your analysis on HiperGator

## Introduction
This guide gives a high level overview of how to run bioinformatics pipelines, R, or python scripts on a high performance cluster (HPC). Getting familiar with HPC and HiperGator in particular is a learning curve if you are starting from zero, but can be worth it depending on your computational needs. The expected user is someone who has basic familiarity with linux and CLI but no HPC experience.

This is written for users of the [UFL HiperGator](https://docs.rc.ufl.edu/), but some information will apply to potential users for any HPC system and with any scripting language.

## HPC Use cases
There are two scenarios where you may want to run your bioinformatics analysis on the HPC.

1. **Your analysis takes a very long time to run**  
If your pipeline is taking several hours, days or more to run on your personal computer then using an HPC is likely a good option for two reasons:

    1) The servers on an HPC have processors much faster than desktops and laptops, so with minimal changes your code will run significantly faster

    2) Run analyses independently of your personal computer, so you can shutdown your personal computer while the analysis runs overnight or over the weekend. HPC systems can have a time limit of several weeks to a month for any single job.

    3) Parallel processing power. HPC servers have upwards of 64 cores (compared to ~4-8 on personal computers). This is a huge benefit for bioinformatics work either by running processes as multi-threaded (this is a requirement for many bioinformatics tasks like sequence assembly). In addition, you can manually spread the work out to multiple processors. For example, if you need to run FastQC on 96 samples, you can write an sbatch script to run the same command on all samples at the same time by starting 96 jobs (or 24 jobs with 4 samples in each). See https://docs.rc.ufl.edu/scheduler/job_arrays/

2. **Your analysis fills up your computer's memory and crashes when it runs.**  
When you have large genomic datasets, such as whole genome sequencing files, RNA-seq data, or large variant call files, it's easy to use up all the memory and freeze your computer or may not even be possible to store and process data on your local machine. Just like HPC servers have powerful processors, they also have extremely large amounts of memory. Usually greater than 100GB and up to several TB. They can handle whatever large datasets you throw at them.

## Should I bother with an HPC?

Your analysis and data can be of _any_ size. There is no minimum computational requirement to use an HPC. But understand there is a time cost involved with learning how to interact with an HPC and also optimizing your code so it runs most efficiently. Therefore, in some cases it isn't worth it.

Consider an example where you have a script that takes 1 hour on your laptop, and you must run it once a month. It's likely reasonable to just keep that workflow. But if a genome assembly takes 10 hours and you must run it once a week, then it's worth considering doing it on an HPC. Especially since that will decrease the wear and tear on your laptop and free up that 10 hours for other uses.

Whether it's worth it or not is unique to every situation. Also remember that once you learn all the HPC basics the first time, then that time cost isn't needed for your next project.

## What exactly is an HPC?
A high performance cluster (HPC) is primarily two things.

1. It's hundreds of individual servers in a data center. Each server is a computer just like your personal computer, but has more powerful components, and does not have a graphical user interface or even a monitor. You interact with the servers via the command line. If you've never used the command line consider it like the RStudio console, or a python prompt, was your _only_ way to interact with a computer. More on this below.

2. It's a system for scheduling, prioritizing, and running scripts from hundreds of users. This is how the hundreds of servers can be used as "one". Access to them is controlled by scheduling programs which you interact with, which then put your scripts in a queue to be run when resources are free. Slurm is probably the most popular scheduler (and the one used on the HiperGator) but some HPC systems may use other ones like [PBS or MOAB](https://en.wikipedia.org/wiki/Job_scheduler#Batch_queuing_for_HPC_clusters).

## Primary Steps to running your code on an HPC.

1. **You need an account**.  
    Signup for HiperGator HPC account [here]([https://docs.rc.ufl.edu/account/](https://docs.rc.ufl.edu/access/). To obtain a UFIT Research Computing account, you must be sponsored by a UF faculty member. 

2. **You must be able to login to the HPC via SSH and use the command line.**  
    The command line can also be referred to as the "unix shell". With this you use text commands (just like the RStudio console) to copy files, edit text files, interact with the scheduler, view job status, etc. See the [HiperGator Connection guide](https://docs.rc.ufl.edu/quickstart/).
    
    Some unix tutorials:
    - Data Carpentry [tutorial on the unix shell](https://swcarpentry.github.io/shell-novice/)
    - [Genomics Data Carpentry](https://datacarpentry.org/genomics-workshop/) unix introduction
    
    If you work on a Mac computer you have a full unix shell available already called the Terminal. For Windows users there are several options available including Windows Subsystem for Linux (WSL).

3. **You must optimize your code to run on the HPC.**  
    This is potentially the trickiest part. At a minimum your code must be able to run independently without any interaction from you. Do you have one large pipeline where you manually run different steps and check output before moving on? That will not work on an HPC. A single script or pipeline must run from start to finish and write results to files to be useful on the HPC.
    
    For R, a good test for this is the Jobs tab in RStudio (next to Console and Terminal tabs). This is _very_ analogous to running a script in an HPC environment. If your script can run as an RStudio Job without copying the local environment, then it should be able to run on the HPC.
    
    For python or bioinformatics pipelines, a good test is being able to run the script via the command line (ie. `python my_analysis.py` or `nextflow run pipeline.nf`). 
    
    Having a script run without any interaction does not necessarily mean it needs to have parallel processing. See "Should I make my code run parallel?" below.

4. **You have to get your code and data onto the HPC.**  
    You'll need to use special programs to transfer files from your local computer to the HPC. For Windows this can be programs like WinSCP or FileZilla. For Mac or Linux users you can use the Terminal to transfer files via the command line using the scp or rsync commands. More on data transfer for HiperGator can be found [here](https://docs.rc.ufl.edu/transfer/). 
    
    For large genomic datasets (100GB+), you'll want to use [Globus](https://docs.rc.ufl.edu/transfer/globus/) which is optimized for large file transfers.

5. **You need to ensure you have the correct software and packages.**  
    Most HPC systems will have common bioinformatics software installed and ready to use via the [module system](https://docs.rc.ufl.edu/software/modules/). Popular tools like BLAST, BWA, SAMtools, etc. are typically pre-installed.
    
    For Python packages, you'll want to use [conda environments](https://docs.rc.ufl.edu/software/conda/) or python virtual environments for your projects.
    
    For R packages, you can install them in your home directory and they'll be available for your jobs.
    
    If you run into errors installing software or packages you'll likely need to contact HPC support for help, especially if the errors involve missing system libraries.

6. **You can now submit your scripts to the scheduler.**  
    Once your data and scripts are on the HPC system you can submit them to the scheduler to run. This involves defining "jobs" where you tell the scheduler what you need. Specifically: the location of your script, the resources needed (cpus and memory), the time needed to run your script, the location for putting script output and logs, etc.
    
    Jobs are defined via batch scripts which have a line for each piece of information.
    
    Some examples:  
    - [Sample HiperGator batch scripts](https://docs.rc.ufl.edu/slurm/examples/)
    - [Annotated HiperGator batch script](https://docs.rc.ufl.edu/slurm/script_examples/)

7. **You might need to debug your script if it doesn't run correctly.**  
    It's very common for scripts to not run the first time because they were written on a personal computer and things like directory paths and software versions may be different. In this case it's useful to debug your script on the HPC directly.
    
    A good place to do this is an "interactive session". For these instead of submitting a job to the queue, you request a new unix shell where a small amount of resources are available. Here you can run your scripts and see the output directly, and make adjustments as needed until it runs successfully.
    
    - [HiperGator guide on interactive sessions](https://docs.rc.ufl.edu/slurm/interactive/)

8. **You can now get your results back.**  
    This is the same process as putting scripts and data onto the HPC but in reverse.

## Should I make my code run on parallel processes?
Before you dive into making your analysis parallel, do a quick cost/benefit analysis. It may indeed take a full day or more to redo your pipeline to take advantage of parallel processing, but the benefits could be extremely large. If your analysis already runs in a relatively short time, like a few hours on your laptop and less than an hour on the HPC without any modification, and you're happy with that then making it parallel might not be worth it.

If you do not use parallel processing then your jobs will always request just a single processor. This is perfectly fine as there is no minimum requirement for using an HPC.

Many bioinformatics tools have built-in parallel processing options (like BLAST's `-num_threads` parameter or BWA's `-t` option), so check your tool's documentation first.

## Make your scripts use parallel processing
By default most software runs on a single processor. Most computers today have 4-8 processors. If you spread the work out to multiple processors you can significantly decrease the amount of time it takes to run.

For example: a sequence alignment that takes 4 hours to run can potentially take 2 hours with 2 processors, or 1 hour with 4 processors. To make your analyses run across multiple processors, you'll have to make some adjustments to your code or pipeline.

For bioinformatics workflows:
- Many tools have built-in threading options (`-t`, `-p`, `--threads`, `--cores`)
- Workflow managers like [Nextflow](https://docs.rc.ufl.edu/software/nextflow/) and [Snakemake](https://docs.rc.ufl.edu/software/snakemake/) can automatically parallelize steps
- GNU Parallel can be used to run multiple instances of single-threaded tools

For R users, if your code uses lapply to run your main function to many items (e.g. processing multiple samples), you can swap it for mclapply from the parallel package without making substantial changes.

Some notes:
- If your pipeline processes multiple independent samples or genomic regions, it should be straightforward to make it parallel
- On your own computer, never set the amount of processors used to the max available. This will take away all the processing power needed to run the operating system and could potentially crash your computer
- Test parallel code on a small subset of your data first

## What about distributed computing?
The examples for parallel computing above show you how to utilize the multiple processors in a single system. In the case of the HPC this means up to (usually) 64-128 processors on a single server. But what if you still need more processing power? In this case it's possible to write parallel code which takes advantages of the processors on _numerous_ individual servers.

Going from single system parallel processing to distributed computing with your analysis is possible but will likely take even more work on your part. Workflow managers like Nextflow and Snakemake can help manage distributed computing across multiple nodes.

## Other considerations and important points
The Research Computing group has extensive [documentation on HiperGator usage](https://docs.rc.ufl.edu/).

**Login Node**: When you sign into the HPC there is a single landing server which you'll start on. It's important to never run actual analyses on this initial server. It should be used to submit jobs, request interactive sessions, or transfer data.

**Partitions**: HiperGator resources are divided into partitions, where each partition has a specific set of hardware and resource and time limits. Whenever you request resources you'll specify which partition you want to use. See the [partitions documentation](https://docs.rc.ufl.edu/slurm/partitions/).

**Account limits**: The resources you request (eg. number of processors and amount of memory) is limited by how many credits your group has purchased. The number of jobs which can be running concurrently is also determined by this. See more on the [account limits documentation](https://docs.rc.ufl.edu/account/limits/).

**Storage**: HiperGator has different storage systems optimized for different uses - home directories for small files, blue storage for large datasets, and temporary scratch space for job outputs. See the [storage documentation](https://docs.rc.ufl.edu/storage/) for details.

**Processors/CPU/Cores**: When you request resources via a batch script, you'll usually ask for multiple CPUs to implement parallel processing. For most bioinformatics applications, requesting CPUs and memory appropriately is sufficient.
