#!/bin/bash
# volume change 
# elevation = 4m 
site='Site10'
echo $site
grd22="../out/2022_${site}_mean_terrain.grd"
grd23="../out/2023_${site}_mean_terrain.grd"
# given contour (or zero if not given) and 
# reports the area, volume, and maximum mean height (volume/area)
gmt grdvolume $grd22  -C4 
gmt grdvolume $grd23  -C4 

