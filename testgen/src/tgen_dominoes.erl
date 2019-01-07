-module('tgen_dominoes').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{dominoes := Dominoes}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Assert = case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
            tgs:call_fun("dominoes:" ++ Property, [
                tgs:value([{L, R} || [L, R] <- Dominoes])])])]),

    {ok, Fn, [{Property, ["Dominoes"]}]}.
