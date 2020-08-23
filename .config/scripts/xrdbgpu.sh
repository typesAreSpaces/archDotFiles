#!/bin/bash
currentgpu=$(optimus-manager --print-mode)
if [ ${currentgpu: -3} = "amd" ]
then
	xrdb ~/.XressourcesA > /dev/null
    bash ~/scripts/acpi_call_dgpu.sh off
elif  [ ${currentgpu: -6} = "nvidia" ]
then
	xrdb ~/.Xressources > /dev/null
fi
echo $currentgpu > ~/scripts/currentvars/currentgpu
