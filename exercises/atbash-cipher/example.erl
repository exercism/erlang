-module(atbash_cipher).

-export([encode/1, decode/1]).

encode(String) ->
    join(chunk(convert(String), 5)).

decode(String) ->
    convert(String).

%% Basic conversion routines
convert(String) ->
    lists:filtermap(fun encode_char/1, String).

encode_char(C) when C >= $A, C =< $Z ->
    %% shift to lower-case
    {true, $Z - C + $a};
encode_char(C) when C >= $a, C =< $z ->
    {true, $z - C + $a};
encode_char(C) when C >= $0, C =< $9 ->
    {true, C};
encode_char(_C) ->
    false.
%%

%% Functions for converting to word chunks of 5 characters
join(Lists) ->
    string:join(Lists, " ").

chunk(String, N) ->
    lists:reverse(chunk(
                    lists:split(min(length(String), N),
                                String), [], N)).

chunk({Last, []}, Accum, _N) ->
    [Last] ++ Accum;
chunk({Next, Remainder}, Accum, N) ->
    chunk(
      lists:split(min(length(Remainder), N),
                  Remainder), [Next] ++ Accum, N).
%%
