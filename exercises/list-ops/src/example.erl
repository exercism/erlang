-module(example).

-export([append/2, concat/1, filter/2, length/1, map/2, foldl/3, foldr/3,
	 reverse/1, test_version/0]).

test_version() ->
    1.

append(L1, L2) -> L1 ++ L2.

concat(L) ->
	concat(reverse(L), []).

concat([], Acc) -> Acc;
concat([Curr|Rest], Acc) ->
	concat(Rest, extract_sublist(reverse(Curr), Acc)).

extract_sublist([], Acc) -> Acc;
extract_sublist([Curr|Rest], Acc) -> extract_sublist(Rest, [Curr|Acc]).

filter(Fun, L) ->
	filter(Fun, L, []).

filter(_, [], Acc) -> reverse(Acc);
filter(Fun, [Curr|Rest], Acc) ->
	case Fun(Curr) of
		true -> filter(Fun, Rest, [Curr|Acc]);
		false -> filter(Fun, Rest, Acc)
	end.

length(L) -> length(L, 0).

length([], Acc) -> Acc;
length([_|Rest], Acc) -> length(Rest, Acc + 1).

map(Fun, L) ->
	map(Fun, L, []).

map(_, [], Acc) -> reverse(Acc);
map(Fun, [Curr|Rest], Acc) -> map(Fun, Rest, [Fun(Curr)|Acc]).

foldl(Fun, Start, L) -> reduce_foldl(Fun, L, Start).
reduce_foldl(_, [], Acc) -> Acc;
reduce_foldl(Fun, [Curr|Rest], Acc) ->
	reduce_foldl(Fun, Rest, Fun(Acc, Curr)).

foldr(Fun, Start, L) -> reduce_foldr(Fun, reverse(L), Start).

reduce_foldr(_, [], Acc) -> Acc;
reduce_foldr(Fun, [Curr|Rest], Acc) ->
	reduce_foldr(Fun, Rest, Fun(Curr, Acc)).

reverse(L) ->
	reverse(L, []).

reverse([], Acc) -> Acc;
reverse([Curr|Rest], Acc) -> reverse(Rest, [Curr|Acc]).
