-module(example).

-export([add/3, get/2, get/1, new/0]).


new() ->
    {#{}, ordsets:new()}.

add(Name, Grade, {Grades, Names}) ->
    case ordsets:is_element(Name, Names) of
        false -> 
            Class=maps:get(Grade, Grades, ordsets:new()),
            {Grades#{Grade => ordsets:add_element(Name, Class)}, ordsets:add_element(Name, Names)};
        true ->
            {Grades, Names}
    end.

get(Grade, {Grades, _Names}) ->
    ordsets:to_list(maps:get(Grade, Grades, ordsets:new())).

get({_Grades, Names}) ->
    ordsets:to_list(Names).
