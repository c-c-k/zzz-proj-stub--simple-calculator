#!/usr/bin/env bash

# helper functions
function is_int { [[ "$1" =~ ^-?[0-9]+\.?[0-9]*$ ]] ; }

function is_operator { [[ "$1" =~ ^[-+*/^]$ ]] ; }

function is_valid_input { (( "$#" == 3 )) && is_int "$1" && is_operator "$2" && is_int "$3" ; }

function calculate { echo "scale=2; $1 $2 $3"|bc --mathlib ; }

# initialize history file
HISTORY="operation_history.txt"
rm "$HISTORY" 2>/dev/null

echo "Welcome to the basic calculator!" | tee -a  "$HISTORY"
while true
do
    # get user input
    echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a  "$HISTORY"
    read -a USER_INPUT -r
    echo "${USER_INPUT[@]}" >>"$HISTORY"
    [[ "${USER_INPUT[0]}" == "quit" ]] && break


    # test user input
    if is_valid_input "${USER_INPUT[@]}"
    then
        calculate "${USER_INPUT[@]}" | tee -a  "$HISTORY"
    else
        echo 'Operation check failed!' | tee -a  "$HISTORY"
    fi
done
echo "Goodbye!" | tee -a  "$HISTORY"

