EXERCISE_FOLDERS = \
	$(sort $(shell find exercises -maxdepth 1 -mindepth 1 -type d))

SHELL = bash

REBAR3 = rebar3

test: $(EXERCISE_FOLDERS:%=%_test)

%_test:
	@if [[ ! -f $*/rebar.config ]]; then \
		echo "$(*:exercises/%_test=%) not converted to rebar3"; \
		false; \
	fi
	@echo "running tests for $(*:exercises/%_test=%)"
	@cd $*; $(REBAR3) eunit

run_tesgen: testgen/_build/default/bin/testgen
	$< generate all
.PHONY: run_testgen

testgen/_build/default/bin/testgen:
	cd testgen && rebar3 escriptize
.PHONY: testgen/_build/default/bin/testgen
