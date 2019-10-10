-module(simple_linked_list_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").


'1_new_lists_should_have_length_0_test'() ->
  L = simple_linked_list:empty(),
  ?assertMatch(0, (simple_linked_list:count(L))).

'2_adding_a_element_increments_length_test'() ->
  L = simple_linked_list:empty(),
  L2 = simple_linked_list:cons(1, L),
  ?assertMatch(1, (simple_linked_list:count(L2))),
  ?assertMatch(1, (simple_linked_list:head(L2))).

'3_adding_two_elements_increments_twice_test'() ->
  L = simple_linked_list:empty(),
  L2 = simple_linked_list:cons(1, L),
  L3 = simple_linked_list:cons(2, L2),
  ?assertMatch(2, (simple_linked_list:count(L3))),
  ?assertMatch(2, (simple_linked_list:head(L3))).

'4_new_lists_have_a_null_head_element_test'() ->
  L = simple_linked_list:empty(),
  ?assertError(_, (simple_linked_list:head(L))).

'5_an_element_added_to_an_empty_list_becomes_the_head_test'() ->
  L = simple_linked_list:empty(),
  L2 = simple_linked_list:cons(1, L),
  ?assertMatch(1, (simple_linked_list:head(L2))).

'6_adding_a_second_element_changes_the_head_test'() ->
  L = simple_linked_list:empty(),
  L2 = simple_linked_list:cons(1, L),
  L3 = simple_linked_list:cons(2, L2),
  ?assertMatch(2, (simple_linked_list:head(L3))).

'7_can_get_the_next_element_from_the_head_test'() ->
  L = simple_linked_list:empty(),
  L2 = simple_linked_list:cons(1, L),
  L3 = simple_linked_list:cons(2, L2),
  L4 = simple_linked_list:tail(L3),
  ?assertMatch(1, (simple_linked_list:head(L4))).

'8_from_native_list_preserves_empty_list_length_test'() ->
  L = simple_linked_list:from_native_list([]),
  ?assertMatch(0, (simple_linked_list:count(L))).

'9_from_native_list_preserves_list_length_test'() ->
  NL = lists:seq(1, 10),
  L = simple_linked_list:from_native_list(NL),
  ?assertMatch(10, (simple_linked_list:count(L))).

'10_can_traverse_the_list_test'() ->
  NL = lists:seq(1, 10),
  L = simple_linked_list:from_native_list(NL),
  Elt = simple_linked_list:head(simple_linked_list:tail(
    simple_linked_list:tail(simple_linked_list:tail(L)))),
  ?assertMatch(4, Elt).

'11_can_convert_empty_list_to_a_native_list_test'() ->
  L = simple_linked_list:empty(),
  NL = simple_linked_list:to_native_list(L),
  ?assertMatch(NL, []).

'12_can_convert_to_a_non_empty_native_list_test'() ->
  L = simple_linked_list:cons(2, simple_linked_list:cons(1, simple_linked_list:empty())),
  NL = simple_linked_list:to_native_list(L),
  ?assertMatch(NL, [2, 1]).

'13_can_convert_from_an_empty_native_list_test'() ->
  L = simple_linked_list:from_native_list([]),
  ?assertMatch(L, simple_linked_list:empty()).

'14_can_convert_from_a_non_empty_native_list_test'() ->
  L = simple_linked_list:cons(2, simple_linked_list:cons(1, simple_linked_list:empty())),
  L2 = simple_linked_list:from_native_list([2,1]),
  ?assertMatch(L, L2).

'15_converting_to_and_from_a_native_list_is_identity_test'() ->
  L = simple_linked_list:cons(2, simple_linked_list:cons(1, simple_linked_list:empty())),
  L2 = simple_linked_list:from_native_list(simple_linked_list:to_native_list(L)),
  L3 = [1,2],
  L4 = simple_linked_list:to_native_list(simple_linked_list:from_native_list(L3)),
  ?assertMatch(L, L2),
  ?assertMatch(L3, L4).

'16_empty_list_can_be_reversed_test'() ->
  L = simple_linked_list:empty(),
  ?assertMatch(L, (simple_linked_list:reverse(L))).

'17_non_empty_list_can_be_reversed_test'() ->
  L = simple_linked_list:from_native_list([1,2,3]),
  L2 = simple_linked_list:from_native_list([3,2,1]),
  ?assertMatch(L, (simple_linked_list:reverse(L2))).

'18_can_reverse_a_reversal_test'() ->
  NL = lists:seq(1, 10),
  L = simple_linked_list:reverse(simple_linked_list:from_native_list(NL)),
  L2 = simple_linked_list:reverse(simple_linked_list:reverse(L)),
  ?assertMatch(L, L2).
