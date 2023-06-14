#!/bin/bash
if ! wmctrl -lx | grep -w Terminal;
then
  deepin-terminal
  exit 0
fi

id_app_terminal=`wmctrl -lx | grep -i -w deepin-terminal | awk '{print $1}'`
wmctrl -i -R $id_app_terminal
exit 0