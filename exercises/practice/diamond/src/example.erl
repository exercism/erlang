-module(example).

-export([rows/1]).


rows([Letter]) ->
    make_diamond(Letter).

make_diamond(C) when C>=$A, C=<$Z ->
    make_diamond(C, 0, 2*(C-$A)-1, []);
make_diamond(C) when C>=$a, C=<$z ->
    make_diamond(C-$a+$A).

make_diamond(C, LR, M, Acc) when M=<0 ->
   Line=make_line(C, LR, M),
   Acc1=[Line|Acc],
   [_|Lower]=lists:reverse(Acc1),
   Acc1++Lower;
make_diamond(C, LR, M, Acc) ->
   Line=make_line(C, LR, M),
   make_diamond(C-1, LR+1, M-2, [Line|Acc]).

make_line(C, LR, M) when M>0 ->
   lists:flatten([make_spaces(LR), C, make_spaces(M), C, make_spaces(LR)]);
make_line(C, LR, _) ->
   lists:flatten([make_spaces(LR), C, make_spaces(LR)]).

make_spaces(0) ->
    "";
make_spaces(N) ->
    [$\s || _ <- lists:seq(1, N)].
