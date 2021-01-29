-module(example).

-export([can_attack/2]).


can_attack({X, _}, {X, _}) -> true;
can_attack({_, Y}, {_, Y}) -> true;
can_attack({WX, WY}, {BX, BY}) -> abs(WX-BX)=:=abs(WY-BY).
