-module('tgen_pythagorean-triplet').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{n := Limit}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Exp1 = [{A, B, C} || [A, B, C] <- Exp],
    Exp2 = lists:sort(Exp1),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(Exp2),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("pythagorean_triplet:" ++ Property, [
                    tgs:value(Limit)])])])]),

    {ok, Fn, [{Property, ["Limit"]}]}.
