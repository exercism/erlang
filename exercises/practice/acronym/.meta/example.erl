-module(example).

-export([abbreviate/1]).

abbreviate(Phrase) ->
    abbreviate(Phrase, []).

abbreviate([First, Second | Rest], Acc) when First >= $A, First =< $Z, Second >= $A, Second =< $Z ->
    abbreviate([First | Rest], Acc);
abbreviate([First | Rest], Acc) when First >= $A, First =< $Z ->
    abbreviate(Rest, [First | Acc]);
abbreviate([First, Second | Rest], Acc) when First == $\s orelse First == $- orelse First == $_,
                                             Second /= $\s, Second /= $-, Second /= $_->
    abbreviate(Rest, [Second | Acc]);
abbreviate([_ | Rest], Acc) ->
    abbreviate(Rest, Acc);
abbreviate([], Acc) ->
    string:uppercase(lists:reverse(Acc)).

