#!/bin/bash

# parameter
R="-R120/250/5/60"
J="-JX7.2i/3i"


R2="-R20/190/0/60"
J2="-JX8.5i/3i"


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
# set
site='Site10'
# site 10 
R10="-R0/180/0/60"
J10="-JX7.5i/2.5i"
R=$R10
J=$J10
echo $site $R $J
#gmt psxy GroundSurvey.csv -R -J -Sc0.1c -Gred -B -P -O >> $PS
#-Zmin[/max][+a][+ccol][+i]
#gmt select ALS.xyz $R -Z0/1.37 > block.xyz

#gmt blockmean hawaii.xyg -R198/208/18/25 -I5m > hawaii_5x5.xyg
#gmt blockmedian tls.txt $R -I0.1     > median.txt
#gmt nearneighbor median.txt $R -I0.1 -Gmean.grd -S2 -N8/6
#gdal_translate NETCDF:"mean.grd" 2021DSM_Rodanthe.tif

#gmt xyz2grd $R  -I1 block.xyz  -Gmean.grd
#gmt makecpt -Crainbow -Z -T0.5/1.2/0.1  > mean.cpt
gmt grdsample ../out/2023_${site}_mean_terrain.grd $R  -G../out/2023.grd
gmt grdsample ../out/2022_${site}_mean_terrain.grd $R  -G../out/2022.grd
gmt grdmath  ../out/2023.grd ../out/2022.grd SUB = ../out/DEM_diff.grd


gmt makecpt -Cred,white,blue -T-0.5/0.5/0.1 -D -Z > ../out/mean.cpt
PS="../out/${site}_DEM_diff.ps"
gmt psbasemap $R  $J -K  -Bxa20f10+l"Along Shore [m]" -Bya10f5+l"Cross Shore [m]" -BWSne  > $PS
#gmt psxy block.xyz -R-10/10/-10/10 -JX6i -Sc0.1c -Ggrey -B -P -K -O>> $PS

gmt grdimage -R -J  ../out/DEM_diff.grd    -C../out/mean.cpt -I+ -K -O  -Q >> $PS

gmt psxy -R -J -Sc0.25 -Gred -B   -O -K >> $PS << EOF
128.841, 51.987,0.000, site 10
EOF
#-Bxaf+l"height"
gmt psscale -C../out/mean.cpt  -Dx7.6i/2.5i+w2.5i/0.3c+jTC -Bxaf -By+lm -O >> $PS

gmt psconvert $PS -Tj -A
#
###view files
#evince $PS &
