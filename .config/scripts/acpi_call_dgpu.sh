#!/bin/bash
if [ $1 == "on" ]; then
    sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._ON" > /proc/acpi/call'
elif [ $1 == "off" ]; then
    sudo sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'
elif [ $1 == "status" ]; then
    sudo sh -c 'echo "\\_SB.PCI0.GPP0.PEGP.SGST" > /proc/acpi/call'
fi
sudo cat /proc/acpi/call


