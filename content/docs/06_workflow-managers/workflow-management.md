---
title: "Workflow Tools - snakemake & targets"
linkTitle: "Workflow Tools"
summary: " "
---

## Introduction

Workflow tools let you automate the running and rerunning of code with multiple steps.

## Python - snakemake

### Getting Started

* [Official snakemake tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html) 
* [C. Titus Brown's draft book on using snakemake for bioinformatics](https://farm.cse.ucdavis.edu/~ctbrown/2023-snakemake-book-draft/)

### Handling complex inputs with input functions

In our workflows with deal with complex input-output structures, like having early phases of the pipeline work on one flight (file) at a time and later phases work on all of the files from a given site and year as a group.

This can be accomplished by defining custom input functions.

* [Introduction to Input Functions](https://www.embl.org/groups/bioinformatics-rome/blog/2022/10/guest-post-snakemake-input-functions-by-tim-booth/)
* See our [Everglades workflow Snakefile](https://github.com/weecology/EvergladesTools/blob/main/Zooniverse/Snakefile)

## R - targets
