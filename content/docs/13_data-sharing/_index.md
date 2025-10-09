---
title: "Data Sharing and Transfer"
linkTitle: "Data Sharing and Transfer"
weight: 13
summary: >
  Tools and methods for transferring, sharing, and managing research data
---

This collection covers the essential tools and platforms for moving research data between systems, sharing with collaborators, and managing file transfers at scale. From high-performance transfers between research computing systems to secure sharing with external partners, these guides help you choose the right approach for your data sharing needs.

The following pages cover different transfer and sharing methods, each with specific strengths for different use cases and data types:

**[Globus](globus/)** - High-performance, reliable transfers between research computing systems and institutions. Best for large datasets, automated transfers, and when you need transfer monitoring and recovery.

**[rclone](rclone/)** - Command-line tool for transferring files directly from cloud storage to HiPerGator. Ideal for bypassing local downloads and integrating cloud data into HPC workflows.

**[Dropbox](dropbox/)** - Easy collaborative file storage and sharing that requires no special expertise or accounts. UF Dropbox offers unlimited storage, automatic change notifications, and seamless sharing with both UF and external collaborators. Best for simple file sharing and when ease of use is prioritized over advanced features.

**[Microsoft OneDrive](onedrive/)** - UF's cloud storage solution (GatorCloud) with 1TB per user, version control, and 90-day file recovery. Supports restricted data including FERPA and offers both web and desktop access. Ideal for individual file storage, light collaboration, and when you need secure cloud access to sensitive data.

**[UF Share Drives](uf-share-drives/)** - Traditional network drives accessible via VPN for file sharing within UF. Limited by lack of concurrent editing, no version control, and VPN requirement for off-campus access. Best for legacy workflows and simple file storage when cloud solutions aren't suitable.

For guidance on data management best practices, see our sections on [Data Organization](link) and [Data Security](link).

{{< list_children >}}
