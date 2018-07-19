#!/bin/bash
# set the new release-candidate version here
CUR=2018.1~exp-215
wget -k --no-check-certificate http://freifunk.in-kiel.de/firmware-rc.html -O index.html
# replace the data from the template
sed -i 's|/.*/sysupgrade/gluon-ffki-<VERSION>|/release-candidate/sysupgrade/gluon-ffki-'$CUR'|g' index.html
sed -i 's|/.*/factory/gluon-ffki-<VERSION>|/release-candidate/factory/gluon-ffki-'$CUR'|g' index.html
