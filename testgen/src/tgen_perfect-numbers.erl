-module('tgen_perfect-numbers').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := #{error := _}, property := Prop, input := #{number := Number}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertError", [
            tgs:raw("_"),
            tgs:call_fun("perfect_numbers:" ++ Property, [
                tgs:value(Number)])])]),

    {ok, Fn, [{Property, ["Number"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{number := Number}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_atom(Exp, latin1)),
            tgs:call_fun("perfect_numbers:" ++ Property, [
                tgs:value(Number)])])]),

    {ok, Fn, [{Property, ["Number"]}]}.
