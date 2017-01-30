#!/bin/bash
set -x
set -e
# We can use the default Travis VM for Erlang now, leave this here
# just as a replacement for the install script.
echo $PATH

[[ -d ~/bin ]] || mkdir -p ~/bin

if [[ ! -f ~/bin/rebar3 ]]; then
    wget -O ~/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3
    chmod a+x ~/bin/rebar3
fi

