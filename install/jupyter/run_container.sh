#!/bin/bash

docker run \
    --name=jupyter \
    -d \
    -v /home/$(whoami)/data/jupyter_data:/home/jupyter/from_host \
    --network="host" \
    my/jupyter

