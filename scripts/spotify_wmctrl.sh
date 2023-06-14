#!/bin/bash
if wmctrl -l | grep -w Spotify;
then
word=`wmctrl -l | grep -i -w Spotify`;
id=`cut -c 1-10 <<<$word`;
###wmctrl -i -R $id
wmctrl -i -a $id
else
spotify %U
fi
