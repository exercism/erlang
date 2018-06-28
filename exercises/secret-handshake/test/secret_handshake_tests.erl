%% based on canonical data version 1.2.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/secret-handshake/canonical-data.json

-module(secret_handshake_tests).

-define(TESTED_MODULE, (sut(secret_handshake))).
-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

wink_for_1_test() ->
	?assertMatch(["wink"], secret_handshake:commands(1)).

double_blink_for_10_test() ->
	?assertMatch(["double blink"], secret_handshake:commands(2)).

close_your_eyes_for_100_test() ->
	?assertMatch(["close your eyes"], secret_handshake:commands(4)).

jump_for_1000_test() ->
	?assertMatch(["jump"], secret_handshake:commands(8)).

combine_two_actions_test() ->
	?assertMatch(["wink", "double blink"], secret_handshake:commands(3)).

reverse_two_actions_test() ->
	?assertMatch(["double blink", "wink"], secret_handshake:commands(19)).

reversing_one_action_gives_the_same_action_test() ->
	?assertMatch(["jump"], secret_handshake:commands(24)).

reversing_no_actions_gives_no_actions_test() ->
	?assertMatch([], secret_handshake:commands(16)).

all_possible_actions_test() ->
	?assertMatch(["wink", "double blink", "close your eyes", "jump"], secret_handshake:commands(15)).

reverse_all_possible_actions_test() ->
	?assertMatch(["jump", "close your eyes", "double blink", "wink"], secret_handshake:commands(31)).

do_nothing_for_zero_test() ->
	?assertMatch([], secret_handshake:commands(0)).

version_test() ->
	?assertMatch(?TEST_VERSION, secret_handshake:test_version()).
