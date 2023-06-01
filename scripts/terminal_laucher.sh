#!/bin/bash
if wmctrl -l | grep -w Terminal;
then
word=`wmctrl -l | grep -i -w Terminal`;
id=`cut -c 1-10 <<<$word`;
wmctrl -i -R $id
else
deepin-terminal
fi

