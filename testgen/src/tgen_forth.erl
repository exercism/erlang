-module('tgen_forth').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := #{error := _}, property := Prop, input := #{instructions := Instructions}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertError", [
            tgs:raw("_"),
            tgs:call_fun("forth:" ++ Property, [
                tgs:value([binary_to_list(I) || I <- Instructions])])])]),

    {ok, Fn, [{Property, ["Instructions"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{instructions := Instructions}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(Exp),
            tgs:call_fun("forth:" ++ Property, [
                tgs:value([binary_to_list(I) || I <- Instructions])])])]),

    {ok, Fn, [{Property, ["Instructions"]}]}.
