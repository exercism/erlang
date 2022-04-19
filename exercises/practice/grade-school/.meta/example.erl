-module(example).

-export([add/3, get/2, get/1, new/0]).


new() ->
    {#{}, #{}}.

add(Name, Grade, {Grades, Names}) ->
    case maps:get(Name, Names, undefined) of
        undefined -> 
            Class=maps:get(Grade, Grades, ordsets:new()),
            {Grades#{Grade => ordsets:add_element(Name, Class)}, maps:put(Name, Grade, Names)};
        _OldGrade ->
            {Grades, Names}
    end.

get(Grade, {Grades, _Names}) ->
    ordsets:to_list(maps:get(Grade, Grades, ordsets:new())).

get({_Grades, Names}) ->
    maps:keys(Names).
