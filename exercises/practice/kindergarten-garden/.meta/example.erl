-module(kindergarten_garden).

-export([plants/2]).

plants(Diagram, Student) ->
    [Row1, Row2] = string:split(Diagram, "\n"),
    Index = position_of(Student),
    PlantCodes = [lists:nth(Index, Row1),
                lists:nth(Index + 1, Row1),
                lists:nth(Index, Row2),
                lists:nth(Index + 1, Row2)],
    lists:map(fun code_to_plant/1, PlantCodes).

position_of(alice) -> 1;
position_of(bob) -> 3;
position_of(charlie) -> 5;
position_of(david) -> 7;
position_of(eve) -> 9;
position_of(fred) -> 11;
position_of(ginny) -> 13;
position_of(harriet) -> 15;
position_of(ileana) -> 17;
position_of(joseph) -> 19;
position_of(kincaid) -> 21;
position_of(larry) -> 23.

code_to_plant($V) -> violets;
code_to_plant($R) -> radishes;
code_to_plant($C) -> clover;
code_to_plant($G) -> grass.
