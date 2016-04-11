#!/bin/bash

function dockerrm {
    sudo docker ps -aq | xargs -L sudo docker rm
}

function dockerrmi {
    sudo docker images -q | xargs -L sudo docker rmi
}

function dockercleanorphans {
    sudo docker images | grep "<none>" | cut -c41-53 | sudo -L xargs docker rmi
}
