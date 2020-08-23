#!/bin/bash
#currentgpu=$(cat ~/scripts/currentvars/currentgpu)
currentgpu=$(optimus-manager --print-mode)
if [ ${currentgpu: -3} = "amd" ]
then
	echo %{u#F93737}%{+u} ${currentgpu: -3}gpu %{u-}
elif [ ${currentgpu: -6} = "nvidia" ]
then
	echo %{u#30EB50}%{+u} ${currentgpu: -6} %{u-} 
fi
