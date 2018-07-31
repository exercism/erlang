-module(example).

-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1, intersection/2, subset/2,
	 union/2, test_version/0]).

-record(set, {s = #{}}).

add(Elem, #set{s = S}) ->
	#set{s = maps:put(Elem, true, S)}.

contains(Elem, #set{s = S}) ->
	maps:is_key(Elem, S).

difference(#set{s = S1}, #set{s = S2}) ->
	#set{s = lists:foldl(
		fun (E, S) -> maps:remove(E, S) end, S1, maps:keys(S2))}.

disjoint(Set1, Set2) ->
	empty(intersection(Set1, Set2)).

empty(#set{s = S}) ->
	maps:size(S) =:= 0.

equal(Set1, Set2) ->
	Set1 == Set2.

from_list(List) ->
	#set{s = from_list(List, #{})}.

from_list([], Acc) -> Acc;
from_list([E|List], Acc) ->
	from_list(List, maps:put(E, true, Acc)).

intersection(#set{s = S1}, #set{s = S2}) ->
	#set{s = lists:foldl(
		fun (E, S) ->
			case maps:is_key(E, S2) of
				true -> maps:put(E, true, S);
				false -> S
			end
		end, #{}, maps:keys(S1))}.

subset(#set{s = S1}, #set{s = S2}) ->
	lists:all(
		fun (E) -> maps:is_key(E, S2) end,
		maps:keys(S1)).

union(#set{s = S1}, #set{s = S2}) ->
	#set{s = maps:merge(S1, S2)}.

test_version() -> 2.
