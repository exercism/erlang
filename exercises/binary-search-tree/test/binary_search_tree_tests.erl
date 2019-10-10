-module(binary_search_tree_tests).

-include_lib("erl_exercism/include/exercism.hrl").

-include_lib("eunit/include/eunit.hrl").

'1_data_is_retained_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:empty(),
				  4),
    ?assertMatch(4, (binary_search_tree:value(T))).

'2_smaller_number_at_left_node_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
							    4),
				  2),
    ?assertMatch(4, (binary_search_tree:value(T))),
    ?assertMatch(2,
		 (binary_search_tree:value(binary_search_tree:left(T)))).

'3_same number_at_left_node_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
							    4),
				  4),
    ?assertMatch(4, (binary_search_tree:value(T))),
    ?assertMatch(4,
		 (binary_search_tree:value(binary_search_tree:left(T)))).

'4_greater_number_at_right_node_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
							    4),
				  5),
    ?assertMatch(4, (binary_search_tree:value(T))),
    ?assertMatch(5,
		 (binary_search_tree:value(binary_search_tree:right(T)))).

'5_can_create_complex_tree_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
																							      4),
																				    2),
																	  6),
														1),
										      3),
							    5),
				  7),
    ?assertMatch(4, (binary_search_tree:value(T))),
    ?assertMatch(2,
		 (binary_search_tree:value(binary_search_tree:left(T)))),
    ?assertMatch(1,
		 (binary_search_tree:value(binary_search_tree:left(binary_search_tree:left(T))))),
    ?assertMatch(3,
		 (binary_search_tree:value(binary_search_tree:right(binary_search_tree:left(T))))),
    ?assertMatch(6,
		 (binary_search_tree:value(binary_search_tree:right(T)))),
    ?assertMatch(5,
		 (binary_search_tree:value(binary_search_tree:left(binary_search_tree:right(T))))),
    ?assertMatch(7,
		 (binary_search_tree:value(binary_search_tree:right(binary_search_tree:right(T))))).

'6_can_sort_single_number_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:empty(),
				  2),
    ?assertMatch([2], (binary_search_tree:to_list(T))).

'7_can_sort_if_second_number_is_smaller_than_first_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
							    2),
				  1),
    ?assertMatch([1, 2], (binary_search_tree:to_list(T))).

'8_can_sort_if_second_number_is_same_as_first_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
							    2),
				  2),
    ?assertMatch([2, 2], (binary_search_tree:to_list(T))).

'9_can_sort_if_second_number_is_greater_than_first_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
							    2),
				  3),
    ?assertMatch([2, 3], (binary_search_tree:to_list(T))).

'10_can_sort_complex_tree_test'() ->
    T =
	binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:insert(binary_search_tree:empty(),
																				    2),
																	  1),
														3),
										      6),
							    7),
				  5),
    ?assertMatch([1, 2, 3, 5, 6, 7],
		 (binary_search_tree:to_list(T))).
