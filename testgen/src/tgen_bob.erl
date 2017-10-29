-module('tgen_bob').

-behaviour(tgen).

-export([
    available/0,
    version/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

version() -> 2.

generate_test(F = #{description := Desc, expected := Exp, property := Prop, input := Input}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),
    Expected = binary_to_list(Exp),
    Sentence = binary_to_list(Input),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Expected),
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:value(Sentence)])])]),

    {ok, Fn, [{Property, ["String"]}]}.
