#!/bin/bash
X=150
result="../out/DEM_${X}_2022.prof"
echo $result
year=2023
file="../out/Site1_Hollowell_${year}_rotate.txt"
PS='../out/${year}_site1_DEM.ps'
grd='../out/${year}_site1_mean_terrain.grd'
echo $file


# Use find to locate files matching the pattern
file_path=$(find ../out -name 'Site3*2022_rotate.txt' -type f)
# Check if the file was found
if [ -n "$file_path" ]; then
    echo "File found: $file_path"
else
    echo "File not found."
fi