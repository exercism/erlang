-module(example).

-export([transpose/1]).


transpose([]) ->
    [];
transpose(Lines) ->
    Lines1=[First|_]=pad(Lines),
    transpose(Lines1, [[] || _ <- lists:seq(1, length(First))], []).

transpose([], AccL, AccR) ->
    lists:map(fun lists:reverse/1, lists:reverse(AccR)++AccL);
transpose([[]|Lines], AccL, AccR) ->
    transpose(Lines, lists:reverse(AccR)++AccL, []);
transpose([[C|Line]|Lines], [TLine|AccL], AccR) ->
    transpose([Line|Lines], AccL, [[C|TLine]|AccR]).

pad(Lines) ->
    [Last|Rest]=lists:reverse(Lines),
    pad(Rest, length(Last), [Last]).

pad([], _, Acc) ->
    Acc;
pad([Line|Lines], Len, Acc) ->
    case length(Line) of
        Len1 when Len1<Len -> pad(Lines, Len, [lists:append(Line, [$\s || _ <- lists:seq(Len1+1, Len)])|Acc]);
        Len1 -> pad(Lines, Len1, [Line|Acc])
    end.
