#!/bin/bash

participant=$1
#participant="1"


echo "Participant number: ${participant}"

for i in {3..3}
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
	#GESTURES=("plate" )

	for ((j=0; j< ${#GESTURES[@]}; j++ ))
	do	
		DIRE="${current_dir}/${GESTURES[j]}"

		if [ ! -d ${DIRE} ] 
		then 
			echo "Dir ${DIRE} not found"
	    exit 1
		fi
		
		file="${GESTURES[j]}_${participant}$i.bag"

		./CSE6963_rosbag_data/openTerminals.sh "${DIRE}/${file}" "${DIRE}/kp_${file}"
		python ~/catkin_ws/src/rosbag_pandas/scripts/bag_csv -b "${DIRE}/kp_${file}" -o "${DIRE}/kp_${GESTURES[j]}_${participant}$i.csv"

		
	done

	echo "${BASE_DIR} for Participant ${participant} is over"
done

