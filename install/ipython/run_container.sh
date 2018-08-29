#!/bin/bash

docker run -it --rm \
    --name=ipython \
    -v $(pwd -P)/volume:/home/me \
    --network="host" \
    my/ipython

