-module(example).

-export([modifier/1, ability/0, character/0]).

-record(?MODULE, {
    strength,
    dexterity,
    constitution,
    intelligence,
    wisdom,
    charisma,
    hitpoints
}).

-export_type([character/0]).
-type character() :: #?MODULE{}.

%% @doc Calculate the ability modifier for a given ability score
-spec modifier(pos_integer()) -> integer().
modifier(Score) ->
    (Score - 10) div 2.

%% @doc Generate a random ability score
-spec ability() -> pos_integer().
ability() ->
    Rolls = [rand:uniform(6) || _ <- lists:seq(1, 4)],

    SortedRolls = lists:sort(Rolls),
    [_ | HighestThree] = SortedRolls,
    lists:sum(HighestThree).

%% @doc Generate a complete character with random ability scores
-spec character() -> character().
character() ->
    Constitution = ability(),

    #?MODULE{
        strength = ability(),
        dexterity = ability(),
        constitution = Constitution,
        intelligence = ability(),
        wisdom = ability(),
        charisma = ability(),
        hitpoints = 10 + modifier(Constitution)
    }.
