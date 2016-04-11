#!/bin/bash

function main {
  xrandr --newmode "2560x1440" 220.812 2560 2608 2640 2720 1440 1443 1448 1478 -hsync -vsync
  xrandr --addmode HDMI1 2560x1440 
  xrandr --output HDMI1 --mode 2560x1440
}

main "$@"
