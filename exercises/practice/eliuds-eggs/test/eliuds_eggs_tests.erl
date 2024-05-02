-module(eliuds_eggs_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_zero_eggs_test_'() ->
    Input = 0,
    Expected = 0,
    {"0 eggs",
     ?_assertEqual(Expected,
                   eliuds_eggs:egg_count(Input))}.

'2_one_egg_test_'() ->
    Input = 16,
    Expected = 1,
    {"1 egg",
     ?_assertEqual(Expected,
                   eliuds_eggs:egg_count(Input))}.

'3_four_eggs_test_'() ->
    Input = 89,
    Expected = 4,
    {"4 eggs",
     ?_assertEqual(Expected,
                   eliuds_eggs:egg_count(Input))}.

'4_thirteen_eggs_test_'() ->
    Input = 2000000000,
    Expected = 13,
    {"13 eggs",
     ?_assertEqual(Expected,
                   eliuds_eggs:egg_count(Input))}.
