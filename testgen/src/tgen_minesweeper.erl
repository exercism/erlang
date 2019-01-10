-module('tgen_minesweeper').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{minefield := Minefield}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:raw("Input="++format_lines(Minefield)),
        tgs:raw("Expected="++format_lines(Exp)),
        tgs:call_macro("assertMatch", [
            tgs:raw("Expected"),
            tgs:call_fun("minesweeper:" ++ Property, [
                tgs:raw("Input")])])]),

    {ok, Fn, [{Property, ["Minefield"]}]}.

%% align input/expectation lines to make a nice board
format_lines(Lines) ->
    Fmt0=["        \"~s\"" || _ <- Lines],
    Fmt1=lists:join(",~n", Fmt0),
    Fmt2=io_lib:format("[~n~s~n    ]", [Fmt1]),
    Fmt3=lists:flatten(Fmt2),
    lists:flatten(io_lib:format(Fmt3, Lines)).
