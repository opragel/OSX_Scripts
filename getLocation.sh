#!/bin/bash
# Created by Owen Pragel on September 7th, 2013. Credit to
echo "<result>"
/usr/bin/./whereami | grep -A 1 'Latitude\|services\|Wi-Fi'
echo "</result>"