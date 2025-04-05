#!/bin/bash

in_cnt=0
out_cnt=0
warning=0

for file in *; do
    if [ -d "$file" ] && ([ "$file" == "input" ] || [ "$file" == "output" ]); then
        echo "There is already a directory named input or output, program aborted..."
        exit 1
    elif [ -f "$file" ] && [ "$file" == "tasks.json" ]; then
        echo "There is already a file named tasks.json, program aborted..."
        exit 1
    fi
done

mkdir input output

for file in *; do
    extension="${file##*.}"
    file_name="${file%.*}"
    file_name="${file_name##0}"

    if [ ! -f "$file" ] || ([ "$extension" != "a" ] && [ "$extension" != "$file" ]) || [[ "$file_name" =~ [^0-9] ]]; then
        continue
    fi

    file_num=$((file_name-1))
    
    if [ "$extension" == "$file" ]; then
        if [ "$file_num" -ne "$in_cnt" ]; then
            warning=1
        fi
        [ "$1" == "-p" ] && cp "$file" "input/input${file_num}.txt" || mv "$file" "output/output${file_num}.txt" 
        in_cnt=$((in_cnt+1))
    elif [ "$extension" == "a" ]; then
        if [ "$file_num" -ne "$out_cnt" ]; then
            warning=1
        fi
        [ "$1" == "-p" ] && cp "$file" "output/output${file_num}.txt" || mv "$file" "output/output${file_num}.txt" 
        out_cnt=$((out_cnt+1))
    fi
done

if [ "$warning" -eq 1 ] || [ "$in_cnt" -eq 0 ]; then
    echo "Warning: some testcase maybe be incomplete or missing, please recheck your files"
    echo "tasks.json is not created for now"
else
echo "{
    \"ninput\": $in_cnt,
    \"name\": \"problem_name\",
    \"timelimit\": $time_limit,
    \"memorylimit\": $memory_limit,
    \"mode\": \"simple\",
    \"maxscore\": 100,
    \"subtasks\": [
        {
            \"input\": $in_cnt,
            \"maxscore\": 100,
            \"group\": true
        }
    ]
}" > tasks.json
    echo "Created tasks.json with 1 subtasks, 1000 ms and 64 MB limit"
fi

echo "Process completed"
