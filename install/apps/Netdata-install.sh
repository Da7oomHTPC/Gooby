#!/bin/bash

docker ps -q -f name=netdata > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Dependencies

		source /opt/GooPlex/install/misc/docker.sh
		docker container stop netdata
		docker container rm netdata

		# Main script

		docker run -d --name=netdata \
		--restart=always \
		-p 19999:19999 \
		-v /proc:/host/proc:ro \
		-v /sys:/host/sys:ro \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		--cap-add SYS_PTRACE \
		--security-opt apparmor=unconfined \
		netdata/netdata

		sudo chown plexuser:plexuser -R /home/plexuser

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
