-module(example).

-export([is_pangram/1, test_version/0]).

is_pangram(Sentence) ->
    Alpha = "abcdefghijklmnopqrstuvwxyz",
    Lower = string:to_lower(Sentence),

    lists:all(fun (A) -> lists:any(fun (L) -> A == L end, Lower) end, Alpha).

test_version() -> 1.
