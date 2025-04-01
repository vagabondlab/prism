input_file="SubjectList.txt"
output_file="SubjectListfmriprep.txt"

> "$output_file"

while IFS= read -r line; do
    processed_line="sub-${line//_/}"
    echo "$processed_line" >> "$output_file"
done < "$input_file"

echo "Processed file has been saved as $output_file"
