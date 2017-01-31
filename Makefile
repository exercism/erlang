EXERCISE_FOLDERS = \
	$(sort $(shell find exercises -maxdepth 1 -mindepth 1 -type d))

SHELL = bash

test: $(EXERCISE_FOLDERS:%=%_test)

%_test:
	@if [[ ! -f $*/rebar.conf ]]; then \
		echo "$(*:exercises/%_test=%) not converted to rebar3"; \
		false; \
	fi
	@echo "running tests for $(*:exercises/%_test=%)"
	@cd $*; rebar3 eunit

