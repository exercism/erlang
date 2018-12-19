%% based on canonical data version 2.3.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/list-ops/canonical-data.json

-module(list_ops_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

append_empty_lists_test() ->
	?assertEqual([],
		     list_ops:append([], [])).

append_empty_list_to_list_test() ->
	?assertEqual([1,2,3,4],
		     list_ops:append([], [1,2,3,4])).

append_non_empty_lists_test() ->
	?assertEqual([1,2,2,3,4,5],
		     list_ops:append([1,2], [2,3,4,5])).

concat_empty_list_test() ->
	?assertEqual([],
		    list_ops:concat([])).

concat_list_of_lists_test() ->
	?assertEqual([1,2,3,4,5,6],
		     list_ops:concat([[1,2], [3], [], [4,5,6]])).

concat_list_of_nested_lists_test() ->
	?assertEqual([[1], [2], [3], [], [4,5,6]],
		     list_ops:concat([[[1], [2]], [[3]], [[]], [[4,5,6]]])).

filter_empty_list_test() ->
	?assertEqual([],
		     list_ops:filter(fun(X) -> X rem 2 =:= 1 end, [])).

filter_non_empty_list_test() ->
	?assertEqual([1,3,5],
		     list_ops:filter(fun(X) -> X rem 2 =:= 1 end, [1,2,3,5])).

length_empty_list_test() ->
	?assertEqual(0,
		     list_ops:length([])).

length_non_empty_list_test() ->
	?assertEqual(4,
		     list_ops:length([1,2,3,4])).

map_empty_list_test() ->
	?assertEqual([],
		     list_ops:map(fun(X) -> X + 1 end, [])).

map_non_empty_list_test() ->
	?assertEqual([2,4,6,8],
		     list_ops:map(fun(X) -> X + 1 end, [1,3,5,7])).

foldl_empty_list_test() ->
	?assertEqual(2,
		     list_ops:foldl(fun(X,Y) -> X * Y end, 2, [])).

foldl_direction_independent_function_applied_to_non_empty_list_test() ->
	?assertEqual(15,
		     list_ops:foldl(fun(X,Y) -> X + Y end, 5, [1,2,3,4])).

foldl_direction_dependent_function_applied_to_non_empty_list_test() ->
	?assertEqual(0,
		     list_ops:foldl(fun(X,Y) -> Y div X end, 5, [2,5])).

foldr_empty_list_test() ->
	?assertEqual(2,
		     list_ops:foldr(fun(X,Y) -> X * Y end, 2, [])).

foldr_direction_independent_function_applied_to_non_empty_list_test() ->
	?assertEqual(15,
		     list_ops:foldr(fun(X,Y) -> X + Y end, 5, [1,2,3,4])).

foldr_direction_dependent_function_applied_to_non_empty_list_test() ->
	?assertEqual(2,
		     list_ops:foldr(fun(X,Y) -> X div Y end, 5, [2,5])).

reverse_empty_list_test() ->
	?assertEqual([],
		     list_ops:reverse([])).

reverse_non_empty_list_test() ->
	?assertEqual([7,5,3,1],
		     list_ops:reverse([1,3,5,7])).
