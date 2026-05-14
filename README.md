# UFHCC BCB-SR Bioinformatics Hub

A collaborative documentation site for the UF Health Cancer Institute Biostatistics and Computational Biology Shared Resource. This is where BCB-SR members document how to navigate bioinformatics — from collaborating with our unit, to using the command line, finding gold-standard tools, and troubleshooting common challenges.

🌐 **Live site:** [ufhcc-bcbsr.github.io/res-hub](https://ufhcc-bcbsr.github.io/res-hub/)

---

## How this site works

Every page on this site is a markdown file (`.md`) stored in the `docs/` folder of this repository. The site is built with [MkDocs](https://www.mkdocs.org) using the [Material theme](https://squidfunk.github.io/mkdocs-material/) and automatically rebuilds and deploys to GitHub Pages every time a change is pushed — including edits made directly on GitHub.com.

---

## Which workflow is right for you?

<details>
<summary>✅ <strong>No terminal needed — Edit everything on GitHub.com</strong></summary>

This workflow requires no command line, no Git, and no local setup. All you need is a GitHub account and collaborator access to this repo.

**You can:**
- Edit any existing page directly on GitHub.com
- Add new pages through the GitHub interface
- Upload images through the GitHub interface
- See your changes live on the site within ~2 minutes of saving

**You cannot (without the terminal):**
- Preview changes before they go live
- Rename or reorganize folders
- Add new MkDocs plugins

> If all you need to do is write and edit documentation, this workflow is all you need.

</details>

<details>
<summary>💻 <strong>Terminal workflow — Full local development</strong></summary>

This workflow lets you preview the site locally before pushing and make structural changes with confidence.

**You will need:**

| Tool | Install |
|------|---------|
| Python 3 | [python.org](https://www.python.org/downloads/) |
| Git | [git-scm.com](https://git-scm.com/) |
| MkDocs + Material | Installed via `requirements.txt` |

**Setup:**

```bash
git clone https://github.com/UFHCC-BCBSR/res-hub.git
cd res-hub
pip3 install -r requirements.txt
mkdocs serve
```

Then open [http://127.0.0.1:8000](http://127.0.0.1:8000) — the site live-reloads as you edit files.

</details>

---

## Editing an existing page

Every page on the site corresponds to a `.md` file in the `docs/` folder. The folder structure mirrors the site navigation.

<details>
<summary>On GitHub.com (no terminal)</summary>

1. Navigate to the file in `docs/` on GitHub.com
2. Click the ✏️ pencil icon to edit
3. Make your changes
4. Add a descriptive commit message and click **Commit changes**

> To have someone review your changes before they go live, select **Create a new branch for this commit and start a pull request** instead.

</details>

<details>
<summary>Locally (terminal)</summary>

1. Edit the file in your text editor
2. Preview with `mkdocs serve`
3. When happy, commit and push:

```bash
git add .
git commit -m "Describe your change here"
git push
```

</details>

---

## Adding a new page

**Step 1 — Create the file**

<details>
<summary>On GitHub.com (no terminal)</summary>

1. Navigate to the appropriate folder inside `docs/` on GitHub.com
2. Click **Add file → Create new file**
3. Name your file, e.g. `my-new-page.md`
4. Add your content (see template below) and click **Commit changes**

</details>

<details>
<summary>Locally (terminal)</summary>

```bash
touch docs/your-section/my-new-page.md
```

</details>

**Step 2 — Add it to the navigation**

Open `mkdocs.yml` and add your page under the appropriate section in the `nav:` block:

```yaml
nav:
  - My Section:
    - My New Page: your-section/my-new-page.md  # ← add this
```

**Page template**

New pages don't require any special header — just start writing in markdown:

```markdown
# Page Title

A brief description of what this page covers.

## Section One

Content here.

## Section Two

More content here.
```

---

## Adding a new section

1. Create a new folder inside `docs/`, e.g. `docs/my-new-section/`
2. Add at least one `.md` file to it
3. Add the section and its pages to `mkdocs.yml`:

```yaml
nav:
  - My New Section:
    - First Page: my-new-section/first-page.md
```

---

## Repo structure

```
res-hub/
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actions — do not edit
├── docs/
│   ├── assets/
│   │   ├── images/           # Store images here
│   │   └── css/
│   │       └── custom.css
│   ├── index.md              # Home page
│   ├── collaborating/
│   ├── hipergator/
│   ├── git-github/
│   ├── command-line/
│   ├── r-python/
│   ├── workflow-managers/
│   ├── experimental-design/
│   ├── analysis-pipelines/
│   ├── downstream-analysis/
│   ├── data-sharing/
│   ├── grant-writing/
│   ├── publishing/
│   └── blog/
├── mkdocs.yml                # Site configuration and navigation
└── requirements.txt          # Python dependencies
```

---

## Requesting changes

Not a repo collaborator but want to suggest a change? [Open an issue](https://github.com/UFHCC-BCBSR/res-hub/issues) and describe what you'd like documented.

---

## License

All content is licensed [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/).
