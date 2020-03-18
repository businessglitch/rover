#!/bin/bash

set -e
./scripts/pre_requisites.sh

tag=$(date +"%g%m.%d%H")

echo "Creating version ${tag}"

# Build the rover base image
sudo docker-compose build


case "$1" in 
    "github")
        sudo docker tag rover_rover aztfmod/rover:$tag
        sudo docker tag rover_rover aztfmod/rover:latest

        sudo docker push aztfmod/rover:$tag
        sudo docker push aztfmod/rover:latest

        # tag the git branch and push
        git tag $tag master
        git push --follow-tags
        echo "Version aztfmod/rover:${tag} created."
        ;;
    "private")
        sudo docker tag rover_rover aztfmod/roverdev:$tag
        sudo docker tag rover_rover aztfmod/roverdev:latest

        sudo docker push aztfmod/roverdev:$tag
        sudo docker push aztfmod/roverdev:latest
        echo "Version aztfmod/roverdev:${tag} created."
        echo "Version aztfmod/roverdev:latest created."
        ;;
    *)    
        sudo docker tag rover_rover aztfmod/rover:$tag
        sudo docker tag rover_rover aztfmod/rover:latest
        echo "Local version created"
        echo "Version aztfmod/rover:${tag} created."
        ;;
esac
