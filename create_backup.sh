#!/bin/bash

TODAY=$(date +%Y_%m_%d)


echo -n "create backup_$TODAY..."
mkdir backup_$TODAY
echo " created."


echo -n "copy 'my' folder..."
cp -r ~/my backup_$TODAY/
echo " copied."


# ***

echo "copy data:"
mkdir -p backup_$TODAY/data/

echo -n "copy jupyter notebooks..."
mkdir -p backup_$TODAY/data/jupyter_data/notebooks/
rsync -aq --progress ~/data/jupyter_data/notebooks/ \
      backup_$TODAY/data/jupyter_data/notebooks/ \
      --exclude market_data --exclude external
echo " copied."

echo -n "copy articles..."
cp -r ~/data/articles/ backup_$TODAY/data/
echo " copied."


# ***

echo -n "copy home..."
mkdir -p backup_$TODAY/home/
cp ~/.emacs backup_$TODAY/home/
cp ~/.bash_aliases backup_$TODAY/home/
cp -r ~/.emacs.d backup_$TODAY/home/
cp -r ~/.ssh backup_$TODAY/home/
cp -r ~/.gnupg backup_$TODAY/home/
echo " copied."


# ***

echo -n "create tar..."
tar cfj backup_$TODAY.tar.bz2 backup_$TODAY
echo " created."

echo -n "sha256: "
sha256sum backup_$TODAY.tar.bz2


echo -n "gpg encrypt..."
gpg -o f -c backup_$TODAY.tar.bz2
echo " finish."

echo -n "sha256: "
sha256sum f


echo -n "clear data..."
rm -rf backup_$TODAY
rm backup_$TODAY.tar.bz2
echo " data cleared."
