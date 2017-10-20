-module(tgen).

-export([
    check/1
]).

-callback available() -> boolean().

-spec check(string()) -> {true, atom()} | false.
check(Name) ->
    Module = list_to_atom("tgen_" ++ Name),
    try Module:available() of
        true -> {true, Module};
        false -> false
    catch
        _:_ -> false
    end.
