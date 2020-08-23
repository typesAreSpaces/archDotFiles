#!/bin/bash
#currentgpu=$(cat ~/scripts/currentvars/currentgpu)
currentgpu=$(optimus-manager --print-mode)
if [ ${currentgpu: -3} = "amd" ]
then
	#sudo optimus-manager-daemon &
	#sleep 1
	sudo optimus-manager --set-startup nvidia
	#sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.amd
	#sudo mv /etc/X11/xorg.conf.nvidia /etc/X11/xorg.conf
elif  [ ${currentgpu: -6} = "nvidia" ]
then
        #sudo optimus-manager-daemon &
        #sleep 1
	sudo optimus-manager --set-startup amd
	#sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.nvidia
	#sudo mv /etc/X11/xorg.conf.amd /etc/X11/xorg.conf
fi
sudo reboot
