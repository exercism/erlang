-module(resistor_color_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_color_codes_black_test_'() ->
    Input = black,
    Expected = 0,
    {"black",
     ?_assertEqual(Expected,
                   resistor_color:color_code(Input))}.

'2_color_codes_white_test_'() ->
    Input = white,
    Expected = 9,
    {"white",
     ?_assertEqual(Expected,
                   resistor_color:color_code(Input))}.

'3_color_codes_orange_test_'() ->
    Input = orange,
    Expected = 3,
    {"orange",
     ?_assertEqual(Expected,
                   resistor_color:color_code(Input))}.

'4_colors_test_'() ->
    {"colors",
     ?_assertEqual([black, brown, red, orange, yellow, green, blue, violet, grey, white],
                   resistor_color:colors())}.
