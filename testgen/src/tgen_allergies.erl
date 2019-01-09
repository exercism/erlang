-module('tgen_allergies').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"list">>, input := #{score := Score}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = "allergies",

    Exp1=
    lists:sort(
        lists:map(
            fun
                (Substance) -> binary_to_atom(string:lowercase(Substance), latin1)
            end,
            Exp
        )
    ),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp1),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("allergies:" ++ Property, [
                    tgs:value(Score)])])])]),

    {ok, Fn, [{Property, ["Score"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := <<"allergicTo">>, input := #{score := Score}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = "is_allergic_to",

    Fn=
    tgs:simple_fun(
        TestName,
        [ create_macro_call(Property, Score, E) || E <- Exp ]
    ),

    {ok, Fn, [{Property, ["Substance", "Score"]}]};

generate_test(_, _) ->
    ignore.



create_macro_call(Property, Score, #{substance := Substance, result := Result}) ->
    create_macro_call1(Property, Score, Substance, Result).

create_macro_call1(Property, Score, Substance, true) ->
    create_macro_call2(Property, Score, Substance, "assert");
create_macro_call1(Property, Score, Substance, false) ->
    create_macro_call2(Property, Score, Substance, "assertNot").

create_macro_call2(Property, Score, Substance, Assertion) ->
    tgs:call_macro(
        Assertion,
        [
            tgs:call_fun(
                "allergies:"++Property,
                [
                    tgs:value(binary_to_atom(string:lowercase(Substance), latin1)),
                    tgs:value(Score)
                ]
            )
        ]
    ).

