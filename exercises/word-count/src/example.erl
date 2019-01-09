-module(example).
-export([count_words/1]).

count_words(S) ->
    lists:foldl(
        fun
            (W, Acc) -> maps:update_with(W, fun (Cnt) -> Cnt+1 end, 1, Acc)
        end,
        #{},
        to_words(S)
    ).



to_words(S) ->
    to_words(S, [], []).

%% end of sentence with nothing in word accumulator
to_words([], [], Acc) ->
    Acc;
%% end of sentence with a word left in the word accumulator
to_words([], WAcc, Acc) ->
    [unquote(lists:reverse(WAcc))|Acc];
%% uppercase letter -> transform to lowercase
to_words([C|S], WAcc, Acc) when C>=$A andalso C=<$Z ->
    to_words(S, [C-$A+$a|WAcc], Acc);
%% lowercase letter, digit, or apostrophe
to_words([C|S], WAcc, Acc) when C>=$a andalso C=<$z orelse C>=$0 andalso C=<$9 orelse C=:=$' ->
    to_words(S, [C|WAcc], Acc);
%% separator (or junk) on empty word accumulator -> just skip
to_words([_|S], [], Acc) ->
    to_words(S, [], Acc);
%% separator (or junk) with non-empty word accumulator -> end of word
to_words([_|S], WAcc, Acc) ->
    to_words(S, [], [unquote(lists:reverse(WAcc))|Acc]).


%% if both the first and last char of a word are apostrophes, remove them
unquote(W=[$', _|_]) ->
    case lists:last(W) of
        $' -> lists:sublist(W, 2, length(W)-2);
        _ -> W
    end;
unquote(W) -> W.
