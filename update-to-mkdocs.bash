#!/bin/bash

# ── CONFIG ─────────────────────────────────────────────────────────────────
BRANCH="mkdocs-migration"
# ───────────────────────────────────────────────────────────────────────────

# Create and switch to migration branch
git checkout -b $BRANCH

# ── REMOVE HUGO-SPECIFIC FILES ─────────────────────────────────────────────
rm -rf config layouts static/uploads hugoblox.yaml go.mod netlify.toml preview.png

# ── CREATE MKDOCS FOLDER STRUCTURE ─────────────────────────────────────────
mkdir -p .github/workflows
mkdir -p docs/assets/images
mkdir -p docs/assets/css
mkdir -p docs/presentations
mkdir -p docs/01_collaborating-with-us
mkdir -p docs/02_hipergator
mkdir -p docs/03_git-github
mkdir -p docs/04_command-line
mkdir -p docs/05_r-python
mkdir -p docs/06_workflow-managers
mkdir -p docs/09_experimental-design
mkdir -p docs/10_analysis-pipelines
mkdir -p docs/11_downstream-analysis
mkdir -p docs/13_data-sharing
mkdir -p docs/14_grant-writing
mkdir -p docs/15_publishing
mkdir -p docs/19_blog

# ── MOVE CONTENT FILES ─────────────────────────────────────────────────────

# Home
cp content/_index.md docs/index.md

# 01 Collaborating
cp content/docs/01_collaborating-with-us/how-to-work-with-us.md docs/01_collaborating-with-us/
cp content/docs/01_collaborating-with-us/who-we-are.md docs/01_collaborating-with-us/

# 02 HiPerGator
cp content/docs/02_hipergator/file-naming-conventions.md docs/02_hipergator/
cp content/docs/02_hipergator/hipergator-example.md docs/02_hipergator/
cp content/docs/02_hipergator/hipergator-intro-guide.md docs/02_hipergator/

# 03 Git/GitHub
cp content/docs/03_git-github/git-collaboration.md docs/03_git-github/
cp content/docs/03_git-github/git-tips.md docs/03_git-github/
cp content/docs/03_git-github/github-actions.md docs/03_git-github/
cp content/docs/03_git-github/github-cli-proj-management.md docs/03_git-github/
cp content/docs/03_git-github/rstudio-git-integration.md docs/03_git-github/

# 04 Command Line
cp content/docs/04_command-line/file-compression.md docs/04_command-line/
cp content/docs/04_command-line/ssh.md docs/04_command-line/

# 05 R/Python
cp content/docs/05_r-python/lab-code-style-guide.md docs/05_r-python/
cp content/docs/05_r-python/lab-coding-guidelines.md docs/05_r-python/
cp content/docs/05_r-python/parallelization-R.md docs/05_r-python/
cp content/docs/05_r-python/python-package-documentation.md docs/05_r-python/
cp content/docs/05_r-python/r-resources.md docs/05_r-python/
cp content/docs/05_r-python/software-testing-R.md docs/05_r-python/

# 06 Workflow Managers
cp content/docs/06_workflow-managers/workflow-management.md docs/06_workflow-managers/

# 09 Experimental Design
cp content/docs/09_experimental-design/ATAC-seq.md docs/09_experimental-design/
cp content/docs/09_experimental-design/RNA-seq.md docs/09_experimental-design/
cp content/docs/09_experimental-design/scRNA-seq.md docs/09_experimental-design/

# 10 Analysis Pipelines
cp content/docs/10_analysis-pipelines/ATAC-seq.md docs/10_analysis-pipelines/
cp content/docs/10_analysis-pipelines/CRISPR-Screen.md docs/10_analysis-pipelines/
cp content/docs/10_analysis-pipelines/cut-and-run.md docs/10_analysis-pipelines/
cp content/docs/10_analysis-pipelines/RNA-seq.md docs/10_analysis-pipelines/
cp content/docs/10_analysis-pipelines/scRNA-seq.md docs/10_analysis-pipelines/
cp content/docs/10_analysis-pipelines/spatial-visium-v2.md docs/10_analysis-pipelines/

# 11 Downstream Analysis
cp content/docs/11_downstream-analysis/pathway-enrichment.md docs/11_downstream-analysis/

# 13 Data Sharing
cp content/docs/13_data-sharing/globus.md docs/13_data-sharing/
cp content/docs/13_data-sharing/rclone.md docs/13_data-sharing/

# 14 Grant Writing
cp content/docs/14_grant-writing/bioinfo-plan.md docs/14_grant-writing/
cp content/docs/14_grant-writing/DMSP.md docs/14_grant-writing/
cp content/docs/14_grant-writing/key-personnel.md docs/14_grant-writing/
cp content/docs/14_grant-writing/publication-figures.md docs/14_grant-writing/

# 15 Publishing
cp content/docs/15_publishing/authorship.md docs/15_publishing/
cp content/docs/15_publishing/code-availability.md docs/15_publishing/
cp content/docs/15_publishing/data-availability.md docs/15_publishing/
cp content/docs/15_publishing/publication-figures.md docs/15_publishing/

# 19 Blog
cp content/docs/19_blog/bioinfo-blogs.md docs/19_blog/
cp content/docs/19_blog/discussion-questions.md docs/19_blog/
cp content/docs/19_blog/journal-club.md docs/19_blog/

# ── MOVE IMAGES ────────────────────────────────────────────────────────────
cp assets/media/assays-bubbles.HRK.subtitle.png docs/assets/images/
cp assets/media/icon.png docs/assets/images/
cp content/docs/03_git-github/github_PR_tab.png docs/assets/images/

# ── MOVE PRESENTATIONS ─────────────────────────────────────────────────────
cp static/presentations/st4us-power-presentation.html docs/presentations/
cp static/presentations/st4us-power-v2.html docs/presentations/

# ── CREATE REQUIREMENTS.TXT ────────────────────────────────────────────────
cat > requirements.txt << 'EOF'
mkdocs
mkdocs-material
EOF

# ── CREATE GITHUB ACTIONS WORKFLOW ─────────────────────────────────────────
cat > .github/workflows/deploy.yml << 'EOF'
name: Deploy MkDocs Site

on:
  push:
    branches:
      - main

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-python@v5
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Build and deploy
        run: mkdocs gh-deploy --force
EOF

# ── CREATE CUSTOM CSS ──────────────────────────────────────────────────────
cat > docs/assets/css/custom.css << 'EOF'
/* Add your custom styles here */
EOF

# ── CREATE MKDOCS.YML ──────────────────────────────────────────────────────
cat > mkdocs.yml << 'EOF'
site_name: UFHCC Biostatistics and Computational Biology Shared Resource
site_description: Resources, guides, and documentation for the UFHCC BCBSR
docs_dir: docs

theme:
  name: material
  logo: assets/images/icon.png
  favicon: assets/images/icon.png
  palette:
    primary: black
  features:
    - navigation.sections
    - toc.integrate
    - content.code.copy
  font:
    text: Roboto

markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences

extra_css:
  - assets/css/custom.css

extra:
  generator: false

nav:
  - Home: index.md
  - Collaborating With Us:
    - Who We Are: 01_collaborating-with-us/who-we-are.md
    - How to Work With Us: 01_collaborating-with-us/how-to-work-with-us.md
  - HiPerGator:
    - Intro Guide: 02_hipergator/hipergator-intro-guide.md
    - File Naming Conventions: 02_hipergator/file-naming-conventions.md
    - HiPerGator Example: 02_hipergator/hipergator-example.md
  - Git & GitHub:
    - Git Collaboration: 03_git-github/git-collaboration.md
    - Git Tips: 03_git-github/git-tips.md
    - GitHub Actions: 03_git-github/github-actions.md
    - GitHub CLI & Project Management: 03_git-github/github-cli-proj-management.md
    - RStudio Git Integration: 03_git-github/rstudio-git-integration.md
  - Command Line:
    - SSH: 04_command-line/ssh.md
    - File Compression: 04_command-line/file-compression.md
  - R & Python:
    - R Resources: 05_r-python/r-resources.md
    - Lab Coding Guidelines: 05_r-python/lab-coding-guidelines.md
    - Lab Code Style Guide: 05_r-python/lab-code-style-guide.md
    - Parallelization in R: 05_r-python/parallelization-R.md
    - Python Package Documentation: 05_r-python/python-package-documentation.md
    - Software Testing in R: 05_r-python/software-testing-R.md
  - Workflow Managers:
    - Workflow Management: 06_workflow-managers/workflow-management.md
  - Experimental Design:
    - RNA-seq: 09_experimental-design/RNA-seq.md
    - ATAC-seq: 09_experimental-design/ATAC-seq.md
    - scRNA-seq: 09_experimental-design/scRNA-seq.md
  - Analysis Pipelines:
    - RNA-seq: 10_analysis-pipelines/RNA-seq.md
    - ATAC-seq: 10_analysis-pipelines/ATAC-seq.md
    - scRNA-seq: 10_analysis-pipelines/scRNA-seq.md
    - CRISPR Screen: 10_analysis-pipelines/CRISPR-Screen.md
    - CUT&RUN: 10_analysis-pipelines/cut-and-run.md
    - Spatial Visium: 10_analysis-pipelines/spatial-visium-v2.md
  - Downstream Analysis:
    - Pathway Enrichment: 11_downstream-analysis/pathway-enrichment.md
  - Data Sharing:
    - Globus: 13_data-sharing/globus.md
    - Rclone: 13_data-sharing/rclone.md
  - Grant Writing:
    - Bioinformatics Plan: 14_grant-writing/bioinfo-plan.md
    - DMSP: 14_grant-writing/DMSP.md
    - Key Personnel: 14_grant-writing/key-personnel.md
    - Publication Figures: 14_grant-writing/publication-figures.md
  - Publishing:
    - Authorship: 15_publishing/authorship.md
    - Code Availability: 15_publishing/code-availability.md
    - Data Availability: 15_publishing/data-availability.md
    - Publication Figures: 15_publishing/publication-figures.md
  - Blog:
    - Bioinformatics Blogs: 19_blog/bioinfo-blogs.md
    - Journal Club: 19_blog/journal-club.md
    - Discussion Questions: 19_blog/discussion-questions.md

copyright: >
  © 2026 UF Health Cancer Institute Biostatistics and Computational Biology Shared Resource
EOF

# ── CLEAN UP HUGO FILES ────────────────────────────────────────────────────
rm -rf content assets static

# ── COMMIT AND PUSH ────────────────────────────────────────────────────────
git add .
git commit -m "Migrate site from Hugo to MkDocs"
git push -u origin $BRANCH

echo ""
echo "✅ Done! Branch '$BRANCH' pushed to GitHub."
echo "👉 Review the branch at: https://github.com/UFHCC-BCBSR/res-hub/tree/$BRANCH"
echo "👉 When ready, merge to main and the site will redeploy at: https://ufhcc-bcbsr.github.io/res-hub/"
