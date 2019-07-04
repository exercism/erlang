-module('tgen_bob').

-behaviour(tgen).

-export([
    available/0,
    revision/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

revision() -> 1.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{heyBob := HeyBob}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),
    Expected = binary_to_list(Exp),
    Sentence = binary_to_list(HeyBob),

    Fn = tgs:simple_fun(TestName ++ "_", [
        erl_syntax:tuple([
            tgs:string(Desc),
            tgs:call_macro("_assertMatch", [
                tgs:value(Expected),
                tgs:call_fun("bob:" ++ Property, [
                    tgs:value(Sentence)])])])]),

    {ok, Fn, [{Property, ["String"]}]}.
