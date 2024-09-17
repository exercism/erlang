-module(square_root_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_root_of_1_test_'() ->
    {"root of l",
     ?_assertMatch(1, square_root:square_root(1))}.

'2_root_of_4_test_'() ->
    {"root of 4",
     ?_assertMatch(2, square_root:square_root(4))}.

'3_root_of_25_test_'() ->
    {"root of 25",
     ?_assertMatch(5, square_root:square_root(25))}.

'4_root_of_81_test_'() ->
    {"root of 81",
     ?_assertMatch(9, square_root:square_root(81))}.

'5_root_of_196_test_'() ->
    {"root of 196",
     ?_assertMatch(14, square_root:square_root(196))}.

'6_root_of_65025_test_'() ->
    {"root of 65025",
     ?_assertMatch(255, square_root:square_root(65025))}.
