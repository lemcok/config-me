#!/bin/bash
# if [ $# -lt 1 ] ; then
#   echo "Usage : $0 <window name> [<command to run if there is no window with that name>]"
#   exit 1
# fi

vscode_app_name='vscode'
chrome_app_name='google-chrome'

workspace_number=`wmctrl -d | grep '\*' | cut -d' ' -f 1`
vscode_win_list=`wmctrl -lx | grep $vscode_app_name | grep " $workspace_number " | awk '{print $1}'`
chrome_win_list=`wmctrl -lx | grep $chrome_app_name | grep " $workspace_number " | awk '{print $1}'`

# Get the id of the active window (i.e., window which has the focus)
active_win_id=`xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}' | awk -F', ' '{print $1}'`
if [ "$active_win_id" == "0" ]; then
    active_win_id=""
fi

# If the window currently focused matches the first argument, seek the id of the next window in vscode_win_list which matches it
if [[ "$vscode_win_list" == *"$active_win_id"* ]]; then
  if [[ "$workspace_number" == "1" ]]; then
    workspace_number="0"
  elif [[ "$workspace_number" == "0" ]]; then
    workspace_number="1"
  fi
  id_win_chrome=`wmctrl -lx | grep $chrome_app_name| grep " $workspace_number " | awk '{print $1}'`
  (wmctrl -ia $id_win_chrome)
  exit 0

elif [[ "$chrome_win_list" == *"$active_win_id"* && "$workspace_number" == "1"  ]]; then
  # Get the list of all the windows which do
    win_list=$(wmctrl -lx | grep $vscode_app_name | awk '{print $1}')

    IDs=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
    IDs=(${IDs##*#})

   # For each window in focus order
    for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
        for i in $win_list; do

           # If the window matches the first argument, focus on it
            if [ $((i)) = $((IDs[idx])) ]; then
                wmctrl -ia $i
                exit 0
            fi
        done
    done

elif [[ "$chrome_win_list" == *"$active_win_id"*  ]]; then
  if [[ "$workspace_number" == "0" ]]; then
    workspace_number="1"
  elif [[ "$workspace_number" == "1" ]]; then
    workspace_number="0"
  fi
  # Get the list of all the windows which do
    win_list=$(wmctrl -lx | grep $vscode_app_name | awk '{print $1}')

    IDs=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
    IDs=(${IDs##*#})

   # For each window in focus order
    for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
        for i in $win_list; do

           # If the window matches the first argument, focus on it
            if [ $((i)) = $((IDs[idx])) ]; then
                wmctrl -ia $i
                exit 0
            fi
        done
    done
else 
    ##Get the list of all the windows which do
    win_list=$(wmctrl -lx | grep $vscode_app_name | awk '{print $1}')

    IDs=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
    IDs=(${IDs##*#})

   # For each window in focus order
    for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
        for i in $win_list; do

           # If the window matches the first argument, focus on it
            if [ $((i)) = $((IDs[idx])) ]; then
                wmctrl -ia $i
                exit 0
            fi
        done
    done
fi

exit 0