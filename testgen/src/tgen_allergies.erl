-module('tgen_allergies').

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

    Fn = tgs:simple_fun(TestName ++ "_", [
        erl_syntax:tuple([
            tgs:value(binary_to_list(Desc)),
            tgs:call_macro("_assertMatch", [
                tgs:value(Exp1),
                tgs:call_fun("lists:sort", [
                    tgs:call_fun("allergies:" ++ Property, [
                        tgs:value(Score)])])])])]),

    {ok, Fn, [{Property, ["Score"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := <<"allergicTo">>, input := #{score := Score}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = "is_allergic_to",

    Fn=
    tgs:simple_fun(
        TestName ++ "_",
        [
            tgs:assign(tgs:var("Score"), tgs:value(Score)),
            erl_syntax:list([ create_macro_call(Property, E) || E <- Exp ])]
    ),

    {ok, Fn, [{Property, ["Substance", "Score"]}]};

generate_test(_, _) ->
    ignore.



create_macro_call(Property, #{substance := Substance, result := Result}) ->
    create_macro_call1(Property, Substance, Result).

create_macro_call1(Property, Substance, true) ->
    create_macro_call2(Property, Substance, "_assert");
create_macro_call1(Property, Substance, false) ->
    create_macro_call2(Property, Substance, "_assertNot").

create_macro_call2(Property, Substance, Assertion) ->
    erl_syntax:tuple([
        tgs:value(binary_to_list(Substance)),
        tgs:call_macro(
            Assertion,
            [
                tgs:call_fun(
                    "allergies:"++Property,
                    [
                        tgs:value(binary_to_atom(string:lowercase(Substance), latin1)),
                        tgs:var("Score")
                    ]
                )
            ]
        )
    ]).

