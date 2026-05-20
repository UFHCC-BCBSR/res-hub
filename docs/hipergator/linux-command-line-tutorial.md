---
title: "Linux Command Line for R Users"
subtitle: "A practical introduction for working on HiPerGator"
author: "Jason Orr Brant"
date: today
date-format: "MMMM D, YYYY"
---

# Introduction

Welcome to the Linux command line! If you're used to working in RStudio, think of the **bash shell** (the most common Linux command-line interpreter) as a text-based interface to your computer—very much like RStudio's console, but for your operating system rather than just R. Instead of clicking through menus and folder windows, you type commands to navigate, manage files, and run programs.

This tutorial is designed for R users who are new to Linux and HPC (high-performance computing) environments. By the end, you'll be comfortable enough to navigate the filesystem, manage files, run jobs, and launch a full RStudio session directly in your browser on UF's **HiPerGator** cluster.

> **💡 R Analogies Throughout**
> Because you already think in R, we'll use **R analogies** throughout this tutorial to connect new concepts to things you already know.

## Why Learn the Command Line?

- **HPC access is terminal-based.** HiPerGator doesn't have a graphical desktop — you connect via SSH and type commands.
- **Automation.** Shell scripts automate repetitive tasks the same way R scripts automate analyses.
- **Bioinformatics tools.** Nearly all genomics and bioinformatics software is designed to run from the command line.
- **Speed and power.** Many file operations (moving, searching, compressing thousands of files) are far faster on the command line than through a GUI.

---

# Getting Started

## Opening a Terminal

- **On a Mac**: Open **Terminal** (Applications → Utilities → Terminal) or use [iTerm2](https://iterm2.com/).
- **On Windows**: Use **Windows Terminal** with WSL (Windows Subsystem for Linux), or install [MobaXterm](https://mobaxterm.mobatek.net/) for HPC work.
- **On Linux**: Open your desktop's built-in terminal application.
- **On HiPerGator**: After logging in via SSH, you're already at a terminal.

## The Command Prompt

When you open a terminal, you'll see something like:

```bash
username@hostname:~$
```

| Part | Meaning |
|---|---|
| `username` | Your login name |
| `hostname` | The name of the machine you're on |
| `~` | Your current location (the `~` is shorthand for your home directory) |
| `$` | Indicates you are a regular (non-root) user |

> **📝 R Analogy**
> The prompt is like the `>` you see in R's console — it means the shell is ready for your next command.

## Key Terminology

| Term | Linux | R / RStudio Equivalent |
|---|---|---|
| **Directory** | A folder in the filesystem | A folder in the Files pane |
| **File** | Any stored object (script, data, log) | An `.R`, `.csv`, `.rds` file |
| **Command** | An instruction you type and run | A function call |
| **Shell** | The program (bash) that runs your commands | R's interpreter |
| **Working directory** | Where you currently "are" in the filesystem | `getwd()` result |
| **Path** | The address of a file or directory | A file path in `read.csv("path/to/file.csv")` |
| **Argument / Flag** | An option that modifies a command's behavior | A function argument |

---

# Navigating the Filesystem

## `pwd` — Where Am I?

`pwd` (**p**rint **w**orking **d**irectory) shows your current location.

```bash
pwd
```

```
/home/username
```

> **📝 R Analogy: `getwd()`**
> `pwd` is the shell equivalent of `getwd()` in R.

## `ls` — What's Here?

`ls` (**l**i**s**t) shows the contents of your current directory.

```bash
ls
```

```
data  results.csv  scripts
```

### Useful `ls` Options

| Command | What it does |
|---|---|
| `ls -l` | Long format — shows permissions, owner, size, and date |
| `ls -a` | Show **all** files, including hidden ones (starting with `.`) |
| `ls -lh` | Long format with **human-readable** file sizes (KB, MB, GB) |
| `ls -lt` | Long format sorted by **modification time**, newest first |
| `ls -lhS` | Sort by **file size**, largest first |

```bash
ls -lh
```

```
total 24K
drwxr-xr-x 2 username group 4.0K Jun 13 09:00 data
-rw-r--r-- 1 username group  12K Jun 13 08:55 results.csv
drwxr-xr-x 2 username group 4.0K Jun 13 09:01 scripts
```

> **📝 R Analogy: Files Pane**
> `ls` is like looking at RStudio's Files pane, and `ls -lh` is like switching to "Details" view.

## `cd` — Move Around

`cd` (**c**hange **d**irectory) navigates between directories.

```bash
cd data
pwd
```

```
/home/username/data
```

### Essential `cd` shortcuts

| Command | What it does |
|---|---|
| `cd ..` | Go up one level (parent directory) |
| `cd ~` or just `cd` | Go to your home directory |
| `cd /` | Go to the root of the entire filesystem |
| `cd -` | Go back to your previous directory |
| `cd /blue/cancercenter/username` | Use an **absolute path** to go anywhere directly |

> **💡 Absolute vs. Relative Paths**
>
> - An **absolute path** starts from root (`/`) and always works regardless of where you are: `/home/username/data`
> - A **relative path** is relative to your current location: `data` or `../scripts`
>
> This is exactly the same distinction as in R: `"/home/username/data/file.csv"` vs `"data/file.csv"`.

## Tab Completion

This is one of the most important habits to build. Press **Tab** after partially typing a file or directory name and bash will complete it for you. Press **Tab twice** to see all possible completions if there are multiple matches.

```bash
cd dat<TAB>   # completes to: cd data
```

This prevents typos and saves significant time.

---

# Managing Files and Directories

## `mkdir` — Create Directories

`mkdir` (**m**a**k**e **dir**ectory) creates a new folder.

```bash
mkdir analysis
ls
```

```
analysis  data  results.csv  scripts
```

Use `-p` to create nested directories all at once:

```bash
mkdir -p project/data/raw
```

This creates `project/`, `project/data/`, and `project/data/raw/` in one step — very useful for setting up project structures.

## `touch` — Create an Empty File

`touch` creates an empty file (or updates the timestamp of an existing one).

```bash
touch scripts/analysis.R
```

## `cp` — Copy Files and Directories

`cp` (**c**o**p**y) duplicates files or folders.

```bash
# Copy a file
cp results.csv results_backup.csv
# Copy into a directory
cp results.csv data/
# Copy a directory and all its contents (requires -r for recursive)
cp -r data data_backup
```

## `mv` — Move or Rename

`mv` (**m**o**v**e) moves files/directories or renames them. Unlike `cp`, the original is removed.

```bash
# Rename a file
mv analysis.R analysis_v1.R
# Move a file into a directory
mv analysis_v1.R scripts/
# Move and rename in one step
mv scripts/analysis_v1.R archive/analysis_final.R
```

## `rm` — Delete Files and Directories

> **⚠️ No Recycle Bin on Linux**
> `rm` permanently deletes files. There is no Trash or Undo. On HiPerGator especially, double-check before running `rm`.

```bash
# Delete a file
rm results_backup.csv
# Delete a directory and everything inside it
rm -r data_backup
# Interactive mode — asks for confirmation before each deletion (recommended)
rm -i important_file.csv
```

## `ln` — Create Symbolic Links

Symbolic links (symlinks) are like shortcuts or aliases — they point to a file or directory without duplicating it. This is very useful on HiPerGator for organizing data across filesystems without copying large files.

```bash
# Create a symlink called "raw_data" pointing to the actual data location
ln -s /blue/cancercenter/shared/project_data raw_data
ls -la
```

```
lrwxrwxrwx 1 username group   38 Jun 13 09:10 raw_data -> /blue/cancercenter/shared/project_data
```

---

# Viewing and Working with Files

## `cat` — Print File Contents

`cat` prints the entire contents of a file to the terminal. Best for small files.

```bash
cat scripts/analysis.R
```

## `less` — Scroll Through Files

`less` is for viewing large files interactively — it doesn't load everything at once.

```bash
less results.csv
```

| Key | Action in `less` |
|---|---|
| `Space` or `f` | Page down |
| `b` | Page back |
| `g` | Go to beginning |
| `G` | Go to end |
| `/<term>` | Search forward for `<term>` |
| `q` | Quit |

## `head` and `tail` — View File Beginnings/Ends

```bash
# First 10 lines (default)
head results.csv
# First 20 lines
head -n 20 results.csv
# Last 10 lines
tail results.csv
# Watch a file update in real time (great for monitoring log files)
tail -f rserver_12345.log
```

> **📝 R Analogy: `head()` and `tail()`**
> These work exactly like `head()` and `tail()` in R, and are especially useful for peeking at large data files without loading them.

## `wc` — Count Lines, Words, Characters

```bash
# Count lines in a file (-l for lines only)
wc -l results.csv
```

```
1001 results.csv
```

This tells you `results.csv` has 1001 lines — useful for quickly checking if a file has the expected number of rows.

## `grep` — Search Inside Files

`grep` searches for patterns (like `grep` or `stringr::str_detect()` in R).

```bash
# Find all lines containing "BRCA1"
grep "BRCA1" gene_list.txt
# Case-insensitive search
grep -i "brca1" gene_list.txt
# Show line numbers
grep -n "BRCA1" gene_list.txt
# Count matching lines
grep -c "BRCA1" gene_list.txt
# Search recursively in all files under a directory
grep -r "BRCA1" scripts/
```

---

# Pipes, Redirection, and Combining Commands

One of the most powerful aspects of the Linux command line is combining simple commands to accomplish complex tasks.

## Pipes: `|`

The pipe `|` sends the output of one command as the input to the next — exactly like R's `%>%` (magrittr) or `|>` (native pipe).

```bash
# Count how many files are in the current directory
ls -l | wc -l
# Find lines containing "error" in a log, then show only the first 20
grep "error" pipeline.log | head -20
# List unique sample IDs from column 1 of a file, sorted alphabetically
cut -f1 samples.txt | sort | uniq
```

> **📝 R Analogy: `|>` or `%>%`**
> `ls -l | wc -l` is like `list.files() |> length()` in R.

## Redirection: `>` and `>>`

Redirect output to a file instead of the terminal.

```bash
# Write output to a file (overwrites existing content)
ls -lh > file_list.txt
# Append output to a file (adds to the end)
echo "Analysis complete" >> run_notes.txt
```

> **⚠️ Warning**
> Using `>` will silently overwrite an existing file. Use `>>` when you want to add to an existing file.

## `echo` — Print Text

`echo` prints text to the terminal or into a file.

```bash
echo "Hello, HiPerGator"
# Write a simple header into a new file
echo "sample_id,condition,batch" > metadata.csv
```

---

# Getting Help

## `man` — Manual Pages

```bash
man ls
```

`man` opens the full manual for a command. Navigate with the same keys as `less`, and press `q` to quit.

## `--help`

Most commands also accept a `--help` flag for a shorter summary:

```bash
ls --help
cp --help
```

> **📝 R Analogy: `?`**
> `man ls` is the shell equivalent of `?ls` in R — it's the built-in help system.

## `which` — Find Where a Command Lives

```bash
which R
which python
```

```
/apps/compilers/gcc/12.2.0/R/4.4.1/bin/R
```

This tells you which version of a program is currently active — very useful on HPC systems where multiple versions may be installed.

---

# Working on HiPerGator

HiPerGator uses the **SLURM** workload manager to schedule and run computational jobs. Rather than running analyses directly (which would use shared login-node resources), you submit jobs to a queue, and SLURM allocates compute nodes for you.

## Connecting via SSH

From your local terminal:

```bash
ssh username@hpg.rc.ufl.edu
```

You'll be prompted for your password and Duo two-factor authentication.

## The Module System

HiPerGator uses **Lmod** (Environment Modules) to manage software. Rather than having all software installed globally, you load only what you need.

```bash
# See what modules are currently loaded
module list
# Search for available versions of a package
module spider R
# Load a specific module
module load R
# Unload a module
module unload R
# Remove all loaded modules (start fresh)
module purge
```

## Filesystems on HiPerGator

| Filesystem | Location | Best For | Notes |
|---|---|---|---|
| **Home** | `/home/username` | Scripts, config files | Small quota (~40 GB), backed up |
| **Blue** | `/blue/cancercenter/username` | Primary project data and results | Large quota, not backed up |
| **Orange** | `/orange/cancercenter/username` | Long-term storage, archiving | Slower I/O than blue |

> **💡 Tip**
> Run large pipelines (like `nf-core/methylseq`) with data on `/blue`. Use `/orange` for archiving completed projects.

## SLURM: Submitting Jobs

### Key SLURM Commands

| Command | What it does |
|---|---|
| `sbatch script.sh` | Submit a job script to the queue |
| `squeue -u $USER` | Check the status of your jobs |
| `scancel <jobid>` | Cancel a running or pending job |
| `sinfo` | View available partitions and node status |

### Anatomy of a SLURM Script

A SLURM batch script is a bash script with special `#SBATCH` header lines that tell the scheduler what resources you need.

```bash
#!/bin/bash
#SBATCH --job-name=my_analysis       # Name shown in the queue
#SBATCH --nodes=1                    # Number of nodes (usually 1)
#SBATCH --ntasks=1                   # Number of parallel tasks
#SBATCH --cpus-per-task=4            # CPU cores per task
#SBATCH --mem=32gb                   # Memory to reserve
#SBATCH --time=04:00:00              # Max wall time (HH:MM:SS)
#SBATCH --output=%x_%j.log          # Log file (%x=jobname, %j=jobid)
#SBATCH --account=cancercenter-dept  # Billing account
#SBATCH --qos=cancercenter-dept      # Quality of service
#SBATCH --mail-type=END,FAIL         # Email on job end or failure
#SBATCH --mail-user=$USER@ufl.edu    # Your email

module purge
module load R/4.4.1

Rscript scripts/analysis.R
```

---

# Running RStudio on HiPerGator

Rather than working in a plain terminal, you can run a full **RStudio** session on a HiPerGator compute node and access it through your web browser — giving you a familiar environment while using the cluster's compute resources.

## Overview

The process works in three steps:

1. Submit a SLURM job that starts an RStudio Server (`rserver`) on a compute node
2. Set up an SSH tunnel from your laptop to that compute node
3. Open your browser to `http://localhost:8080`

## Step 1: Create the SLURM Script

Create a file called `rserver.sbatch` in your home directory with the following content:

```bash
#!/bin/bash
#SBATCH --job-name=rserver
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=02:00:00
#SBATCH --output=rserver_%j.log
#SBATCH --account=cancercenter-dept
#SBATCH --qos=cancercenter-dept
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=$USER@ufl.edu

module purge
module load R

rserver
```

> **💡 Tip**
> You can adjust `--mem` and `--time` based on your session needs. For interactive data exploration, 8–16 GB and 2–4 hours is usually sufficient. For memory-intensive work, you can go up to `--mem=64gb`.

You can create this file directly from the terminal:

```bash
# Open nano text editor to create the file
nano rserver.sbatch
```

Paste the content above, then press `Ctrl+O` to save and `Ctrl+X` to exit.

## Step 2: Submit the Job

```bash
sbatch rserver.sbatch
```

```
Submitted batch job 12345678
```

SLURM will print a **job ID** (e.g., `12345678`). The job may take a moment to start depending on queue wait times. Check its status with:

```bash
squeue -u $USER
```

```
JOBID     PARTITION  NAME     USER    ST  TIME  NODES  NODELIST
12345678  hpg2-comp  rserver  jbrant  R   0:23  1      c12345a-s42
```

Once `ST` shows `R` (Running), move on.

## Step 3: Read the Log File

Once the job is running, read its log file to get the SSH tunnel command:

```bash
cat rserver_12345678.log
```

The log will contain a line like:

```bash
ssh -N -L 8080:c12345a-s42.ufhpc:37546 username@hpg.rc.ufl.edu
```

Copy this entire line — you'll run it on your **local machine** (not on HiPerGator).

## Step 4: Open the SSH Tunnel

Open a **new terminal window on your local computer** (don't close the HiPerGator session). Paste and run the `ssh` command from the log:

```bash
ssh -N -L 8080:c12345a-s42.ufhpc:37546 username@hpg.rc.ufl.edu
```

| Part | Meaning |
|---|---|
| `-N` | Don't execute a remote command — just forward the port |
| `-L 8080:...` | Forward your local port 8080 to the compute node |
| `username@hpg.rc.ufl.edu` | Your HiPerGator login |

Enter your password and complete Duo authentication. **The terminal will appear to hang — this is normal.** The tunnel is active as long as this window is open. Do not close it.

## Step 5: Open RStudio in Your Browser

Open any web browser on your local computer and navigate to:

```
http://localhost:8080
```

You should see an RStudio login page. Log in with your HiPerGator credentials.

> **💡 Your RStudio Session Is Running on the Cluster**
> Everything you do in this RStudio session — loading data, running models, installing packages — is executing on the HiPerGator compute node, not your laptop. You can load files from `/blue/cancercenter/username/` just as you would from a local path.

## Ending Your Session

When you're finished:

1. Save your work and close RStudio in the browser
2. In the tunnel terminal on your laptop, press `Ctrl+C` to close the SSH tunnel
3. Cancel the SLURM job if time remains:

```bash
scancel 12345678
```

> **⚠️ Warning**
> If you simply close the tunnel window without canceling the job, the RStudio server continues running on the cluster (consuming your allocation) until the `--time` limit is reached.

---

# Putting It All Together: A Typical Workflow

Here's what a typical session on HiPerGator might look like for a biostatistician starting a new project:

```bash
# 1. Log in to HiPerGator
ssh username@hpg.rc.ufl.edu

# 2. Navigate to your project space on /blue
cd /blue/cancercenter/username

# 3. Create a structured project directory
mkdir -p my_project/{data/raw,data/processed,scripts,results,logs}

# 4. Check what you've created
ls -R my_project

# 5. Copy or link to shared data
ln -s /blue/cancercenter/shared/cohort_data my_project/data/raw/cohort_data

# 6. Transfer a local script (done from your local machine)
#    scp local_analysis.R username@hpg.rc.ufl.edu:/blue/cancercenter/username/my_project/scripts/

# 7. Submit an RStudio session to work interactively
sbatch rserver.sbatch

# 8. Check the log once it starts
tail -f rserver_*.log

# 9. Copy the SSH tunnel line, open it on your laptop, and go to http://localhost:8080
```

---

# Tips and Best Practices

- **Tab complete everything.** It prevents typos in file paths and saves time.
- **Use the up arrow** to scroll through command history — you rarely need to retype a long command.
- **`history`** prints your recent command history; `history | grep sbatch` finds all sbatch commands you've run.
- **`Ctrl+C`** cancels a running command if something goes wrong or hangs.
- **`Ctrl+L`** or `clear` clears the terminal screen.
- **Never run jobs on the login node.** Use `sbatch` for anything computationally intensive.
- **Be careful with `rm -r`.** On a shared filesystem, deleted files are gone forever. When in doubt, move things to an `archive/` folder first.
- **Check your quota** periodically with the `squota` utility available in our group's shared tools.

---

# Quick Reference

## Filesystem Navigation

| Command | Action |
|---|---|
| `pwd` | Print current directory |
| `ls -lh` | List directory contents with sizes |
| `cd <dir>` | Change directory |
| `cd ..` | Go up one level |
| `cd ~` | Go to home directory |

## File Management

| Command | Action |
|---|---|
| `mkdir -p <dir>` | Create directory (and parents) |
| `cp <src> <dst>` | Copy file |
| `cp -r <src> <dst>` | Copy directory recursively |
| `mv <src> <dst>` | Move or rename |
| `rm <file>` | Delete file (no undo!) |
| `rm -r <dir>` | Delete directory recursively |
| `ln -s <target> <link>` | Create symbolic link |

## Viewing Files

| Command | Action |
|---|---|
| `cat <file>` | Print file contents |
| `less <file>` | Scroll through a file |
| `head -n 20 <file>` | First 20 lines |
| `tail -f <file>` | Watch file update in real time |
| `wc -l <file>` | Count lines |
| `grep "pattern" <file>` | Search inside a file |

## SLURM

| Command | Action |
|---|---|
| `sbatch script.sbatch` | Submit a job |
| `squeue -u $USER` | Check your job status |
| `scancel <jobid>` | Cancel a job |
| `sacct -j <jobid>` | View completed job accounting info |

## Getting Help

| Command | Action |
|---|---|
| `man <command>` | Full manual page |
| `<command> --help` | Quick help summary |
| `which <program>` | Find where a program is installed |
| `module spider <name>` | Search for available software modules |

---

# Next Steps

Once you're comfortable with the basics covered here, explore:

- **`nano` or `vim`**: Terminal text editors for editing scripts directly on the cluster
- **`screen` or `tmux`**: Keep sessions running after you disconnect from SSH
- **Shell scripting**: Writing `.sh` scripts to automate pipelines (like writing R functions to wrap repeated code)
- **`awk` and `sed`**: Powerful text-processing tools for manipulating tabular data
- **`scp` and `rsync`**: Transfer files to and from HiPerGator
- **SLURM arrays**: Submit hundreds of parallel jobs with a single `sbatch` command

---

# Resources

- [UF Research Computing HiPerGator Documentation](https://help.rc.ufl.edu/)
- [SLURM Documentation](https://slurm.schedmd.com/documentation.html)
- [The Linux Command Line (free book)](https://linuxcommand.org/tlcl.php) by William Shotts
- [Software Carpentry: The Unix Shell](https://swcarpentry.github.io/shell-novice/)
- [Explain Shell](https://explainshell.com/) — paste any command to get a plain-English explanation
