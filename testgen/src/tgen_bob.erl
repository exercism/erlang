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

generate_test(F = #{description := Desc, expected := Exp, property := Prop, input := #{heyBob := HeyBob}}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),
    Expected = binary_to_list(Exp),
    Sentence = binary_to_list(HeyBob),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Expected),
            tgs:call_fun("bob:" ++ Property, [
                tgs:value(Sentence)])])]),

    {ok, Fn, [{Property, ["String"]}]}.
