input_dir="/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata"
subject_list="/autofs/cluster/vagabond/USERS/MARIO/Projects/7T/codes/SubjectListfmriprep.txt"


while read -r subject_path; do

    anat_dir="$input_dir/$subject_path/ses-01/anat"
    t1_file=$(find "$anat_dir" -maxdepth 1 -type f -name "*_T1w.nii.gz")
    
    if [ -n "$t1_file" ]; then
        echo "Processing file: $t1_file"
        
        output_file="${t1_file%.nii.gz}_corrected.nii.gz"

	rm $t1_file
	mv $output_file $t1_file
        
    fi
done < "$subject_list"
