#!/usr/bin/env bash

# set -ex

failures=()

function register_fail () {
  failures+=($1)
}

function run_test () {
  local exercise=${1}
  
  pushd exercises/${exercise} > /dev/null

  printf "Testing: %s -- " ${exercise}
  output=$(rebar3 eunit 2>&1)
  if ! [ "$?" == "0" ]; then
    register_fail ${exercise}
    printf "FAIL\n%s" "${output}"
  else
    printf "PASS\n"
  fi

  rm -rf _deps

  popd > /dev/null
}

function main () {
  local config=${1:-config.json}
  local exercises=( $(cat config.json | jq '.exercises[].slug' --raw-output | sort) )

  for e in "${exercises[@]}"; do
    run_test ${e} ${config}
  done
}

main $@

if [[ ${#failures[@]} != 0 ]]; then
  printf "\n\n%d examples have failed:\n\n" ${#failures[@]}

  for e in ${failures[@]}; do printf "* %s\n" ${e}; done

  exit ${#failures[@]}
fi

printf "\n\nCongratulations, all example implementations have passed!\n\n"
printf "                              .sssssssss.\n"
printf "                        .sssssssssssssssssss\n"
printf "                      sssssssssssssssssssssssss\n"
printf "                     ssssssssssssssssssssssssssss\n"
printf "                      @@sssssssssssssssssssssss@ss\n"
printf "                      |s@@@@sssssssssssssss@@@@s|s\n"
printf "               _______|sssss@@@@@sssss@@@@@sssss|s\n"
printf "             /         sssssssss@sssss@sssssssss|s\n"
printf "            /  .------+.ssssssss@sssss@ssssssss.|\n"
printf "           /  /       |...sssssss@sss@sssssss...|\n"
printf "          |  |        |.......sss@sss@ssss......|\n"
printf "          |  |        |..........s@ss@sss.......|\n"
printf "          |  |        |...........@ss@..........|\n"
printf "           \  \       |............ss@..........|\n"
printf "            \  '------+...........ss@...........|\n"
printf "             \________ .........................|\n"
printf "                      |.........................|\n"
printf "                     /...........................\\ \n"
printf "                    |.............................|\n"
printf "                       |.......................|\n"
printf "                           |...............|\n"
printf "\nTake yourself a drink and code on!\n"
