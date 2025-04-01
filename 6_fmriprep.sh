#!/bin/bash


# Recommended command to run this script is: 
# setup to be run on the cluster via the fmriprep.sbatch file, ie
# the command:  sbatch fmriprep.sbatch

#**************  Variables to Set ***********************************************

# Either SUBJECT_LIST should have a path to a file with a list of subjects (one
# per line) OR SUBJECTS should have a list of SUBJECTS (ex: "BLASAM24 BOCLIS10")
# if neither is empty, those in SUBJECT_LIST will be ignored

mapfile -t SUBJECTS < SubjectListfmriprep.txt
subject=${SUBJECTS[$SLURM_ARRAY_TASK_ID]}



echo "**************************************** ${subject} ****************************************"

source ./utility/fmriprep_env.sh

# Set data directory (BIDS_DIR) and output directory (derivatives_DIR)

bidsD=/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata
derD=/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata/derivatives/fmriprep

#freesurfer directory
fsD=/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata/derivatives/freesurfer

#working directory

workD=/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/codes/working-fmriprep

# Set singularity file for frmiprep version to run

fmriprep=/autofs/cluster/vagabond/USERS/MARIO/Projects/msit/codes/working-fmriprep/my_images/fmriprep-23.0.2.simg

# freesurfer license to use (fine keep as is, unless it stops working in future,
# like if a new version of freesurfer comes out and they want a new license file)

fsLicense=/autofs/cluster/vagabond/USERS/MARIO/Projects/msit/codes/license.txt


#*********************************************************************************

# Run fmriprep command. This will run fmriprep mostly with default options.
# fmriprep is pretty good at detecting data types, parameters, etc. and
# acting appropriately, but analysing a new study, you'll want to think
# about if you need to change the default processing.

# create directories
# mkdir -p ${bidsD}/derivatives
#mkdir -p ${workD}
#mkdir -p ${derD}

singularity run --cleanenv \
    -B /autofs -B /usr/pubsw \
    -B /cluster -B /homes -B /space -B /vast -B /run/user \
    -B /autofs/cluster/vagabond/USERS/MARIO/Projects/msit \
    -B /autofs/cluster/vagabond/USERS/MARIO/Projects/msit/codes/working-fmriprep/my_images \
    -B /autofs/cluster/vagabond/USERS/MARIO/Projects/7T \
    -B /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/codes \
    -B /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata \
    -B /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata/derivatives \
    $fmriprep \
    ${bidsD} ${derD} participant \
    --participant-label ${subject} \
    --output-spaces MNI152NLin2009cAsym:res-1 T1w:res-1\
    --fs-subjects-dir ${fsD} \
    --work-dir ${workD} \
    --cifti-output \
    --fs-license-file ${fsLicense} \
    --use-aroma \
    --ignore slicetiming \
    --skip-bids-validation \
    --mem_mb 50000 
