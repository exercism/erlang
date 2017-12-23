-module(example).

-export([is_pangram/1, test_version/0]).

is_pangram(Sentence) ->
    Lewand = "zqxjkvbpygfwmucldrhsnioate",      % least common letter first, most common last

    lists:all(fun (A) -> lists:any(fun (L) -> A == string:to_lower(L) end, Sentence) end, Lewand).

test_version() -> 1.
