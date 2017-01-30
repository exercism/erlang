EXERCISE_FOLDERS = $(shell find exercises -maxdepth 1 -mindepth 1 -type d)

test: $(EXERCISE_FOLDERS:%=%_test)

%_test:
	cd $*; rebar3 eunit
