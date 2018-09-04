%% based on canonical data version 2.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/dominoes/canonical-data.json

-module(dominoes_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

empty_input_test() ->
	?assert(dominoes:can_chain([])).

singleton_test() ->
	?assert(dominoes:can_chain([{1,1}])).

singleton_unchainable_test() ->
	?assertNot(dominoes:can_chain([{1,2}])).

three_elements_test() ->
	?assert(dominoes:can_chain([{1,2}, {3,1}, {2,3}])).

three_elements_reverse_dominoes_test() ->
	?assert(dominoes:can_chain([{1,2}, {1,3}, {2,3}])).

three_elements_unchainable_test() ->
	?assertNot(dominoes:can_chain([{1,2}, {4,1}, {2,3}])).

disconnected_simple_test() ->
	?assertNot(dominoes:can_chain([{1,1}, {2,2}])).

disconnected_double_loop_test() ->
	?assertNot(dominoes:can_chain([{1,2}, {2,1}, {3,4}, {4,3}])).

disconnected_singleisolated_test() ->
	?assertNot(dominoes:can_chain([{1,2}, {2,3}, {3,1}, {4,4}])).

backtrack_test() ->
	?assert(dominoes:can_chain([{1,2}, {2,3}, {3,1}, {2,4}, {2,4}])).

separate_loops_test() ->
	?assert(dominoes:can_chain([{1,2}, {2,3}, {3,1}, {1,1}, {2,2}, {3,3}])).

nine_elements_test() ->
	?assert(dominoes:can_chain([{1,2}, {5,3}, {3,1}, {1,2}, {2,4}, {1,6}, {2,3}, {3,4}, {5,6}])).
