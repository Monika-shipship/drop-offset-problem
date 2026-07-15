# Drop Offset Problem

> A collaborative theoretical-mechanics research project on the horizontal deflection of a freely dropped sphere on a rotating Earth.

**Manuscript:** *How far does a dropped sphere land from the point directly beneath its release position?*

**Status:** Research manuscript and reproducible computational archive (2025)

[Read the manuscript (PDF)](./Drop%20Offset%20Problem.pdf)

## Contributors

- **Hongyu Luo** - [GitHub profile: `@R-Honey114514`](https://github.com/R-Honey114514)
- **Additional co-author** - collaborator without a public GitHub profile

## Research overview

The project asks how far a sphere released from rest lands from the point directly below its release position. The model retains both Coriolis and centrifugal effects and studies how the horizontal offset depends on release height and latitude.

The work combines two complementary descriptions:

- a rotating-frame treatment based on the full Newton--Coriolis equation;
- an approximate analytic solution for laboratory-scale heights;
- an inertial-frame Keplerian formulation that models the trajectory as a short segment of an elliptic orbit;
- numerical parameter sweeps and visualizations for height and latitude dependence.

## Research contributions

The manuscript and computational archive document the following results:

- The approximate and Keplerian models agree to within 0.5% for release heights up to 100 km.
- The eastward and southward components cross at a latitude-dependent height: approximately 3.0 km at 20 degrees N, 15.0 km at 50 degrees N, and 24.5 km at 80 degrees N.
- Above approximately 25 km, the eastward component is dominant for the latitudes studied.
- The figures, parameter scans, derivations, and source files are kept together so that the analysis can be rebuilt and extended.

## Research experience demonstrated

This project is suitable for citing as a collaborative research experience in theoretical and computational physics. It demonstrates experience with:

- analytical mechanics and non-inertial reference frames;
- order-of-magnitude analysis, asymptotic approximations, and model comparison;
- exact-versus-approximate validation using quantitative error checks;
- numerical root finding, parameter sweeps, and scientific visualization;
- reproducible technical writing with LaTeX, MATLAB, and Mathematica.

### CV-ready description

Adapt the wording to the contributor's actual role:

> **Drop Offset Problem - Collaborative Research Project (2025).** Investigated Coriolis and centrifugal deflection in free fall on a rotating Earth; derived and compared approximate rotating-frame and exact Keplerian models, validated their agreement over a range of heights, and developed reproducible MATLAB/Mathematica/LaTeX materials for the analysis.

## Project materials

| Path | Contents |
| --- | --- |
| `dropoffsetproblem.tex` | Main manuscript source and derivations |
| `Drop Offset Problem.pdf` | Snapshot of the manuscript |
| `image/` | Figures used by the manuscript |
| `code/matlab/` | Parameter scans, root finding, and plotting scripts |
| `code/mathematica/` | Exploratory and symbolic calculation notebooks |
| `code/diagrams/` | Source files for coordinate-system diagrams |
| `reference.bib` | Bibliography database |
| `elegantpaper.cls` | LaTeX document class required by the manuscript |
| `archive/legacy_elegantpaper/` | Superseded template files retained for recovery |

Generated plots should be reviewed and copied to `image/` only when they are used by the paper. This keeps duplicate or exploratory output beside the calculation scripts from accumulating.

## Build

With a TeX distribution containing `latexmk`, XeLaTeX, and Biber:

```powershell
latexmk -xelatex dropoffsetproblem.tex
```

The command produces `dropoffsetproblem.pdf` as a local build artifact. Remove intermediate files with:

```powershell
latexmk -c
```

## Authorship and citation

The manuscript source currently contains placeholder author and affiliation fields. Replace those fields with the final contributor information before using the PDF as a formal bibliographic record. Unless the work has been submitted or published elsewhere, describe it as a research project or manuscript rather than as a journal publication.
