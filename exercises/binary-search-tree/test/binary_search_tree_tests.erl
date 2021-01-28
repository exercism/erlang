%% These tests were manually created from canonical data, version 1.0.0
%% (https://github.com/exercism/problem-specifications/blob/d5a4db7d282b16110e376f0ccfa91c80967b8b40/exercises/binary-search-tree/canonical-data.json)
-module(binary_search_tree_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

'1_data_is_retained_test'() ->
  T = binary_search_tree:insert(binary_search_tree:empty(), 4),
  ?assertMatch(4, binary_search_tree:data(T)).

'2_smaller_number_at_left_node_test'() ->  
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 4),
  T2 = binary_search_tree:insert(T1, 2),
  ?assertMatch(4, binary_search_tree:data(T2)),
  ?assertMatch(2, binary_search_tree:data(binary_search_tree:left(T2))).

'3_same number_at_left_node_test'() ->
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 4),
  T2 = binary_search_tree:insert(T1, 4),
  ?assertMatch(4, binary_search_tree:data(T2)),
  ?assertMatch(4, binary_search_tree:data(binary_search_tree:left(T2))).

'4_greater_number_at_right_node_test'() ->
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 4),
  T2 = binary_search_tree:insert(T1, 5),
  ?assertMatch(4, binary_search_tree:data(T2)),
  ?assertMatch(5, binary_search_tree:data(binary_search_tree:right(T2))).

'5_can_create_complex_tree_test'() ->
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 4),
  T2 = binary_search_tree:insert(T1, 2),
  T3 = binary_search_tree:insert(T2, 6),
  T4 = binary_search_tree:insert(T3, 1),
  T5 = binary_search_tree:insert(T4, 3),
  T6 = binary_search_tree:insert(T5, 5),
  T7 = binary_search_tree:insert(T6, 7),
  ?assertMatch(4, binary_search_tree:data(T7)),
  ?assertMatch(2, binary_search_tree:data(binary_search_tree:left(T7))),
  ?assertMatch(1, binary_search_tree:data(binary_search_tree:left(binary_search_tree:left(T7)))),
  ?assertMatch(3, binary_search_tree:data(binary_search_tree:right(binary_search_tree:left(T7)))),
  ?assertMatch(6, binary_search_tree:data(binary_search_tree:right(T7))),
  ?assertMatch(5, binary_search_tree:data(binary_search_tree:left(binary_search_tree:right(T7)))),
  ?assertMatch(7, binary_search_tree:data(binary_search_tree:right(binary_search_tree:right(T7)))).

'6_can_sort_single_number_test'() ->
  T = binary_search_tree:insert(binary_search_tree:empty(), 2),
  ?assertMatch([2], binary_search_tree:sorted_data(T)).

'7_can_sort_if_second_number_is_smaller_than_first_test'() ->
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 2),
  T2 = binary_search_tree:insert(T1, 1),
  ?assertMatch([1, 2], binary_search_tree:sorted_data(T2)).

'8_can_sort_if_second_number_is_same_as_first_test'() ->
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 2),
  T2 = binary_search_tree:insert(T1, 2),
  ?assertMatch([2, 2], binary_search_tree:sorted_data(T2)).

'9_can_sort_if_second_number_is_greater_than_first_test'() ->
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 2),
  T2 = binary_search_tree:insert(T1, 3),
  ?assertMatch([2, 3], binary_search_tree:sorted_data(T2)).

'10_can_sort_complex_tree_test'() ->
  T0 = binary_search_tree:empty(),
  T1 = binary_search_tree:insert(T0, 2),
  T2 = binary_search_tree:insert(T1, 1),
  T3 = binary_search_tree:insert(T2, 3),
  T4 = binary_search_tree:insert(T3, 6),
  T5 = binary_search_tree:insert(T4, 7),
  T6 = binary_search_tree:insert(T5, 5),
  ?assertMatch([1, 2, 3, 5, 6, 7], binary_search_tree:sorted_data(T6)).
