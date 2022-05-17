#!/bin/bash

base_input="test_case$1.txt"
area_config="test_case$1_area.txt"
baseline="test_case$1_baseline.txt"
hls=$2
checker=$3
score_calc=$4

declare -i cnt_cases=0
declare -i total_score=10

while read -r limit; do
    cnt_cases=$((cnt_cases+1))
done < $area_config

echo $cnt_cases

score_arr=()

if [ -f tmp_score$1.txt ]; then
    rm tmp_score$1.txt
fi

while read -r limit; do
    awk 'NR==1 {$4 = '"$limit"'; print $0} NR>1 {print $0}\' $base_input > tmp_in.txt
    
    timeout 60s $hls tmp_in.txt > result.txt 2> /dev/null
    if [ $? -eq 124 ]; then
	echo "Time Limited Exceeded" >&2
	echo -1 >> tmp_score$1.txt
	continue
    fi
    
    $checker tmp_in.txt result.txt > score.txt 2> /dev/null
    if [ $? -ne 0 ]; then
	echo "Checker Exits Unexpectedly. Please Report."
	echo -1 >> tmp_score$1.txt
	continue
    fi

    read -r score < score.txt
    echo "Area: $limit; Latency: $score"
    echo $score >> tmp_score$1.txt
done < $area_config

$score_calc tmp_score$1.txt $baseline
rm score.txt
rm tmp_score$1.txt
rm result.txt
rm tmp_in.txt
