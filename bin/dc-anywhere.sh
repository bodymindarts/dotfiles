#!/bin/bash

while [[ ! -f docker-compose.yml && $PWD != '/' ]]; do
    cd ..
done

if [[ -f docker-compose.yml ]]; then
    docker-compose $@
else
    echo "Couldn't find docker-compose.yml in any parent directory" 1>&2
    exit 1
fi
