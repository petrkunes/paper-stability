# Manuscript Analysis Repository

Welcome to the repository containing R code and data analyses for the manuscript:

**Long-term biodiversity–stability relationship in temperate mountain forests**

This repository makes all analytic scripts, relevant data, and supporting documentation publicly available, supporting transparency and reproducibility of the reported results.

## Table of Contents

- [Project Structure]
- [Requirements]
- [Setup Instructions]
- [How to Reproduce Analyses]
- [File Descriptions]
- [Citing This Work]
- [Contact]

## Project Structure

```         
├── Bacon_runs
├── Paper_stability.Rproj
├── R
│   ├── 00_setup.R
│   ├── 01_Load_data.R
│   ├── 01_Main_calculations.R
│   ├── 02_Calculate_ROC.R
│   ├── 02_Calculate_disturbance.R
│   ├── 03_Figure_2_Pollen.R
│   ├── 03_Figure_3_PAR.R
│   ├── 03_Figure_4_Index.R
│   ├── 03_Figure_5_correlation.R
│   ├── 03_Table_1.R
│   ├── 04_Figure_S1.R
│   ├── 04_Figure_S2.R
│   ├── 04_Table_S1.R
│   ├── 04_Table_S2.R
│   ├── 04_Table_S3.R
│   ├── 04_Table_S4.R
│   ├── 04_Table_S5.R
│   ├── 05_Age_depth_bacon.R
│   └── __Init_project__.R
├── README.md
├── data_in
│   ├── CER_CHELSA.xlsx
│   ├── CER_XRF_15-2-1.xlsx
│   ├── CER_XRF_15-2-2.xlsx
│   ├── CER_XRF_GC.xlsx
│   ├── CER_char_corr.xlsx
│   ├── CER_chiro.xlsx
│   ├── CER_chiro_temp.xlsx
│   ├── CER_pollen_corr.xlsx
│   ├── EPD_P_VARS_high3_mod.xlsx
│   ├── _species_dist.csv
│   ├── _taxa_hierarchy.xlsx
│   ├── _taxa_species.xlsx
│   ├── _taxa_synonym.xlsx
│   └── taxa.xlsx
└── data_out
    ├── CER_ROC.rds
    ├── CER_data.RData
    └── CER_disturbance.rds
```

## Requirements

- **R** version ≥ 4.x

- [Optional: RStudio](https://posit.co/products/open-source/rstudio/)

- Required R packages (see `R/__Init_project__.R`):

## Setup Instructions

1.  **Clone this repository** to your local machine:

    ``` bash
    git clone https://github.com/petrkunes/paper-stability.git cd your-repo-name
    ```

2.  **Install R dependencies:**

    Open R or RStudio and run:

    ``` r
    source("R/__Init_project__.R")
    ```

## How to Reproduce Analyses

All main and supplementary analyses are scripted and reproducible.

1.  **Data Preparation:**

    - Load required packages `R/00_setup.R`.
    - Import and process data by running `R/01_Load_data.R`.

2.  **Data Analyses:**

- Execute main analyses with `R/01_Main_calculations.R`.

- (Optional): re-run time consuming Rate of change analysis `R/02_Calculate_ROC.R`.

- (Optional): re-run time consuming pollen-based disturbance analysis `R/02_Calculate_disturbance.R`.

2.  **Figure/Table Generation:**

    - Generate publication-ready figures and tables via

      - `R/03_Figure_2_Pollen.R`

      - `R/03_Figure_3_PAR.R`

      - `R/03_Figure_4_Index.R`

      - `R/03_Figure_5_correlation.R`

      - `R/03_Table_1.R`

    - Generate publication ready supplementary material via

      - `R/04_Figure_S1.R`

      - `R/04_Figure_S2.R`

      - `R/04_Table_S1.R`

      - `R/04_Table_S2.R`

      - `R/04_Table_S3.R`

      - `R/04_Table_S4.R`

      - `R/04_Table_S5.R`

##  {data-link="File Descriptions"}

##  {data-link="File Descriptions"}

## File Descriptions

| Folder/File | Description |
|------------------|------------------------------------------------------|
| `data_in/` | Contains all raw input data |
| `data_in/_species_dist.csv` | List of plant species with their disturbance frequency index and frequency of distribution in the vegetation |
| `data_in/_taxa_hierarchy.xlsx` | Pollen taxa hierarchical table |
| `data_in/_taxa_species.xlsx` | Plant species and pollen taxa harmonization table |
| `data_in/_taxa_synonym.xlsx` | Pollen taxa synonym table |
| `data_in/CER_char_corr.xlsx` | Sedimentary macroscopic charcoal data from Černé jezero |
| `data_in/CER_CHELSA.xlsx` | CHELSA paleoclimate model for the region of Černé jezero |
| `data_in/CER_pollen_corr.xlsx` | Sedimentary pollen data from Černé jezero |
| `data_in/CER_XRF_15-2-1.xlsx` | Sedimentary XRF data from Černé jezero from separate core drives |
| `data_in/CER_XRF_15-2-2.xlsx` | Sedimentary XRF data from Černé jezero from separate core drives |
| `data_in/CER_XRF_GC.xlsx` | Sedimentary XRF data from Černé jezero from separate core drives |
| `data_in/EPD_P_VARS_high3_mod.xlsx` | EPD synonym and hierarchy table, compiled based on the taxonomy of the EPD-2015 version, with additions made for this study. |
| `data_in/taxa.xlsx` | List of pollen taxa used for creating the pollen diagram |
| `R/__Init_project__.R` | Installs required R packages (run only once) |
| `R/00_setup.R` | Loads required R packages |
| `R/01_Load_data.R` | Data import and cleaning steps |
| `R/01_Main_calculations.R` | Main numerical analyses |
| `R/02_Calculate_disturbance.R` | Re-calculate pollen-based disturbance (optional) |
| `R/02_Calculate_ROC.R` | Re-calculate rate of change (optional) |
| `R/03_Figure_2_Pollen.R` | Code to generate figures and tables |
| ... |  |
| `data_out/` | Analysis outputs (processed data/figures/tables) |
| `Bacon_runs/` | Data folder for Bacon age-depth model |
| `Paper_stability.Rproj` | RStudio project file |
| `README.md` | This README |

## Citing This Work

If you use this code or data, please cite the manuscript:

> [Manuscript Citation Here]

## Contact

For questions or suggestions, please contact:

petr.kunes\@natur.cuni.cz

*This repository supports reproducible research and adheres to best practices for open science.*
