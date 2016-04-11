################################
# keyboard brightness increase
################################
#!/bin/bash

dev_dir=/sys/class/leds/asus::kbd_backlight

brightness_val=$(cat $dev_dir/brightness)
if [ 3 -gt $brightness_val ]
  then
    brightness_val=$(($brightness_val + 1))
    echo $brightness_val | sudo tee $dev_dir/brightness
fi

