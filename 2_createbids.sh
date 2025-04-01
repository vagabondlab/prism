# create the bids --- 14 august 2024 --- MARIO MURAKAMI

source /autofs/cluster/vagabond/USERS/MARIO/Packages/env/heudiconv/bin/activate

echo " Created by Mario Murakami (August 2024)"
echo " STEP 2 - Converting DICOMs to NIFIT files and in BIDS structure"
echo " Date:\t `date`"

# path to the text file containing subject IDs
SUBJ_LIST="SubjectList.txt"

# loop through each line in the text file
while IFS= read -r subj_id; do
    # execute the heudiconv command with the current subject ID
    heudiconv --files /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/rawdata/${subj_id}/MR/*.dcm \
              -o /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/sourcedata \
              -f /autofs/cluster/vagabond/USERS/MARIO/Projects/7T/codes/utility/heuristic.py \
              -s ${subj_id} -ss 01 -c dcm2niix -b --minmeta --overwrite
done < "$SUBJ_LIST"

