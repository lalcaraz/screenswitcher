#!/bin/bash
echo "  ____                           ____          _ _       _"
echo " / ___|  ___ _ __ ___  ___ _ __ / ___|_      _(_) |_ ___| |__   ___ _ __"
echo " \___ \ / __| '__/ _ \/ _ \ '_ \\___ \ \ /\ / / | __/ __| '_ \ / _ \ '__|"
echo "  ___) | (__| | |  __/  __/ | | |___) \ V  V /| | || (__| | | |  __/ |"
echo " |____/ \___|_|  \___|\___|_| |_|____/ \_/\_/ |_|\__\___|_| |_|\___|_|"
echo ""
echo "by lalcaraz"
echo ""


startBlockMarker="## -- HyperPixel Configuration - START"
endBlockMarker="## -- HyperPixel Configuration - END"

if [[ $EUID -ne 0 ]]; then
   printf "\nThis script must be run as root.\n\n"
   exit 1
fi

if [ -f config.txt ];
then

	printf "\nFile config.txt found".

	if [ -f config.txt.bak ]; then
	        printf "\nConfiguration backup found, not making a copy"
	else
	        cp config.txt config.txt.bak
	fi

	startLine="$(grep -n "$startBlockMarker" config.txt | head -n 1 | cut -d: -f1)"
	endLine="$(grep -n "$endBlockMarker" config.txt | head -n 1 | cut -d: -f1)"

	if [ $startLine -ge 0 -a $endLine -ge 0 ];
	then
		printf "\nConfiguration found between lines $startLine and $endLine\n"

		lineToValidate="$(head -n $((startLine+1)) config.txt | tail -1)"
		firstCharOfLineToValidate=${lineToValidate:0:1}
		if [ "$firstCharOfLineToValidate" == "#" ];
                        then
				printf "\n -- HDMI is enabled. Switching to Hyperpixel"
			else
				printf "\n -- Hyperpixel is enabled. Switching to HDMI"
		fi

		for i in $(seq $((startLine+1)) $((endLine-1)));
		do
			lineToChange="$(head -n $i config.txt | tail -1)"
			firstChar=${lineToChange:0:1}
			if [ "$firstChar" == "#" ];
			then
				newLine=${lineToChange:1}
			else
				newLine="#$(head -n $i config.txt | tail -1)"
			fi
			sed -i "s/$lineToChange/\\$newLine/" config.txt
		done
		printf "\n Configuration has been changed and will be valid after restarting"
	else
		printf "\nConfiguration limits were not found."
	fi
else
	printf "\nFile config.txt not found"
fi

printf "\n"
