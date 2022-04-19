#!/usr/bin/env bash

exercise=${1}

pushd exercises/practice/${exercise}

ln -s $(pwd)/.meta/example.erl src/example.erl

rebar3 eunit

rm -rf _deps _build src/example.erl

popd
