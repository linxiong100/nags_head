# coordinate translate
#!/bin/bash
#Rotation 0 degrees, counterclockwise direction
theta=`echo | awk '{print 100.0*3.1415926/180.0}'`
sin=`echo | awk '{print sin('$theta')}'`
cos=`echo | awk '{print cos('$theta')}'`

#The XY coordinates were initialized as (0, 0) at:
X0=3225460
Y0=-2374179
file='../data/Site1_Hollowell_2022.txt'
o_file='../out/Site1_Hollowell_2022_rotate.txt'
# geoid2b geoid  height = -38.965 m
awk  -F, '{printf ("%7.3f,%7.3f,%4.3f\n", $1*'$cos'+$2*'$sin'-'$X0', -1.0*$1*'$sin'+$2*'$cos'- '$Y0', $3+38.965 )}' $file >  $o_file
