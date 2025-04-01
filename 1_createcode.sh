# code to create the python codes -- 14 august 2024 -- MARIO MURAKAMI

source /autofs/cluster/vagabond/USERS/MARIO/Packages/env/heudiconv/bin/activate

echo " Created by Mario Murakami (August 2024)"
echo " STEP 1 - Creating the scripts to be used in the next steps"
echo " Date:\t `date`"

# path to the text file containing subject IDs
SUBJ_LIST="SubjectList.txt"

# loop through each line in the text file
while IFS= read -r subj_id; do
    
#remove PET data downloaded previously in step 0 -- need to improve this, we want to pull just MR data
    cd /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/rawdata/${subj_id}
    rm -r PET
    rm -r MR_PET
    
    # execute the heudiconv command with the current subject ID
    heudiconv --files /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/rawdata/${subj_id}/MR/*.dcm \
              -o /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata \
              -f convertall -s ${subj_id} -ss 01 -c none
done < "$SUBJ_LIST"
