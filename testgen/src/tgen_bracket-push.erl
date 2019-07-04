-module('tgen_bracket-push').

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

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{value := Val}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Assert=case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
            tgs:call_fun("bracket_push:" ++ Property, [
                tgs:value(binary_to_list(Val))])])]),

    {ok, Fn, [{Property, ["String"]}]}.
