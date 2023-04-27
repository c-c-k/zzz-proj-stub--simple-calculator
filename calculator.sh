#!/usr/bin/env bash

# helper functions
function is_int { [[ "$1" =~ ^-?[0-9]+\.?[0-9]*$ ]] ; }

function is_operator { [[ "$1" =~ ^[-+*/^]$ ]] ; }

function is_valid_input { (( "$#" == 3 )) && is_int "$1" && is_operator "$2" && is_int "$3" ; }

function calculate { echo "scale=2; $1 $2 $3"|bc --mathlib ; }

# get user input
echo "Enter an arithmetic operation:"
read -a USER_INPUT -r


# test user input
if is_valid_input "${USER_INPUT[@]}"
then
    calculate "${USER_INPUT[@]}"
else
    echo 'Operation check failed!'
fi
