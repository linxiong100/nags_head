# coordinate translate
#!/bin/bash
#Rotation 0 degrees, counterclockwise direction
theta=`echo | awk '{print 110.0*3.1415926/180.0}'` #  112 degree for site 1 and 2;  115 for site 3; 
sin=`echo | awk '{print sin('$theta')}'`
cos=`echo | awk '{print cos('$theta')}'`

#The XY coordinates were initialized as (0, 0) at:
X0=449055
Y0=3967376
site='Site10'


################################################
file="../data/${site}_*_2023.txt"
o_file="../out/${site}_2023_rotate.txt"
# geoid2b geoid  height = -38.965 m
echo 'Rotating ' $file
awk  -F, '{printf ("%7.3f,%7.3f,%4.3f\n", ($1-'$X0')*'$cos'+($2-'$Y0')*'$sin', -1.0*($1-'$X0')*'$sin'+($2-'$Y0')*'$cos', $3 )}' $file >  $o_file
file="../data/${site}_*_2022.txt"
o_file="../out/${site}_2022_rotate.txt"
echo 'Rotating '  $file
# geoid2b geoid  height = -38.965 m
awk  -F, '{printf ("%7.3f,%7.3f,%4.3f\n", ($1-'$X0')*'$cos'+($2-'$Y0')*'$sin', -1.0*($1-'$X0')*'$sin'+($2-'$Y0')*'$cos', $3 )}' $file >  $o_file
echo 'Rotating field sites utm...'  
# rotate field site utm.
awk  -F, '{printf ("%7.3f,%7.3f,%4.3f\n", ($1-'$X0')*'$cos'+($2-'$Y0')*'$sin', -1.0*($1-'$X0')*'$sin'+($2-'$Y0')*'$cos', $3 )}' ../data/sites_utm.csv >  ../out/sites_utm_rotate.csv

# Note: for site 1 
# firstly rotate 112 degree, then minus (3524583, -1902218 )

# Site 2 firstly minus then rotate. 
# minus  Easting  =  445920  m
#        Northing = 3974901 m

# Site 3 
# ref point easting 446865 northing 3972704

# Site 4 tide
#Easting  =  447248.3152 m
#Northing = 3971845.5681 m
#Height   =       1.9188 m

# Site 5 June St   E=447919, N=3970267
# Site 6 Jucos E=448270, N=3969461

# Site 7 and 8 P and P st, refer to E=448754 N=3968300

# site 9 Seagull, refer to E=448862 N=3967910

# site 10  Inlet Rd. refer to E=449055, N=3967376






