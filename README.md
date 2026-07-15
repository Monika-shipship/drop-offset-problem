# Drop Offset Problem

This project studies the horizontal offset of a freely dropped sphere on a rotating Earth, including Coriolis and centrifugal effects.

## Directory layout

- `dropoffsetproblem.tex` — main LaTeX source.
- `dropoffsetproblem.pdf` — latest compiled paper.
- `image/` — final figures referenced by the paper.
- `code/matlab/` — MATLAB calculation and plotting scripts.
- `code/mathematica/` — Mathematica notebooks (`.nb`); these are retained as calculation sources.
- `code/diagrams/` — source files for the coordinate-system diagrams.
- `reference.bib` — bibliography database.
- `elegantpaper.cls` — document class required by the main source.
- `archive/legacy_elegantpaper/` — unrelated or superseded ElegantPaper files kept for recovery.

Generated plots should be reviewed and copied to `image/` only when they are used by the paper. This avoids keeping duplicate PDFs beside the calculation scripts.

## Build

With a TeX distribution containing `latexmk` and Biber:

```powershell
latexmk -xelatex dropoffsetproblem.tex
```

Remove LaTeX intermediate files with:

```powershell
latexmk -c
```
