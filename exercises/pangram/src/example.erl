-module(example).

-export([is_pangram/1]).

is_pangram(Sentence) ->
    Lewand = "zqxjkvbpygfwmucldrhsnioate",      % least common letter first, most common last

    lists:all(fun (A) -> lists:any(fun (L) -> A == string:to_lower(L) end, Sentence) end, Lewand).
