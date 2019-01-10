-module('tgen_darts').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{x := X, y := Y}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(Exp),
            tgs:call_fun("darts:" ++ Property, [
                tgs:value(X), tgs:value(Y)])])]),

    {ok, Fn, [{Property, ["X", "Y"]}]}.
