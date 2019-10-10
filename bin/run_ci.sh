#!/usr/bin/env bash

# set -ex

failures=()

function register_fail () {
  failures+=($1)
}

function run_test () {
  local exercise=${1}
  
  pushd exercises/${exercise}

  printf "\n\n\nRunning tests for %.20s.\n======================================\n" ${exercise} 
  if ! rebar3 eunit; then
    register_fail ${exercise}
  fi

  rm -rf _deps

  popd
}

function run_children () {
  local parent=${1}
  local config=${2}

  local exercises=( $(cat ${config} | jq --raw-output ".exercises[] | select(.unlocked_by == \"${parent}\") | .slug") )
  
  for e in ${exercises[@]}; do
    run_test ${e}
  done
}

function run_core_tests () {
  local exercise=${1}
  local config=${2}

  run_test ${exercise}
  run_children ${exercise} ${config}
}

function main () {
  local config=${1:-config.json}
  local exercises=( $(cat config.json | jq '.exercises[].slug' --raw-output | sort) )

  for e in "${exercises[@]}"; do
    run_test ${e} ${config}
  done
}

main $@

if [[ ${#failures[@]} != 0 ]] ; then
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
