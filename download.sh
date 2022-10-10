#!/bin/sh

sudo rm -rf app

while IFS= read -r line; do

    name=$(echo $line| cut -d ' ' -f1)
    path=$(echo $line| cut -d ' ' -f2)

    if [ "$name" = "$1" ]; then
      rm -rf download/"$path"
      mkdir -p download/"$path"
      (
        cd download
        mkdir -p $path
        unzip "$path".zip -d $path
      )
      mkdir -p app/public
      cp -r download/"$path"/upload/* app/public
      rm -rf download/"$path"

      touch app/public/config.php app/public/admin/config.php
      rm app/public/config-dist.php app/public/admin/config-dist.php

      chmod -R 777 /app
    fi
done < ./download.txt