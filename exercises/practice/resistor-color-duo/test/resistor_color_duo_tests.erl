-module(resistor_color_duo_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_brown_and_black_test_'() ->
    {"brown and black",
     ?_assertMatch(10, resistor_color_duo:value([brown, black]))}.

'2_blue_and_grey_test_'() ->
    {"blue and grey",
     ?_assertMatch(68, resistor_color_duo:value([blue, grey]))}.

'3_yellow_and_violet_test_'() ->
    {"yellow and violet",
     ?_assertMatch(47, resistor_color_duo:value([yellow, violet]))}.

'4_white_and_red_test_'() ->
    {"white and red",
     ?_assertMatch(92, resistor_color_duo:value([white, red]))}.

'5_orange_and_orange_test_'() ->
    {"orange and orange",
     ?_assertMatch(33, resistor_color_duo:value([orange, orange]))}.

'6_ignore_additional_colors_test_'() ->
    {"ignore additional colors",
     ?_assertMatch(51, resistor_color_duo:value([green, brown, orange]))}.

'7_black_and_brown_one_digit_test_'() ->
    {"black and brown, one-digit",
     ?_assertMatch(1, resistor_color_duo:value([black, brown]))}.
