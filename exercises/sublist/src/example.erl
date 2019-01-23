-module(example).

-export([is_equal/2, is_sublist/2, is_superlist/2, is_unequal/2, relation/2]).


is_equal(L1, L2) ->
    L1=:=L2.

is_sublist(L1, L2) ->
    is_sublist1(L1, L2).

is_superlist(L1, L2) ->
    is_sublist(L2, L1).

is_unequal(L1, L2) ->
    not is_equal(L1, L2).

relation(L, L) ->
    equal;
relation(L1, L2) ->
    case {is_sublist(L1, L2), is_superlist(L1, L2)} of
        {false, false} -> unequal;
        {false, true} -> superlist;
        {true, false} -> sublist
    end.


is_sublist1([], _) -> true;
is_sublist1(L, L) -> true;
is_sublist1(L1, L2) when length(L1)>=length(L2) -> false;
is_sublist1(L1=[E|_], L2=[E|Rest2]) ->
    case L1=:=lists:sublist(L2, length(L1)) of
        true -> true;
        false -> is_sublist1(L1, Rest2)
    end;
is_sublist1(L1, [_|Rest2]) ->
    is_sublist1(L1, Rest2).
