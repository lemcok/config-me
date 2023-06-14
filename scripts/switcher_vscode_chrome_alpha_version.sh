#!/bin/bash
# if [ $# -lt 1 ] ; then
#   echo "Usage : $0 <window name> [<command to run if there is no window with that name>]"
#   exit 1
# fi

app_name1=vscode
app_name2='google-chrome'

workspace_number=`wmctrl -d | grep '\*' | cut -d' ' -f 1`
win_list=`wmctrl -lx | grep $app_name1 | grep " $workspace_number " | awk '{print $1}'`
win_list2=`wmctrl -lx | grep $app_name2 | grep " $workspace_number " | awk '{print $1}'`

# Get the id of the active window (i.e., window which has the focus)
active_win_id=`xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}' | awk -F', ' '{print $1}'`
if [ "$active_win_id" == "0" ]; then
    active_win_id=""
fi

# If the window currently focused matches the first argument, seek the id of the next window in win_list which matches it
if [[ "$win_list" == *"$active_win_id"* ]]; then
  if [[ "$workspace_number" == "1" ]]; then
    workspace_number="0"
  fi
  if [[ "$workspace_number" == "0" ]]; then
    workspace_number="1"
  fi
  id_win_app2=`wmctrl -lx | grep $app_name2| grep " $workspace_number " | awk '{print $1}'`
  (wmctrl -ia $id_win_app2)
      exit 0

else 
  if [[ "$workspace_number" == "0" ]]; then
    workspace_number="1"
  fi
  if [[ "$workspace_number" == "1" ]]; then
    workspace_number="0"
  fi

  win_list=$(wmctrl -lx | grep $app_name1 | grep " $workspace_number " | awk '{print $1}')

  IDs=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
  IDs=(${IDs##*#})
  echo "$IDs"

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

if [[ "$win_list2" == *"$active_win_id"* ]]; then
  if [[ "$workspace_number" == "0" ]]; then
    workspace_number="1"
  fi
  if [[ "$workspace_number" == "1" ]]; then
    workspace_number="0"
  fi
  id_win_app1=`wmctrl -lx | grep $app_name1 | grep " $workspace_number " | awk '{print $1}'`
  (wmctrl -ia $id_win_app1)
  exit 0
else 
  if [[ "$workspace_number" == "1" ]]; then
    workspace_number="0"
  fi
  if [[ "$workspace_number" == "0" ]]; then
    workspace_number="1"
  fi
  win_list2=$(wmctrl -lx | grep $app_name2 | grep " $workspace_number " | awk '{print $1}')

  IDs=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
  IDs=(${IDs##*#})
  echo "$IDs"

  for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
        for i in $win_list2; do

           # If the window matches the first argument, focus on it
            if [ $((i)) = $((IDs[idx])) ]; then
                wmctrl -ia $i
                exit 0    
            fi
        done
    done

fi

exit 0