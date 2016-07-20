#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Text read from file: $line"
    mv "$line" ~/Downloads/files_from_file/
done < "$1"
