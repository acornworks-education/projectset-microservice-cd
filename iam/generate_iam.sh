#!/bin/bash

# Define an array of regions
bucket_suffix=$1
regions=("ap-southeast-2" "ap-northeast-2")

echo "Bucket_Suffix=$bucket_suffix"

# Loop through the array and generate a JSON file for each region
for region in "${regions[@]}"; do
    jsonnet --ext-str region="$region" --ext-str bucket_suffix="$bucket_suffix" -o "${region}.json" packer.jsonnet
done
