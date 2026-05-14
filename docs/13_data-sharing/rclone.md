---
title: "rclone"
linkTitle: "rclone"
date: 2025-09-09
summary: >
  Transfer files directly from cloud storage to HiPerGator using rclone
weight: 2
---

## Overview

rclone is the most efficient way to transfer large files directly from cloud storage services (Dropbox, Google Drive, etc.) to HiPerGator without downloading them to your local machine first.

## When to Use rclone

- **Large file transfers** from cloud storage to HiPerGator
- **Globus workflows** - Use rclone to get files onto HiPerGator first, then use Globus to transfer between the UFRC Endpoint and your final destination
- **Avoiding local downloads** - Skip the intermediate step of syncing to your laptop

## Setup Process

### 1. Initial Configuration
Use an Open OnDemand Desktop session for the one-time setup to easily authenticate through a web browser:

1. Start a desktop session at https://ood.rc.ufl.edu
2. Open a terminal and load the rclone module
3. Follow the [UFRC rclone documentation](https://docs.rc.ufl.edu/software/apps/rclone/) to add your cloud storage remote

### 2. Daily Usage
After initial setup, you can use rclone commands in regular SSH sessions.

## Best Practices

- **Use sbatch jobs** for large transfers to avoid interruption
- **Test small transfers first** to verify your configuration
- **Monitor transfer progress** especially for large datasets

## Example Commands

```bash
# List remote directories
rclone lsd remote_name:

# Copy from cloud to HiPerGator
rclone copy remote_name:/path/to/files /blue/group/user/destination/

# Sync directories (mirror)
rclone sync remote_name:/source/ /blue/group/user/destination/
```
