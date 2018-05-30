#!/bin/bash

docker run \
    --name=jupyter \
    -d \
    -v $(pwd -P)/volume:/home/jupyter/from_host \
    --network="host" \
    my/jupyter

