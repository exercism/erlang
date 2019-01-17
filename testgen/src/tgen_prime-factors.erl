-module('tgen_prime-factors').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{value := Value}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:call_fun("lists:sort", [tgs:value(Exp)]),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("prime_factors:" ++ Property, [
                    tgs:value(Value)])])])]),

    {ok, Fn, [{Property, ["Value"]}]}.
