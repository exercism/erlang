-module(example).

-export([add/3, get/2, get/1, new/0]).


new() ->
    #{}.

add(Name, Grade, School) ->
    Class=maps:get(Grade, School, ordsets:new()),
    School#{Grade => ordsets:add_element(Name, Class)}.

get(Grade, School) ->
    ordsets:to_list(maps:get(Grade, School, ordsets:new())).

get(School) ->
    maps:fold(
        fun (_, Class, Acc) -> Acc++ordsets:to_list(Class) end,
        [],
        School
    ).
