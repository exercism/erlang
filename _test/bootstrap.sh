#!/usr/bin/env bash

set -x

# Make sure there is `~/bin`-folder.
[[ -d ~/bin ]] || mkdir -p ~/bin

# download `rebar3` and make it executable
if [[ ! -f ~/bin/rebar3 ]]; then
    wget -O ~/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3
    chmod a+x ~/bin/rebar3
fi

# fetch configlet and move it into $PATH
./bin/fetch-configlet
cp ./bin/configlet ~/bin/configlet

# install `jq`
apt get -y jq