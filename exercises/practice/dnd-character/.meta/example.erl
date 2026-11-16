-module(example).
-export([modifier/1, ability/0, character/0]).

%% @doc Calculate the ability modifier for a given ability score
-spec modifier(pos_integer()) -> integer().
modifier(Score) ->
    Diff = Score - 10,
    case Diff < 0 andalso Diff rem 2 /= 0 of
        true -> (Diff div 2) - 1;
        false -> Diff div 2
    end.

%% @doc Generate a random ability score
-spec ability() -> pos_integer().
ability() ->
    Rolls = [rand:uniform(6) || _ <- lists:seq(1, 4)],
    SortedRolls = lists:sort(Rolls),
    [_ | HighestThree] = SortedRolls,
    lists:sum(HighestThree).

%% @doc Generate a complete character with random ability scores
-spec character() -> map().
character() ->
    Constitution = ability(),
    #{
        strength => ability(),
        dexterity => ability(),
        constitution => Constitution,
        intelligence => ability(),
        wisdom => ability(),
        charisma => ability(),
        hitpoints => 10 + modifier(Constitution)
    }.

