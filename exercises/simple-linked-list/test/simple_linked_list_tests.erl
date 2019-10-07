-module(simple_linked_list_tests).

-include_lib("erl_exercism/include/exercism.hrl").

-include_lib("eunit/include/eunit.hrl").

'1_value_reflects_constructor_arg_test'() ->
    L = simple_linked_list:empty(),
    L2 = simple_linked_list:cons(2, L),
    ?assertMatch(2, (simple_linked_list:head(L2))).

'2_new_lists_should_have_length_0_test'() ->
    L = simple_linked_list:empty(),
    ?assertMatch(0, (simple_linked_list:count(L))).

'3_adding_a_element_increments_length_test'() ->
    L = simple_linked_list:empty(),
    L2 = simple_linked_list:cons(1, L),
    ?assertMatch(1, (simple_linked_list:count(L2))).

'4_adding_two_elements_increments_twice_test'() ->
    L = simple_linked_list:empty(),
    L2 = simple_linked_list:cons(1, L),
    L3 = simple_linked_list:cons(2, L2),
    ?assertMatch(2, (simple_linked_list:count(L3))).

'5_new_lists_have_a_null_head_element_test'() ->
    L = simple_linked_list:empty(),
    ?assertError(_, (simple_linked_list:head(L))).

'6_adding_an_element_to_an_empty_list_sets_the_head_element_test'() ->
    L = simple_linked_list:empty(),
    L2 = simple_linked_list:cons(1, L),
    ?assertMatch(1, (simple_linked_list:head(L2))).

'7_adding_a_second_element_updates_the_head_element_test'() ->
    L = simple_linked_list:empty(),
    L2 = simple_linked_list:cons(1, L),
    L3 = simple_linked_list:cons(2, L2),
    ?assertMatch(2, (simple_linked_list:head(L3))).

'8_can_get_the_next_element_from_the_head_test'() ->
    L = simple_linked_list:empty(),
    L2 = simple_linked_list:cons(1, L),
    L3 = simple_linked_list:cons(2, L2),
    L4 = simple_linked_list:tail(L3),
    ?assertMatch(1, (simple_linked_list:head(L4))).

'9_with_correct_length_test'() ->
    A = array:from_list(lists:seq(1, 10)),
    L = simple_linked_list:from_array(A),
    ?assertMatch(10, (simple_linked_list:count(L))).

'10_can_traverse_the_list_test'() ->
    A = array:from_list(lists:seq(1, 10)),
    L = simple_linked_list:from_array(A),
    Elt =
	simple_linked_list:head(simple_linked_list:tail(simple_linked_list:tail(simple_linked_list:tail(L)))),
    ?assertMatch(4, Elt).

'11_can_convert_to_an_array_test'() ->
    L = simple_linked_list:empty(),
    L2 = simple_linked_list:cons(1, L),
    A = simple_linked_list:to_array(L2),
    A2 = array:from_list([1]),
    ?assertMatch(A, A2).

'12_can_be_reversed_test'() ->
    L = simple_linked_list:cons(2,
				simple_linked_list:cons(1,
							simple_linked_list:empty())),
    L2 = simple_linked_list:cons(1,
				 simple_linked_list:cons(2,
							 simple_linked_list:empty())),
    ?assertMatch(L, (simple_linked_list:reverse(L2))).

'13_can_reverse_with_many_elements_test'() ->
    A = array:from_list(lists:seq(1, 10)),
    A2 = array:from_list(lists:reverse(lists:seq(1, 10))),
    L =
	simple_linked_list:reverse(simple_linked_list:from_array(A)),
    L2 = simple_linked_list:from_array(A2),
    ?assertMatch(L, L2).

'14_can_reverse_a_reversal_test'() ->
    A = array:from_list(lists:seq(1, 10)),
    L =
	simple_linked_list:reverse(simple_linked_list:from_array(A)),
    L2 =
	simple_linked_list:reverse(simple_linked_list:reverse(L)),
    ?assertMatch(L, L2).
