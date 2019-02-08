#!/bin/bash

# clean data and mark to install again

docker-compose down && rm -rf ./data/*
rm -rf ./temp/*
rm -rf ./logs/*
touch ./temp/install
