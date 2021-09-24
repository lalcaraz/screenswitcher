# What is this?
This is a simple script to switch video output from HDMI to the HyperPixel (which it’s gonna be using the GPIO port). Following the KISS pattern, this will search lines between two  block limiters and toggle those lines into comments.

# How to use this?
1. Copy the file screenSwitcher.sh to the /boot folder (where the config.txt is located).
2. Edit your config.txt file and put the block limiters around the code that enables the HyperPixel screen to work. Put this "## -- HyperPixel Configuration - START" one line above the start of the block and "## -- HyperPixel Configuration - END" one line after the last parameter. Do not copy the " symbol, just the text between the two ". 
3. If you wanna change the block limiters, there are two variables in the script.
4. Now, execute this script with SUDO or it will not work.
5. It will toggle between HDMI and HyperPixel and will work after the next reboot.
