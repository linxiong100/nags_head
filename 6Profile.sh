#!/bin/bash
gmt set MAP_FRAME_PEN 0.5p,black
gmt set MAP_TICK_LENGTH_PRIMARY  4p/2p
# ../out/2023_site1_mean_terrain.grd
#####difference profile
######-o,  only output second and third column  x, y , 
site='Site10'
Y1=0
Y2=60
echo 'Profile for' $site
for ((X = 0; X <= 180; X += 10)); do # 250

    # Add your commands or actions here using the variable $i
    prof_2022="../out/${site}_DEM_${X}_2022.prof"
    prof_2023="../out/${site}_DEM_${X}_2023.prof"
    echo ${X}
    E="-E${X}/${Y1}/${X}/${Y2}"
    gmt grdtrack  $E  -G../out/2022_${site}_mean_terrain.grd -o1,2 >  $prof_2022
    gmt grdtrack  $E  -G../out/2023_${site}_mean_terrain.grd -o1,2 >  $prof_2023 
    PS="../out/${site}_profile_X_${X}.ps"
    # -Xa1.5c -Ya3c :."Profile_X=1675m":
    # -Xa1.5c -Ya12c
    gmt psxy $prof_2022 -R${Y1}/${Y2}/1/10  -JX3.5i/2.5i  -Bxa10f5+l"Cross Shore [m]" -Bya2f1+l"Elevation [m, NAVD88]" -BWSne  -W1p,blue   -K > $PS
    gmt psxy $prof_2023   -R  -J  -B -W1p,red  -O -K >> $PS
    # -D[g|j|J|n|x]refpoint+wwidth[/height][+jjustify][+lspacing][+odx[/dy]]
    # S [dx1 symbol size fill pen [ dx2 text ]]
    gmt pslegend << END -R -J -Dx0i/1.5i/2i/0.95i/LB  -O >> $PS
S 0.25i - 1c red 1p,red 0.5i 2023 Mar
S 0.25i - 1c blue 1p,blue 0.5i 2022 Dec
END
    
    gmt psconvert $PS -Tj -A
done


