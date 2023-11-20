#!/bin/bash
# GMT script to plot the USA
# AVN
# Last modified Mon Oct 23 16:46:24 EDT 2006
#gmt pscoast -R-83/-79/24/27 -JM6i -Ba1/a1 -Dc -G240 -W1/0 -P  -K > $PS
#
# gmt gmtinfo -C  ../out/Site1_Hollowell_2022_rotate.txt > ../out/region.txt
# x1="$(awk '{print $1}' ../out/region.txt)"
# x2="$(awk '{print $2}' ../out/region.txt)"
# y1="$(awk '{print $3}' ../out/region.txt)"
# y2="$(awk '{print $4}' ../out/region.txt)"
# R="-R$x1/$x2/$y1/$y2"
# echo $x2 - $x1 | bc -l
# echo $y2 - $y1 | bc -l
year=2022
site='Site10'
I='-I0.1' # 1m for test


file="../out/${site}*${year}_rotate.txt" # ignore streetname
PS="../out/${year}_${site}_DEM.ps"
grd="../out/${year}_${site}_mean_terrain.grd"
echo "Generating grid for the year ${year}, ${site}..."
cpt="../out/mean.cpt"
# Site 1
R1="-R120/250/5/60"
J1="-JX7.2i/3i"
# site 2 
R2="-R20/190/0/60"
J2="-JX8.5i/3i"
# site 3 
R3="-R100/300/0/50"
J3="-JX8i/2i"
# site 4 
R4="-R60/340/0/60"
J4="-JX9.3i/2i"
# site 5 
R5="-R40/200/0/50"
J5="-JX6.4i/2i"
# site 6 
R6="-R80/300/0/50"
J6="-JX8.8i/2i"
# site 7 8 
R7="-R0/300/20/70"
J7="-JX9i/1.5i"
# site 9 
R9="-R0/200/0/60"
J9="-JX8.3i/2.5i"

# site 10 
R10="-R0/180/0/60"
J10="-JX7.5i/2.5i"
####################
R=$R10
J=$J10
echo $R $J $I
gmt blockmedian $file $R $I  > ../out/median.txt
gmt nearneighbor ../out/median.txt $R $I -G$grd -S3 -N8/2

#gdal_translate NETCDF:"mean_terrain.grd" 2021DEM_Rodanthe.tif
#gmt xyz2grd $R  -I1 block.xyz  -Gmean.grd
#gmt makecpt -Crainbow -Z -T0.5/1.2/0.1  > mean.cpt
#gmt grdgradient mean_terrain.grd -A0/270 -Gi.nc
gmt makecpt -Crainbow -T0/10/0.1 -D -Z > $cpt
gmt psbasemap $R $J  -K   -Bxa20f10+l"Along Shore [m]" -Bya10f5+l"Cross Shore [m]" -BWSne   > $PS
#gmt psbasemap -R -J -K  -O -B0ne >> $PS
#gmt psxy block.xyz -R-10/10/-10/10 -JX6i -Sc0.1c -Ggrey -B -P -K -O>> $PS
gmt grdimage -R -J  $grd   -C$cpt -I+ -K -O  -Q >> $PS
#gmt pstext -R -J  -O  -K  << EOF >> $PS
#1.4 0 FLM_10
#EOF
#109.431, 58.496,38.965
gmt psxy -R -J -Sc0.25 -Gred -B   -O -K >> $PS << EOF
128.841, 51.987,0.000, site 10
EOF
#-Bxaf+l"height"
gmt psscale -C$cpt  -Dx7.6i/2.5i+w2.5i/0.3c+jTC -Bxaf -By+lm -O >> $PS
gmt psconvert $PS -Tj -A

