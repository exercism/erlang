-module(flower_field_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_no_rows_test_'() ->
    Input=[

    ],
    Expected=[

    ],
    {"no rows",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'2_no_columns_test_'() ->
    Input=[
        ""
    ],
    Expected=[
        ""
    ],
    {"no columns",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'3_no_flowers_test_'() ->
    Input=[
        "   ",
        "   ",
        "   "
    ],
    Expected=[
        "   ",
        "   ",
        "   "
    ],
    {"no flowers",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'4_garden_full_of_flowers_test_'() ->
    Input=[
        "***",
        "***",
        "***"
    ],
    Expected=[
        "***",
        "***",
        "***"
    ],
    {"flowerfield with only flowers",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'5_flower_surrounded_by_spaces_test_'() ->
    Input=[
        "   ",
        " * ",
        "   "
    ],
    Expected=[
        "111",
        "1*1",
        "111"
    ],
    {"flower surrounded by spaces",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'6_space_surrounded_by_flowers_test_'() ->
    Input=[
        "***",
        "* *",
        "***"
    ],
    Expected=[
        "***",
        "*8*",
        "***"
    ],
    {"space surrounded by flowers",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'7_horizontal_line_test_'() ->
    Input=[
        " * * "
    ],
    Expected=[
        "1*2*1"
    ],
    {"horizontal line",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'8_horizontal_line_flowers_at_edges_test_'() ->
    Input=[
        "*   *"
    ],
    Expected=[
        "*1 1*"
    ],
    {"horizontal line, flowers at edges",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'9_vertical_line_test_'() ->
    Input=[
        " ",
        "*",
        " ",
        "*",
        " "
    ],
    Expected=[
        "1",
        "*",
        "2",
        "*",
        "1"
    ],
    {"vertical line",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'10_vertical_line_flowers_at_edges_test_'() ->
    Input=[
        "*",
        " ",
        " ",
        " ",
        "*"
    ],
    Expected=[
        "*",
        "1",
        " ",
        "1",
        "*"
    ],
    {"vertical line, flowers at edges",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'11_cross_test_'() ->
    Input=[
        "  *  ",
        "  *  ",
        "*****",
        "  *  ",
        "  *  "
    ],
    Expected=[
        " 2*2 ",
        "25*52",
        "*****",
        "25*52",
        " 2*2 "
    ],
    {"cross",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.

'12_large_flowerfield_test_'() ->
    Input=[
        " *  * ",
        "  *   ",
        "    * ",
        "   * *",
        " *  * ",
        "      "
    ],
    Expected=[
        "1*22*1",
        "12*322",
        " 123*2",
        "112*4*",
        "1*22*2",
        "111111"
    ],
    {"large garden",
     ?_assertMatch(Expected, flower_field:annotate(Input))}.
