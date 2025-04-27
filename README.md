# academic.md

This project provides a streamlined workflow for writing academic papers in Markdown and exporting them to PDF, HTML, and EPUB formats with proper citations and math support.

## Dependencies

You will need the following installed on your computer:

- **Pandoc** (https://pandoc.org/)
- **LaTeX**: Recommended via [MacTeX](https://tug.org/mactex/) (for PDF export)
- **Zsh** (default on modern macOS)
- **Better BibTeX for Zotero** (optional, for bibliography automation)

> **Note:** This workflow has only been tested on macOS. It should work on Linux with minor adjustments, but Windows is untested.

## Features
- **Single-command export:** Use `export.sh` to convert your Markdown file into LaTeX/PDF, HTML, and EPUB.
- **Citation support:** Uses Pandoc with CSL (e.g., Nature style) for numbered, superscripted references.
- **Math support:** LaTeX math (inline `$...$` or display `$$...$$`) is rendered in all formats (PDF via LaTeX, HTML via MathJax, EPUB via MathML).
- **Flexible writing:** Write in any Markdown editor, including VS Code and Obsidian.

> **Warning:** If you need advanced LaTeX math or diagram features (such as TikZ, or other custom packages/macros), you will need to write those sections directly in `.tex` files and adapt this workflow. Markdown-based workflows and HTML/Markdown previews do **not** support full LaTeX (e.g., TikZ, xymatrix, or custom `.sty` files). For these cases, consider editing `.tex` files directly, or use VS Code's native LaTeX rendering with extensions like LaTeX Workshop for a better experience.



---

## Using the MIT Thesis Template

This project includes a Pandoc/LaTeX template for generating MIT-style thesis documents from Markdown. To use it:

```sh
./export.sh <yourfile.md> --template=templates/mit-thesis/mitthesis-pandoc-template.tex
```

### Required YAML Metadata (Frontmatter)
Below is a sample YAML block you should place at the top of your Markdown file. This metadata will be mapped to the MIT thesis cover page and other required fields:

```yaml
---
title: "A Real Paper"
author: "Deniz Aydemir"
department: "System Design and Management"
degree: "Master of Science in Engineering and Management"
degree_department: "School of Engineering and the Sloan School of Management"
supervisors:
  - name: "Obi-Wan Kenobi"
    title: "Master Jedi"
acceptors:
  - name: "Qui-Gon Jin"
    title: "Master of the Force"
    role: "Graduate Officer, Department of Research"
degree_date_month: "June"
degree_date_year: "2026"
thesis_date: "May 18, 2026"  # Optional, for extra date display
abstract: |
  This is the abstract of the thesis. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
toc: true               # Table of Contents
listoffigures: true     # List of Figures
listoftables: true      # List of Tables
bibliography: references.bib  # Path to your .bib file
---
```

#### Parameter Reference
- `title`, `author`: Strings for the thesis title and author name.
- `department`: Department granting the degree.
- `degree`: The degree being awarded.
- `degree_department`: School(s) awarding the degree.
- `supervisors`: List of supervisors (`name` and `title`).
- `acceptors`: List of thesis acceptors (`name`, `title`, and `role`).
- `degree_date_month`, `degree_date_year`: Graduation date.
- `thesis_date`: (Optional) Date of thesis submission.
- `abstract`: Thesis abstract (use `|` for multiline).
- `toc`, `listoffigures`, `listoftables`: Set to `true` to include those lists.
- `bibliography`: Path to your BibTeX file for citations.

> See `test-paper.md` for a complete example.

---

## How to Use `export.sh`

```sh
./export.sh <yourfile.md> --csl=templates/nature.csl
```

- Outputs will be placed in a folder named after your Markdown file (without extension):
  - `<yourfile>/<yourfile>.pdf`
  - `<yourfile>/<yourfile>.html`
  - `<yourfile>/<yourfile>.epub`

- The `--csl` argument is **optional**. If you do not specify it, Pandoc will use its default citation style (author-year or numeric, depending on your bibliography file and Pandoc version). To use a specific style (like Nature), pass `--csl=templates/nature.csl`.

---

## Why Use This in VS Code (and with AI Assistance)?

- **Markdown-first, LaTeX-quality:** Write your thesis in Markdown for speed and simplicity, but export to a fully compliant MIT thesis PDF.
- **AI-Assisted Writing:** VS Code (with extensions like GitHub Copilot, Codeium, or other AI tools) can help you:
  - Generate and refactor Markdown or YAML frontmatter.
  - Write and correct LaTeX math, tables, or code blocks with AI suggestions.
  - Auto-complete citations and bibliography entries.
  - Quickly reformat, summarize, or expand sections using AI chat.
- **Seamless Export:** No need to manually edit `.tex` files—just update your Markdown and YAML, then export.
- **Great for Collaboration:** Markdown is easy to diff, review, and edit with teammates or advisors.

> **Tip:** If you want to use AI to help write LaTeX directly, you can open `.tex` files in VS Code and use AI tools there as well. This workflow is especially useful for combining Markdown-first writing with LaTeX's power, and for leveraging AI to speed up academic writing.

---

## Formatting Your Markdown File

To ensure correct export:

### 1. **YAML Header**
```markdown
---
title: My Paper Title
author: Your Name
bibliography: references.bib
---
```
- `bibliography` should point to your BibTeX or CSL JSON file (e.g., `references.bib`).
- **Tip:** You can generate and keep your `references.bib` automatically up to date from Zotero using the Better BibTeX plugin. This is a recommended workflow for managing academic references efficiently.

### 2. **Citations**
- Use Pandoc citation syntax: `[@citekey]` for in-text, `[@citekey1; @citekey2]` for multiple.
- Example: `This is a statement [@doe2020].`

### 3. **Math**
- Inline math: `$E = mc^2$`
- Display math: `$$E = mc^2$$`

### 4. **Footnotes**
- Use Pandoc/Markdown footnote syntax:
  ```markdown
  Here is a footnote.[^1]

  [^1]: This is the footnote text.
  ```

### 5. **References Section**
- You do **not** need to manually add a References section; Pandoc will insert it automatically at the end.

---

## Editing Your Markdown
- You can write and edit your `.md` file in any text/code editor, such as **VS Code** or **Obsidian**.
- Obsidian is particularly convenient for academic writing, note-taking, and managing citations.

---

## Dependencies
- **Pandoc** (with citeproc)
- **LaTeX** (for PDF export)

Make sure both are installed and available in your PATH.

---

## Example Command
```sh
./export.sh test-paper.md --csl=templates/nature.csl
```

---

## Troubleshooting
- **Math not rendering in HTML?** Make sure you open the HTML file in a browser with internet access (MathJax loads from CDN).
- **Citations not working?** Check your `.bib` file and citation keys.
- **PDF errors?** Make sure your LaTeX is up to date and your Markdown is valid.

---

For more customization, edit `export.sh` or the CSL file in `templates/`.
