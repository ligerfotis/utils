#!/bin/bash 

filename=$1
for ((i=17; i>0; i--))
do
   sleep 1 
   echo -n "$i "
done
#sleep 30

echo "Started"
rosbag record /camera/color/camera_info /camera/color/image_raw /camera/depth_registered/points /tf --duration=10 -O "${filename}"

echo "Finished"
