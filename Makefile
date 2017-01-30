EXERCISE_FOLDERS = $(sort $(shell find exercises -maxdepth 1 -mindepth 1 -type d))

SHELL = bash

test: $(EXERCISE_FOLDERS:%=%_test)

%_test:
	[[ -f $*/rebar.conf ]]
	cd $*; rebar3 eunit

