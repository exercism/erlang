-module(knapsack_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

'1_no_items_test_'() ->
    {"no items",
     ?_assertEqual(0, knapsack:maximum_value([], 100))}.

'2_one_item_too_heavy_test_'() ->
    {"one item too heavy",
     ?_assertEqual(0, knapsack:maximum_value([knapsack:item(100, 1)], 10))}.

'3_five_items_cannot_be_greedy_by_weight_test_'() ->
    {"five items (cannot be greedy by weight)",
     ?_assertEqual(21, knapsack:maximum_value([
          knapsack:item(2,  5 ),
          knapsack:item(2,  5 ),
          knapsack:item(2,  5 ),
          knapsack:item(2,  5 ),
          knapsack:item(10,  21)
     ], 10))}.

'4_five_items_cannot_be_greedy_by_value_test_'() ->
    {"five items (cannot be greedy by value)",
     ?_assertEqual(80, knapsack:maximum_value([
          knapsack:item(2,  20 ),
          knapsack:item(2,   20),
          knapsack:item(2,  20 ),
          knapsack:item(2,  20 ),
          knapsack:item(10,  50)
     ], 10))}.

'5_example_knapsack_test_'() ->
    {"example knapsack",
     ?_assertEqual(90, knapsack:maximum_value([
        knapsack:item(5, 10),
        knapsack:item(4, 40),
        knapsack:item(6, 30),
        knapsack:item(4, 50)
     ], 10))}.

'6_items_test_'() ->
    {"8 items",
     ?_assertEqual(900, knapsack:maximum_value([
        knapsack:item(25, 350),
        knapsack:item(35, 400),
        knapsack:item(45, 450),
        knapsack:item(5, 20),
        knapsack:item(25, 70),
        knapsack:item(3, 8),
        knapsack:item(2, 5),
        knapsack:item(2, 5)
     ], 104))}.

'7_15_items_test_'() ->
    {"15 items",
     ?_assertEqual(1458, knapsack:maximum_value([
        knapsack:item(70, 135),
        knapsack:item(73, 139),
        knapsack:item(77, 149),
        knapsack:item(80, 150),
        knapsack:item(82, 156),
        knapsack:item(87, 163),
        knapsack:item(90, 173),
        knapsack:item(94, 184),
        knapsack:item(98, 192),
        knapsack:item(106, 201),
        knapsack:item(110, 210),
        knapsack:item(113, 214),
        knapsack:item(115, 221),
        knapsack:item(118, 229),
        knapsack:item(120, 240)
     ], 750))}.
