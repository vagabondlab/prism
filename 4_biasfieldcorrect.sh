#!/bin/bash

# Define the input and script paths
input_dir="/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata"
biasfield_script="/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/codes/utility/biasfieldcorrect"
subject_list="/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/codes/SubjectListfmriprep.txt"

# Read the subject list file and process each entry
while read -r subject_path; do
    # Construct the full path to the subject's anat directory
    anat_dir="$input_dir/$subject_path/ses-01/anat"
    
    # Check for the presence of T1w.nii.gz file
    t1_file=$(find "$anat_dir" -maxdepth 1 -type f -name "*_T1w.nii.gz")
    
    if [ -n "$t1_file" ]; then
        echo "Processing file: $t1_file"
        
        # Define the output file with a new name
        output_file="${t1_file%.nii.gz}_corrected.nii.gz"
        
        # Call the biasfieldcorrect Python script with the new output file
        python3 "$biasfield_script" "$t1_file" "$output_file" --overwrite
        
        # Check the exit status
        if [ $? -eq 0 ]; then
            echo "Successfully processed: $output_file"
        else
            echo "Error processing: $t1_file" >&2
        fi
    else
        echo "No T1w file found in: $anat_dir" >&2
    fi
done < "$subject_list"
