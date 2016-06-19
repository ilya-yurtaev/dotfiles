#!/bin/sh
synclient TapButton2=2 &
synclient TapButton3=3 &
conky -d &
xgamma -bgamma 0.85 &
sudo service thinkfan restart &
sudo powertop --auto-tune &
mpd &
gnome-terminal --command=tmux &
