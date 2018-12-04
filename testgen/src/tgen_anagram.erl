-module('tgen_anagram').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{subject := Subject, candidates := Candidates}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Candidates1=[binary_to_list(V) || V <- Candidates],
    Exp1=lists:sort([binary_to_list(V) || V <- Exp]),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp1),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("anagram:" ++ Property, [
                    tgs:value(binary_to_list(Subject)),
                    tgs:value(Candidates1)]
                )]
            )]
        )]
    ),

    {ok, Fn, [{Property, ["Subject", "Candidates"]}]}.
