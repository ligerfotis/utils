#!/bin/bash

participant=$1
#participant="1"


echo "Participant number: ${participant}"

for i in {1..3}
	do
	BASE_DIR="/home/ligerfotis/CSE6963_rosbag_data/Experiment2"
	SUB_DIR="Participant_${participant}$i"
	current_dir="${BASE_DIR}/${SUB_DIR}"

	topics=("/camera/color/camera_info" "/camera/color/image_raw" "/camera/depth_registered/points" "/tf")
	topics1=("/keypoint_3d_matching" "/tf")
	topcis2=("/topic_transform")

	if [ ! -d ${current_dir} ] 
	then
		echo "Dir ${current_dir} not found"
	    exit 1
	fi

	GESTURES=("cube" "polygon" "cup" "botle" "plate")
	# GESTURES=("cube" )

	for ((j=0; j< ${#GESTURES[@]}; j++ ))
	do	
		DIRE="${current_dir}/${GESTURES[j]}"

		if [ ! -d ${DIRE} ] 
		then 
			echo "Dir ${DIRE} not found"
	    exit 1
		fi
		
		file="${GESTURES[j]}_${participant}.bag"

		./CSE6963_rosbag_data/openTerminals.sh "${DIRE}/${file}" "${DIRE}/kp_${file}"

		
	done

	echo "${BASE_DIR} for Participant ${participant} is over"
done




# gnome-terminal --command "roscore" &
# gnome-terminal --command "roslaunch openpose_utils_launch whole_pipeline_realsense_with_marker.launch" &
# gnome-terminal --command "roslaunch keypoint_3d_matching keypoint_3d_matching.launch " &