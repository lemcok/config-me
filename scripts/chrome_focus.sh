#!/bin/bash
chrome_app_name='google-chrome'

workspace_number=`wmctrl -d | grep '\*' | cut -d' ' -f 1`
win_list=`wmctrl -lx | grep $chrome_app_name | grep " $workspace_number " | awk '{print $1}'`

# Get the id of the active window (i.e., window which has the focus)
active_win_id=`xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}' | awk -F', ' '{print $1}'`
if [ "$active_win_id" == "0" ]; then
    active_win_id=""
fi

if [[ "$workspace_number" == "1" ]]; then
    id_win_chrome=`wmctrl -lx | grep $chrome_app_name| grep " $workspace_number " | awk '{print $1}'`
    (wmctrl -ia $id_win_chrome)
    exit 0  
else
    id_win_chrome=`wmctrl -lx | grep $chrome_app_name| grep " 1 " | awk '{print $1}'`
    (wmctrl -ia $id_win_chrome)
    exit 0  
fi

exit 0