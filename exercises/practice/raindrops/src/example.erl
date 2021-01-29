-module(example).

-export([convert/1]).

convert(Number) ->
    case sounds(Number, [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}], []) of
        [] -> integer_to_list(Number);
        Sounds -> lists:flatten(Sounds)
    end.

sounds(_, [], Acc) ->
    lists:reverse(Acc);
sounds(N, [{F, Sound}|Sounds], Acc) when N rem F=:=0 ->
    sounds(N, Sounds, [Sound|Acc]);
sounds(N, [_|Sounds], Acc) ->
    sounds(N, Sounds, Acc).
