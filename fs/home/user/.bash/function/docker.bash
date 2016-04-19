#!/bin/bash

function dockerrm {
    sudo docker ps -aq | xargs sudo docker rm
}

function dockerrmi {
    sudo docker images -q | xargs sudo docker rmi
}

function dockercleanorphans {
    sudo docker images | grep "<none>" | cut -c41-53 | sudo xargs docker rmi
}
