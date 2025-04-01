# prim
DICOM to NIfTI Conversion and fMRIPrep Pipeline (Pipeline for Reproducible Imaging Standardization and Management).

This repository contains a pipeline for converting DICOM files to NIfTI format using Heudiconv and subsequently processing the NIfTI files with fMRIPrep using Singularity.

## Overview

This pipeline consists of two main stages:

1.  **DICOM to NIfTI Conversion (Heudiconv):**
    * Uses Heudiconv (specifically, scripts `sprits1` and `sprits2`) to convert DICOM files into NIfTI format.
    * Heudiconv helps organize and rename the converted NIfTI files based on the specified heuristic.
2.  **fMRIPrep Processing (Singularity):**
    * Employs fMRIPrep (via script `script6`) within a Singularity container to perform preprocessing of the NIfTI files.
    * Singularity ensures a consistent and reproducible environment for fMRIPrep.

## Repository Structure

```
.
├── script1        # Heudiconv script for initial conversion
├── script2        # Heudiconv script for further organization
├── script6        # fMRIPrep execution script using Singularity
└── README.md      # This file
```

## Prerequisites

Before running the pipeline, ensure you have the following installed:

* **Heudiconv:** Install Heudiconv following the instructions on the official documentation.
* **Singularity:** Install Singularity to run the fMRIPrep container.
* **DICOM Files:** Place your DICOM files in the appropriate directory.
* **Heuristic File:** Create a heuristic Python file that defines how to convert and name your DICOM files. This file will be utilized by `sprits1` and `sprits2`.
* **fMRIPrep Singularity Image:** Download the fMRIPrep Singularity image.

## Usage

### 1. DICOM to NIfTI Conversion (Heudiconv)

1.  **Modify Heuristic:** Edit `sprits1` and `sprits2` scripts to point to your DICOM directory and your heuristic file.
2.  **Run scrip1:**
    This script will perform the initial DICOM to NIfTI conversion.
3.  **Run script2:**
    This script will further organize the converted NIfTI files.

### 2. fMRIPrep Processing (Singularity)

1.  **Modify script6:** Edit `script6` to point to the directory containing your converted NIfTI files, your desired output directory, and the location of your fMRIPrep Singularity image.
2.  **Run script6:**

    This script will execute fMRIPrep within the Singularity container to preprocess your NIfTI files.

## Customization

* **Heuristic File:** The behavior of Heudiconv can be customized by modifying the heuristic Python file. Refer to the Heudiconv documentation for details.
* **fMRIPrep Options:** The fMRIPrep processing can be customized by modifying the command-line options in `script6`. Refer to the fMRIPrep documentation for available options.
* **Directory Paths:** Ensure all directory paths in the scripts are correctly set to match your system.

## Notes

* Ensure that you have sufficient disk space for the converted NIfTI files and fMRIPrep output.
* The processing time for fMRIPrep can vary depending on the size of your dataset and the available computing resources.
* For advanced customization of heudiconv, refer to the heudiconv documentation.
* For advanced customization of fmriprep, refer to the fmriprep documentation.
```
