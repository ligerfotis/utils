#!/bin/bash

play_file=$1
record_file=$2

xterm -hold -e "roslaunch openpose_utils_launch whole_pipeline_realsense_with_marker.launch" &
sleep 3
xterm -hold -e "roslaunch keypoint_3d_matching keypoint_3d_matching.launch" &
sleep 3
echo "Playing ${play_file} on demand"
roslaunch bag_read_service bag_read_service.launch bag_file:="${play_file}"

rosservice call /next_msg 
echo "Recording ${record_file} on demand"

# xterm -hold -e "rosbag play file2.bag"
killall xterm
exit 0