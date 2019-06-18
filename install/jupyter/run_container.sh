#!/bin/bash

docker run \
    --name=jupyter \
    -d --restart always \
    -v /home/$(whoami)/data/jupyter_data:/home/jupyter/from_host \
    --network="host" \
    my/jupyter

