#!/bin/bash


TODAY=$(date +%Y_%m_%d)
echo "today: $TODAY"


echo -n "copy developement folder..."
cp -r ~/developement developement_$TODAY
echo " developement copied."


echo -n "copy jupyter notebooks..."
rsync -aq --progress ~/locals/install/jupyter/volume/notebooks/ notebooks_$TODAY --exclude orderlog
echo " jupyter notebooks copied."


echo -n "create tar..."
tar cfj backup_$TODAY.tar.bz2 developement_$TODAY notebooks_$TODAY
echo " tar created."


echo -n "clear data..."
rm -rf ~/developement_$TODAY
rm -rf ~/notebooks_$TODAY
echo " data cleared."

