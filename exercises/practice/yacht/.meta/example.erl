-module(example).

-export([score/2]).

score(Dice, ones) ->
    1 * tally(Dice, 1);
score(Dice, twos) ->
    2 * tally(Dice, 2);
score(Dice, threes) ->
    3 * tally(Dice, 3);
score(Dice, fours) ->
    4 * tally(Dice, 4);
score(Dice, fives) ->
    5 * tally(Dice, 5);
score(Dice, sixes) ->
    6 * tally(Dice, 6);
score(Dice, full_house) ->
    case lists:sort(maps:values(frequency(Dice))) of
        [2, 3] -> lists:sum(Dice);
        _ -> 0
    end;
score(Dice, four_of_a_kind) ->
    case maps:keys(maps:filter(fun(_K, V) -> V >= 4 end, frequency(Dice))) of
        [K | _ ] -> K * 4;
        _ -> 0
    end;
score(Dice, little_straight) ->
    case lists:sort(Dice) of
        [1, 2, 3, 4, 5] -> 30;
        _ -> 0
    end;
score(Dice, big_straight) ->
    case lists:sort(Dice) of
        [2, 3, 4, 5, 6] -> 30;
        _ -> 0
    end;
score(Dice, choice) ->
    lists:sum(Dice);
score(Dice, yacht) ->
    case length(lists:usort(Dice)) of
        1 -> 50;
        _ -> 0
    end;
score(_Dice, _Category) ->
    0.

tally(Dice, Number) -> 
    tally(Dice, Number, 0).

tally([], _Number, Acc) ->
    Acc;
tally([Number|T], Number, Acc) ->
    tally(T, Number, Acc + 1);
tally([_|T], Number, Acc) ->
    tally(T, Number, Acc).

frequency(Dice) ->
    frequency(Dice, #{}).

frequency([], Acc) ->
    Acc;
frequency([H|T], Acc) ->
    frequency(T, maps:update_with(H, fun(X) -> X + 1 end, 1, Acc)).
