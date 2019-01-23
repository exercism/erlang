-module('tgen_transpose').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{lines := Lines}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:raw("Input="++format_lines(Lines)),
        tgs:raw("Expected="++format_lines(Exp)),
        tgs:call_macro("assertEqual", [
            tgs:raw("Expected"),
            tgs:call_fun("transpose:" ++ Property, [
                tgs:raw("Input")])])]),

    {ok, Fn, [{Property, ["Lines"]}]}.

format_lines(Lines) ->
    Fmt0=["        \"~s\"" || _ <- Lines],
    Fmt1=lists:join(",~n", Fmt0),
    Fmt2=io_lib:format("[~n~s~n    ]", [Fmt1]),
    Fmt3=lists:flatten(Fmt2),
    lists:flatten(io_lib:format(Fmt3, Lines)).
