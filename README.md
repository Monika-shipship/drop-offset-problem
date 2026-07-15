# Drop Offset Problem

This repository contains the paper, figures, and calculation code for a study of the horizontal displacement of a freely dropped sphere on a rotating Earth.

## Authors

- Tianyi Wu, Lanzhou University
- Yuchen He, Beijing Institute of Technology
- Hongyu Luo, Duke Kunshan University ([GitHub](https://github.com/R-Honey114514))

## Summary

The paper studies the displacement between the impact point of a dropped sphere and the point directly below its release position. It compares a rotating-frame treatment with an inertial-frame Keplerian model and examines the dependence of the result on release height and latitude.

The analysis includes:

- the Newton-Coriolis equation in a rotating reference frame;
- an approximate analytic solution for heights much smaller than the Earth's radius;
- an inertial-frame formulation based on a short segment of an elliptic orbit;
- MATLAB and Mathematica calculations for parameter scans and figures.

## Selected results

- The approximate and Keplerian models agree to within 0.5% for release heights up to 100 km.
- The eastward and southward components are equal at approximately 3.0 km for 20 degrees N, 15.0 km for 50 degrees N, and 24.5 km for 80 degrees N.
- For the heights considered above approximately 25 km, the eastward component is dominant.

## Repository layout

| Path | Description |
| --- | --- |
| `dropoffsetproblem.tex` | Main LaTeX source and derivations |
| `Drop Offset Problem.pdf` | PDF version of the paper |
| `image/` | Figures used in the paper |
| `code/matlab/` | MATLAB scripts for calculations and plots |
| `code/mathematica/` | Mathematica notebooks for symbolic and exploratory calculations |
| `code/diagrams/` | Source files for the coordinate-system diagrams |
| `reference.bib` | Bibliography database |
| `elegantpaper.cls` | LaTeX document class used by the paper |
| `archive/legacy_elegantpaper/` | Older template files retained for reference |

## Build

With a TeX distribution containing `latexmk`, XeLaTeX, and Biber:

```powershell
latexmk -xelatex dropoffsetproblem.tex
```

This command creates the local build output `dropoffsetproblem.pdf`. Intermediate files can be removed with:

```powershell
latexmk -c
```

The PDF committed to the repository is the separately named file `Drop Offset Problem.pdf`.

## Citation

Wu, T., He, Y., & Luo, H. (2025). *How far does a dropped sphere land from the point directly beneath its release position?* https://github.com/Monika-shipship/drop-offset-problem
