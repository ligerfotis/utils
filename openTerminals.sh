#!/bin/bash

play_file=$1
record_file=$2

xterm -geometry 96x24+2000+0 -hold -e "roslaunch openpose_utils_launch whole_pipeline_realsense_with_marker.launch" &
pid1="$!"
sleep 2

xterm -geometry 96x24-0+0 -hold -e "roslaunch keypoint_3d_matching keypoint_3d_matching.launch" &
pid2="$!"
sleep 2

echo "Recording ${record_file} on demand"
xterm -geometry 96x24+2000-0 -hold -e "rosbag record /keypoint_3d_matching /tf -O "${record_file}" __name:=my_bag " &
pid4="$!"

echo "Playing ${play_file} on demand"
xterm -geometry 96x24-0-0 -hold -e "sleep 3;rosservice call /next_msg"  &
pid3="$!"


roslaunch bag_read_service bag_read_service.launch bag_file:="${play_file}"
rosnode kill /my_bag
sleep 2
rosbag reindex "${record_file}"

kill "$pid1"
kill "$pid2"
kill "$pid3"
kill "$pid4"

exit 0