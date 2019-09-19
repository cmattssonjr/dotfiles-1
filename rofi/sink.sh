#!/bin/zsh

if [ -z $@ ]
then
function get_sinks ()
{
    pac_list=$(pactl list)
    sink=$(echo $pac_list |grep 'Sink #' | awk -F'#' '{ print $2 }')
    args=$(echo $pac_list |grep "Sink #$sink" -A 4)
    sink_name=$(echo $args | grep "Name" | awk -F': ' '{ print $2 }') 
    state=$(echo $args | grep "State" | awk -F': ' '{ print $2 }') 

    echo "$sink : $sink_name - State : $state " 
    return "$sink"
}


echo "empty"; get_sinks
else
    SINK=$@

    if [ x"empty" = x"${SINK}" ]
    then
        i3_empty_workspace.sh >/dev/null
    elif [ -n "${SINK}" ]
    then
        i3-msg workspace "${SINK}" >/dev/null
    fi
fi
