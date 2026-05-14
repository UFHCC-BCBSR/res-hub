---
title: "Project Management using GitHub cli and Github.com Projects"
linkTitle: "Github - Projects"
summary: " "
---

# AI-Assisted (optional) GitHub Repository and Project Setup Guide

This guide documents the process of using AI chatbots (particularly Claude via chat.it.ufl.edu) to create and organize a research project with GitHub repositories, issues, and project boards.

You can follow this same workflow without AI chatbots and manually create the scripts below based on the example templates provided.

Unless your project is very simple or in a very well-documented one-size-fits-all area, you will certainly need to edit the scripts and/or resulting outputs below, but this makes starting and getting organized more efficient and thorough.

## Prerequisites

On HiPerGator:
\`\`\`bash
ml github-cli
\`\`\`

## Step 1: Create Local Directory Structure

### Using AI Chatbot Assistance

1. Go to [chat.it.ufl.edu](https://chat.it.ufl.edu)
2. Use Claude (preferred) with a prompt like:

\`\`\`
I'm starting a research project analyzing [your data type]. I have:
- Data: [describe your data sources and formats]
- Goal: [your analysis objectives]
- Tools: [programming language, packages, libraries you plan to use]

Please create a bash script called make-dirs.sh that will:
1. Create an organized directory structure for this project
2. Include checks to avoid overwriting existing directories
3. Include safety prompts before creating directories
4. Create placeholder files for documentation and environment configs
5. Use best practices for data management and security

The structure should support reproducible research with clear separation of:
- Raw data (never modified)
- Processed/intermediate data
- Scripts/code organized by analysis phase
- Results (figures, tables, reports)
- Documentation
- Environment specifications
\`\`\`

### Example Output

\`\`\`bash
#!/bin/bash
# Create directory structure for research project
# Safety check
if [ -d "data" ] || [ -d "scripts" ] || [ -d "results" ]; then
    echo "Warning: Some directories already exist!"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create main structure
mkdir -p {data/{raw,processed,metadata},scripts/{01_preprocessing,02_analysis,03_visualization},results/{figures,tables,reports},docs,environment}

# Create placeholder files
touch environment/requirements.txt
touch environment/conda_env.yml
touch environment/session_info.txt
touch docs/methods.md
touch docs/data_dictionary.md
touch docs/analysis_notes.md
touch README.md

echo "Directory structure created successfully!"
echo "Run 'tree -L 2' to view the structure"
\`\`\`

### Execute the Script

\`\`\`bash
bash make-dirs.sh
tree -L 2
\`\`\`

## Step 2: Create GitHub Repository using GitHub CLI

### First-Time GitHub CLI Authentication

1. **Load GitHub CLI module** (on HiPerGator):
\`\`\`bash
ml github-cli
\`\`\`

2. **Authenticate GitHub CLI** (one-time setup):
\`\`\`bash
gh auth login
\`\`\`

Follow the prompts:
- Choose: GitHub.com
- Protocol: HTTPS
- Authenticate with: Login with a web browser
- Copy the one-time code shown
- Press Enter to open the browser (or manually go to github.com/login/device)
- Paste the code and authorize

Your credentials are now stored and you won't need to authenticate again on this system.

### Create the Remote Repository

\`\`\`bash
# Initialize local git repo
git init

# Create remote repository on GitHub
# On your personal account
gh repo create my-research-project --public --source=. --remote=origin
# In an organization
gh repo create the-org/my-research-project --public --source=. --remote=origin

# Alternative: create private repo
gh repo create my-research-project --private --source=. --remote=origin
\`\`\`

Options:
- `--public` or `--private`: set visibility
- `--source=.`: use current directory as source
- `--remote=origin`: set up origin remote
- `--description "Brief project description"`: add description

### Initial Commit

### Initial Commit

1. **Create a .gitignore file**

Open a text editor and create a file called `.gitignore` in your project root:

\`\`\`bash
nano .gitignore
# or
vim .gitignore
# or use any text editor
\`\`\`

2. **Add patterns to .gitignore** (as needed for your repo content):

\`\`\`
# Data files (omit data if it is protected/sensitive or large)
data/raw/*
data/processed/*
!data/raw/.gitkeep
!data/processed/.gitkeep

# Environment
.Rproj.user
.Rhistory
.RData
.Ruserdata
*.Rproj
__pycache__/
*.pyc
.venv/
env/
\`\`\`

**What these patterns mean:**
- `data/raw/*` - ignores all files in the data/raw directory
- `!data/raw/.gitkeep` - EXCEPT the .gitkeep file (so the empty directory structure is preserved)

Save and close the file.

3. **Create .gitkeep files** (these are empty placeholder files to preserve directory structure in git):

\`\`\`bash
touch data/raw/.gitkeep
touch data/processed/.gitkeep
touch results/figures/.gitkeep
\`\`\`

4. **Stage all files:**

\`\`\`bash
git add .
\`\`\`

5. **Create initial commit:**

\`\`\`bash
git commit -m "Initial commit: directory structure and documentation"
\`\`\`

6. **Push to GitHub:**

\`\`\`bash
git push -u origin main
\`\`\`
\`\`\`

## Step 3: Create Issues with AI Assistance

### Using AI to Generate Issues Script

Again, AI assistance is optional here. You may refer to this template and write your own, or prompt an AI chatbot and edit the result.

Prompt the chatbot with:

\`\`\`
I need to create GitHub issues for my project. Here's my plan:

Project Goal: [your overall objective]

Milestones/Phases:
1. [Phase name]: [description]
2. [Phase name]: [description]
...

For each phase, I need issues that:
- Have clear, actionable tasks with checkboxes
- Include acceptance criteria
- Are labeled appropriately (data-prep, analysis, QC, documentation, etc.)
- Are assigned to the correct milestone
- Flag any blockers or dependencies

Please create a bash script called make-issues.sh that uses GitHub CLI to:
1. Create appropriate labels with colors
2. Create milestones for each phase
3. Create detailed issues for each task
4. Handle errors gracefully (if labels/milestones already exist)

Current blockers: [mention any data/access/dependencies you're waiting on]
\`\`\`

### Example Output: make-issues.sh

\`\`\`bash
#!/bin/bash
echo "=========================================="
echo "Setting up Project Issues"
echo "=========================================="
echo ""

# Create labels
echo "📋 Creating labels..."
gh label create "data-prep" --color "0052CC" --description "Data organization" 2>/dev/null || true
gh label create "analysis" --color "5319E7" --description "Analysis tasks" 2>/dev/null || true
gh label create "documentation" --color "0E8A16" --description "Documentation" 2>/dev/null || true
gh label create "QC" --color "FBCA04" --description "Quality control" 2>/dev/null || true
gh label create "visualization" --color "C2E0C6" --description "Figures and plots" 2>/dev/null || true
gh label create "priority" --color "B60205" --description "High priority" 2>/dev/null || true
gh label create "blocked" --color "D93F0B" --description "Blocked/waiting" 2>/dev/null || true
echo "✅ Labels created!"
echo ""

# Create milestones
echo "🎯 Creating milestones..."
gh api repos/:owner/:repo/milestones \
  -f title="Phase 1: Data Organization" \
  -f description="Collect and organize raw data" \
  2>/dev/null || echo "  Milestone already exists"

gh api repos/:owner/:repo/milestones \
  -f title="Phase 2: Preprocessing" \
  -f description="Clean and prepare data for analysis" \
  2>/dev/null || echo "  Milestone already exists"

gh api repos/:owner/:repo/milestones \
  -f title="Phase 3: Analysis" \
  -f description="Main statistical analysis" \
  2>/dev/null || echo "  Milestone already exists"
  
gh api repos/:owner/:repo/milestones \
  -f title="Phase 4: Visualization" \
  -f description="Create figures and reports" \
  2>/dev/null || echo "  Milestone already exists"
echo "✅ Milestones ready!"
echo ""

# Create issues
echo "🎫 Creating issues..."
echo ""

# Issue 1
echo "  Creating Issue #1: Data organization"
gh issue create \
  --title "Phase 1: Set up data directory and download raw data" \
  --label "data-prep,priority" \
  --milestone "Phase 1: Data Organization" \
  --body "## Tasks
- [ ] Run directory creation script
- [ ] Download raw data from [source]
- [ ] Verify data integrity (checksums if available)
- [ ] Create data dictionary in docs/data_dictionary.md
- [ ] Document data provenance in README

## Acceptance Criteria
- All raw data files present in data/raw/
- Data dictionary complete with variable descriptions
- README documents data source and download date
- No manual modifications to raw data"

# Issue 2
echo "  Creating Issue #2: Environment setup"
gh issue create \
  --title "Phase 1: Configure computational environment" \
  --label "data-prep,documentation" \
  --milestone "Phase 1: Data Organization" \
  --body "## Tasks
- [ ] Create requirements.txt or conda_env.yml
- [ ] List all package versions
- [ ] Test environment on clean install
- [ ] Document system requirements in README

## Acceptance Criteria
- Environment file includes all dependencies with versions
- README has installation instructions
- Environment reproducible from file alone"

# Issue 3
echo "  Creating Issue #3: Data preprocessing"
gh issue create \
  --title "Phase 2: Data cleaning and preprocessing" \
  --label "analysis,QC" \
  --milestone "Phase 2: Preprocessing" \
  --body "## Tasks
- [ ] Load and inspect raw data
- [ ] Check for missing values
- [ ] Check for outliers
- [ ] Document all preprocessing decisions
- [ ] Save processed data to data/processed/

## Quality Checks
- [ ] Verify no data loss during processing
- [ ] Check distributions before/after
- [ ] Document all filtering criteria

## Acceptance Criteria
- Preprocessing script runs without errors
- Processed data saved with meaningful filename
- QC report generated with summary statistics"

# Issue 4 - Example of a blocked issue
echo "  Creating Issue #4: Statistical analysis (BLOCKED)"
gh issue create \
  --title "Phase 3: Run statistical analysis" \
  --label "analysis,blocked" \
  --milestone "Phase 3: Analysis" \
  --body "## ⚠️ BLOCKED
Waiting for:
- [ ] Preprocessed data (Issue #3)
- [ ] Approval of analysis plan from PI

## Tasks
- [ ] Implement statistical tests
- [ ] Calculate effect sizes
- [ ] Perform multiple testing correction
- [ ] Generate results tables

## Acceptance Criteria
- Analysis script documented with comments
- Results saved to results/tables/
- Methods documented in docs/methods.md"

echo ""
echo "✅ All issues created!"
echo ""
echo "Next steps:"
echo "1. Go to your repo on GitHub.com"
echo "2. Click on 'Issues' to see all created issues"
echo "3. Set up a Project board (see next section)"
\`\`\`

### Execute the Issues Script

\`\`\`bash
bash make-issues.sh
\`\`\`

**Note:** The issues are created directly on GitHub.com via the GitHub API - they are NOT stored in `.git` locally. The `gh issue create` command immediately creates them in your remote repository.

## Step 4: Create GitHub Project Board

**Important:** The easiest way to create a Project board is through the GitHub.com web interface.

### Steps to Create Project

1. **Go to your repository on GitHub.com**
   - Navigate to: `https://github.com/your-username-or-org/your-repo-name`

2. **Access Projects tab**
   - Click on "Projects" in the repository menu
   - Click "Add project" → "New project"

3. **Create new project**
   - Choose: **"Start from scratch: Board"** (recommended)
   - Name: Use a descriptive name like "[Project Name] Task Board" or "[Project Name] Workflow"
   - Description: Brief description of project purpose

4. **Set up columns**
   
   Recommended column structure:
   - **Todo**: New issues and upcoming tasks
   - **In Progress**: Currently being worked on
   - **Blocked**: Tasks waiting on external dependencies
   - **Done**: Completed tasks

   To create columns:
   - The default board comes with "Todo", "In Progress", and "Done"
   - Click "+ Add column" to add "Blocked"
   - Drag columns to reorder as needed

5. **Link Project to Repository**
   - In project settings (gear icon), go to "Settings"
   - Under "Linked repositories", add your repository
   - This enables automation features

### Configure Automation

Once your project is linked to your repository:

1. **Automatic issue addition**
   - New issues automatically appear in "Todo" column
   - Can configure in Project settings → Workflows

2. **Automatic status updates**
   - When you close an issue, it automatically moves to "Done"
   - When you reopen an issue, it moves back to "Todo"
   - You can manually drag issues between columns

3. **Set up workflows** (optional but recommended)
   - Click "⋯" (three dots) in project menu → "Workflows"
   - Enable "Auto-add to project" for new issues
   - Enable "Auto-archive" for closed items after 7 days

### Project Naming Best Practices

- ✅ **Good names:**
  - "[Project Name] Research Workflow"
  - "[Project Name] Task Tracking Q1 2024"
  - "[Project Name] Analysis Pipeline"

- ❌ **Avoid:**
  - Generic names like "Project 1" or "Tasks"
  - Names without context ("Pipeline")
  - Overly long names

### Adding Issues to Project

If issues were created before the project:

**Option 1: Bulk add via Project interface**
1. Go to your Project board
2. Click "+ Add item"
3. Search for issues by number or title
4. Click to add each one

**Option 2: Add from issue page**
1. Open any issue
2. On right sidebar, find "Projects"
3. Select your project from dropdown
4. Issue appears in "Todo" column

**Option 3: Use GitHub CLI**
\`\`\`bash
# Get your project ID
gh project list

# Add issue to project (requires project ID)
gh project item-add [PROJECT_ID] --owner [USERNAME] --url https://github.com/[USERNAME]/[REPO]/issues/[NUMBER]
\`\`\`

## Step 5: Workflow Tips

### Working with Issues

\`\`\`bash
# List all open issues
gh issue list

# View specific issue
gh issue view 1

# Close an issue (moves to Done automatically)
gh issue close 1 --comment "Completed all tasks"

# Reopen an issue
gh issue reopen 1

# Add a comment
gh issue comment 1 --body "Update on progress..."

# Assign issue to yourself
gh issue edit 1 --add-assignee @me
\`\`\`

### Best Practices

1. **One task per issue**: Keep issues focused and actionable
2. **Use checklists**: Break complex tasks into sub-tasks using `- [ ]` syntax
3. **Link related issues**: Reference other issues with `#number` (e.g., "Depends on #5")
4. **Label consistently**: Use labels to filter and organize
5. **Update regularly**: Comment on progress, move cards on project board
6. **Close when done**: Don't let completed issues linger open
7. **Document blockers**: If stuck, comment on what you're waiting for

### Updating Project Board

- **Move cards manually**: Drag issues between columns as status changes
- **Automatic movement**: Issues auto-move to "Done" when closed via any method:
  - Using `gh issue close`
  - Clicking "Close issue" on GitHub.com
  - Via commit message: `git commit -m "Fix analysis bug (closes #3)"`

## Troubleshooting

### GitHub CLI Authentication Issues

\`\`\`bash
# Check authentication status
gh auth status

# Re-authenticate if needed
gh auth logout
gh auth login
\`\`\`

### Issues Not Appearing in Project

- Verify project is linked to repository
- Check project settings → Workflows → Enable "Auto-add to project"
- Manually add existing issues from Project board

### Permission Errors

- Ensure you have write access to the repository
- For organization repos, check that Projects are enabled

## Summary Workflow

\`\`\`bash
# One-time setup
ml github-cli                          # Load module (HiPerGator)
gh auth login                          # Authenticate (first time only)

# Per-project workflow
bash make-dirs.sh                      # Create directory structure
git init                               # Initialize local repo
gh repo create my-project --public --source=. --remote=origin  # Create remote
git add .                              # Stage files
git commit -m "Initial commit"         # Commit
git push -u origin main                # Push to GitHub
bash make-issues.sh                    # Create issues
# Then go to GitHub.com to create Project board and link it
\`\`\`

## Additional Resources

- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [UF AI Resources](https://it.ufl.edu/ai)
- [GitHub Issues Guide](https://guides.github.com/features/issues/)
\`\`\`

