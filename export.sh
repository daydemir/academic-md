#!/bin/zsh
# Usage: ./export <input.md>
# Converts Markdown to LaTeX, then to PDF, HTML, and EPUB.
# Output files are placed in a directory named after the input file (without extension).
#
# Example: ./export myfile.md
#   -> myfile/myfile.pdf, myfile/myfile.html, myfile/myfile.epub
#
# Requires: pandoc, pdflatex
# Optional: templates/overleaf-generic-template.tex (LaTeX template)


set -e

if [ $# -lt 1 ]; then
  echo "Usage: $0 <input.md> [--csl=CSLFILE]"
  exit 1
fi

MD_FILE="$1"
BASENAME="${MD_FILE%.md}"
OUTDIR="$BASENAME"
TEMPLATE="templates/overleaf-generic-template.tex"
CSL_ARG=""
TEMPLATE_ARG=""
EXTRA_ARGS=()

# Parse extra arguments (e.g., --csl, --template)
for arg in "$@"; do
  if [[ "$arg" == --csl=* ]]; then
    CSL_FILE="${arg#--csl=}"
    CSL_ARG="--csl=$CSL_FILE"
  elif [[ "$arg" == --template=* ]]; then
    TEMPLATE_FILE="${arg#--template=}"
    TEMPLATE_ARG="--template=$TEMPLATE_FILE"
    TEMPLATE="$TEMPLATE_FILE"
  elif [[ "$arg" != "$MD_FILE" ]]; then
    EXTRA_ARGS+=("$arg")
  fi
done

TEX_FILE="$OUTDIR/$(basename "$BASENAME").tex"
PDF_FILE="$OUTDIR/$(basename "$BASENAME").pdf"
HTML_FILE="$OUTDIR/$(basename "$BASENAME").html"
EPUB_FILE="$OUTDIR/$(basename "$BASENAME").epub"

# Create output directory if it doesn't exist
mkdir -p "$OUTDIR"

# Convert Markdown to LaTeX using Pandoc and Overleaf-style template
pandoc -s "$MD_FILE" -o "$TEX_FILE" --citeproc $CSL_ARG $TEMPLATE_ARG "${EXTRA_ARGS[@]}"

# Compile LaTeX to PDF (output in OUTDIR)
(cd "$OUTDIR" && pdflatex -interaction=nonstopmode "$(basename "$TEX_FILE")")

# Convert LaTeX to HTML (using Pandoc, with MathJax for math rendering)
pandoc -s "$MD_FILE" -o "$HTML_FILE" --mathjax --citeproc $CSL_ARG "${EXTRA_ARGS[@]}"

# Convert Markdown directly to EPUB (using Pandoc, with MathML for math rendering)
pandoc -s "$MD_FILE" -o "$EPUB_FILE" --mathml --citeproc $CSL_ARG "${EXTRA_ARGS[@]}"

echo "Conversion complete:"
echo "  LaTeX: $TEX_FILE"
echo "  PDF:   $PDF_FILE"
echo "  HTML:  $HTML_FILE"
echo "  EPUB:  $EPUB_FILE"
