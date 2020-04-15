#!/bin/bash 


participant=$1
#participant="1"

if [ $# -eq 0 ]
  then
    read -p "Please input the number of the participant: " participant
fi

echo "Participant number: ${participant}"


BASE_DIR="Experiment2"
SUB_DIR="Participant_${participant}"
current_dir="${BASE_DIR}/${SUB_DIR}"

topics=("/camera/color/camera_info" "/camera/color/image_raw" "/camera/depth_registered/points" "/tf")
topics1=("/keypoint_3d_matching" "/tf")
topcis2=("/topic_transform")

if [ ! -d ${BASE_DIR} ] 
	then 
		echo "Creating ${BASE_DIR} directory"
		echo ""
	    	mkdir ${BASE_DIR}
	fi

if [ ! -d ${current_dir} ] 
then
	echo "Creating ${SUB_DIR} directory in ${BASE_DIR}"
    mkdir ${current_dir}
fi

GESTURES=("cube" "polygon" "cup" "botle" "plate")

record(){
	cur_file=$1
	echo "record topics on file ${cur_file}"
	./runTimer.sh "${cur_file}"
	# rosbag record ${topics[0]} ${topics[1]} ${topics[2]} ${topics[3]} --duration=10 -O ${file}
}

for ((j=0; j< ${#GESTURES[@]}; j++ ))
do	
	DIRE="${current_dir}/${GESTURES[j]}"
	echo "Next Gesture: ${GESTURES[j]}"
	read -p "Press enter to start recording"

	if [ ! -d ${DIRE} ] 
	then 
		echo "Creating ${DIRE} directory"
		echo ""
	    	mkdir ${DIRE}
	fi
	
	file="${GESTURES[j]}_${participant}.bag"
	record "${DIRE}/${file}"

	# Asks if happy with the measurement to continue to the next one
	while true; do
	    read -p "Do you want to continue to the next gesture?[Yy/Nn]" yn
	    case $yn in
	        [Yy]* ) echo""
			break
			;;
	        [Nn]* ) echo "redo recoding of gesture ${GESTURES[j]}"
					record "${DIRE}/${file}"
			;;
	        * ) echo "Please answer Yy or Nn.";;
	    esac
	done

	
done

 echo "${BASE_DIR} for Participant ${participant} is over"
