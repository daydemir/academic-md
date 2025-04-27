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
