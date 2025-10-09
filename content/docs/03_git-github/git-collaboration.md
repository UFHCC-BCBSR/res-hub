---
title: "Collaborating Using Git & GitHub"
linkTitle: "Git - Collaboration"
summary: " "
---

Portions adapted from the Weecology Wiki by Weecology, used under CC BY 4.0.

## Intro
This guide provides a simple, consistent way for UFHCC BCB-SR bioinformaticians to collaborate on code and analysis projects using Git and GitHub.  

Even if you’re working alone, Git and GitHub are valuable. Git helps you keep a full history of your changes (so you can always go back if something breaks), while GitHub makes your code easy to share with colleagues or collaborators—whether that means fully collaborating on the same project or just saying *“here’s what I did.”*  

If you’re new to Git, don’t worry—it’s less complicated than it looks. Think of GitHub as the "source of truth" where your code lives, and Git as the tool that lets you make safe changes, track history, and share updates. Most of the time, you’ll only use a handful of commands, and the workflow is the same whether you’re on your laptop or working on HiPerGator.  

Whether you’re starting fresh or uploading existing code, the steps below will get you set up quickly. Once you’re using GitHub, you’ll gain version control, reproducibility, and the ability to share your work in a professional, reliable way.  

---

## FAQs / Why use Git and GitHub?

**Q: What’s the difference between Git and GitHub?**  
- *Git* is the tool that runs locally on your computer. It tracks changes to your files, lets you roll back mistakes, and creates a history of your work.  
- *GitHub* is a website where those Git-tracked projects can be stored and shared. Think of GitHub as the central “source of truth” that multiple people (or multiple computers) can connect to.  

**Q: Why use Git if I’m not collaborating?**  
- Version control: always know what changed, when, and why.  
- Backup: your work is safe on GitHub, even if your laptop fails.  
- Reproducibility: you (or anyone else) can re-run your exact workflow later.  
- Sharing: even if you’re not working with others, you can easily show someone your code, or make it available for a paper or report.  

**Q: Why use GitHub if I already have my code on HiPerGator or Dropbox?**  
- GitHub adds structure and history that plain file storage does not.  
- Everyone sees the same version (“the source of truth”), instead of trading files like `analysis_final_v2_reallyfinal.R`.  
- GitHub integrates directly with tools for code review, collaboration, and even automated testing.  

**Q: What if I make a mistake?**  
- Git keeps the entire history, so you can roll back to a safe state. Mistakes are expected—it’s part of the workflow!  

**Q: Is this complicated?**  
- Not really. Most people only use a small set of Git commands: `clone`, `pull`, `add`, `commit`, `push`. Once you’ve run them a few times, it becomes routine.  

---

## Setup
### 1. Create a GitHub account
- Go to [GitHub.com](https://github.com) and sign up.  
- Use your UF or professional email if possible—it makes collaboration easier.  

### 2. Install Git locally
- Git is usually pre-installed on Linux (including Hipergator) and macOS.  
- On Windows, you need to install it from [git-scm.com](https://git-scm.com).  
- You can check by running:  
  \`\`\`bash
  git --version
  \`\`\`

### 3. Connect Git with GitHub (optional)
Run these commands once (replace with your name/email):
\`\`\`bash
git config --global user.name "Your Name"
git config --global user.email "youremail@ufl.edu"
\`\`\`
This ensures commits are linked to you on GitHub.

### 4. Get access to the repository
- If you’re starting a **new project**, create a repository on GitHub (choose a clear name, add a short description, and decide if it should be public or private).  
- If you’re contributing to an **existing project**, ask to be added as a collaborator.  

---

### If you are starting a new project
1. Create a repository on GitHub.  
   - Include a README.md so the project has a landing page.  (You can do this on Github.com or later in your local directory)
   - Consider adding a .gitignore to exclude files you don’t want tracked (e.g., large files, unpublished data, log files, temporary outputs). (You can do this on Github.com or later in your local directory)
     
2. Clone it to your local environment:  
   \`\`\`bash
   git clone https://github.com/YourOrg/your-repo.git
   \`\`\`
   You can clone it to your laptop, HiPerGator, or both. Just remember: GitHub (the remote repo) is the "source of truth."  

---

### If you already have a project you want to put on GitHub
1. Create a new repository on GitHub.  
2. From your local code directory:  
   \`\`\`bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YourOrg/your-repo.git
   git push -u origin main
   \`\`\`
3. Your code is now on GitHub and ready for collaboration or linking to in a Data and Code Availability Statement.

### Work on your code

Once your repository is set up, the basic workflow for making changes looks like this:

1. Edit your files (R scripts, notebooks, code, etc.) locally.
2. Stage the changes so Git knows what to include:
   git add .
   (the "." means “add everything that changed in this folder” — you can also specify a file name instead.)
3. Commit the changes with a message describing what you did:
   git commit -m "short but descriptive message"
4. Push the changes to GitHub so they are shared with others (and backed up):
   git push

That’s it — edit → add → commit → push. This is the cycle you’ll use most often when working with Git.

## Branching

One way of thinking about git branches is that each branch represents a "lineage" of commits in a repo. By default, git repos have a `master` branch, and adding commits to a new repo will create iterative versions of the project, all considered to be part of the `master` branch.

You can see the branches in your project using `git branch` from the command line while in the folder with a git repo. This will list the branches in the repo:
```bash
~/projects/portalr > git branch
```
```
  biomass-function
  hao-data-vignette
* master
```

Here, `master` is marked with an asterisk (and possibly a different color) to indicate that it is the "active" branch. What this means is that new commits added to the repo will be derived from the end of the master branch and included as part of that branch.

### Making New Branches

We can create new branches by specifying a new branch name when using the `git branch` command. This allows us to start a new "lineage" of commits from the current state of the repo.
```bash
~/projects/portalr > git branch hao-test-branch
```
When we look at the branches, we now see:
```bash
~/projects/portalr > git branch
```
```
  biomass-function
  hao-data-vignette
  hao-test-branch
* master
```

Notice that the active branch is still "master".

### Switching Branches

To change the active branch, we use the `git checkout` command:
```bash
~/projects/portalr > git checkout hao-test-branch
```
```
Switched to branch 'hao-test-branch'
```

This is what it looks like when we run `git branch` afterword:
```bash
~/projects/portalr > git branch
```
```
  biomass-function
  hao-data-vignette
* hao-test-branch
  master
```

### Pushing to GitHub

After we have created a branch on our local clone of the repo, and made some commits, we might want to push those commits to GitHub. The first time we do so, however, we encounter an error:
```bash
~/projects/portalr > git push
```
```
fatal: The current branch hao-test-branch has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin hao-test-branch
```

The reason for this error is that the repo on GitHub does not have the branch `hao-test-branch`, and commits have to be assigned to a branch. The suggested command does several things at once:
1. create a branch called `hao-test-branch` on the GitHub repo (which has the remote name `origin`)
2. establish a link between the local branch called `hao-test-branch` and the GitHub branch called `hao-test-branch`
3. push the local commits on `hao-test-branch` to GitHub.

### Pulling from GitHub

Suppose someone starts making an update and has pushed it to GitHub and wants your help before merging it into the master branch. How do you download that new branch?

First, make sure we get all the information from the GitHub repo. This assumes that the GitHub repo is named as the "origin" remote (which is the default).
```bash
~/projects/portalr > git fetch origin
```

We can then view the possible branches using
```bash
~/projects/portalr > git branch -r
```
```
  origin/biomass-function
  origin/fix-test
  origin/hao-data-vignette
  origin/hao-export-obs-func
  origin/hao-loadData-update
  origin/hao-reorder-args-remove-incomplete-censuses
  origin/master
  origin/namespace_issue
  origin/namespaceissues
  origin/standardize_column_names
```

We want to create a local branch to mirror the "fix-test" branch:
```bash
~/projects/portalr > git checkout -b fix-test origin/fix-test
```
```
Branch fix-test set up to track remote branch fix-test from origin.
Switched to a new branch 'fix-test'
```

This has done several things: it retrieved the branch from GitHub to our local machine, set up tracking, and changed the current active branch. Now, if we make new commits to the local copy of the branch, we are able to push directly to that corresponding branch on GitHub.

## Pull Requests

The preference is to use GitHub to merge the updates on a new branch back into `master`. We can do this by going to the "Pull requests" tab on the GitHub repo page and creating a "New pull request".
![](/docs/computers-and-programming/github_PR_tab.png)

Suppose we want to merge from `hao-test-branch` into `master`. Then we select `master` as the "base: " branch, and `hao-test-branch` as the "compare: " branch. We can then write some comments for our new pull request before clicking on "Create new pull request".

*If the pull request fixes an issue, you can include keywords to [automagically close](https://help.github.com/articles/closing-issues-using-keywords/) the issue when the pull request is merged.*

### Updating Pull Requests

At this point, other people can comment on the pull request itself in GitHub, if discussion regarding the changes needs to occur.

Additionally, assuming that the pull request has not yet been merged, further commits *to that branch on GitHub* are automatically included with the pull request. Thus, if you later find a bug, you can make further changes and not have to submit a new pull request.

### Merging Pull Requests

In general, check with one of the repo maintainers about merging pull requests. This ensures that the `master` branch doesn't break (too often) and that everyone is informed about changes.

## Summary Example

Objective: I want to fix issue #1 in the https://github.com/weecology/portalr repo.
1. Download the repo from GitHub and onto my local machine. [`git clone`]
2. In my local machine, create a new branch (e.g. `hao-add-biomass-function` <- prefacing the branch name with your name helps prevent branch name collisions. [`git branch`]
3. Switch to the new branch. [`git checkout`]
4. Make the updates on my local machine. [`git commit`]
5. Push the updates to GitHub. [`git push`]
6. Create the pull request on GitHub. [GitHub web interface]
7. Merge the pull request on GitHub. [GitHub web interface]
8. On my local machine, switch back to the master branch. [`git branch`]
9. Get the updates to the master branch [`git pull`]
(optionally) Delete the branch on GitHub. [GitHub web interface, "Code" tab, "## branches"]
(optionally) Delete the branch on my local machine. [`git branch -d hao-add-biomass-function`]
