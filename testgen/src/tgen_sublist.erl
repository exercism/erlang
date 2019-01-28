-module('tgen_sublist').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"sublist">>, input := #{listOne := L1, listTwo := L2}}) ->
    TestName = tgen:to_test_name(N, Desc),

    Assertions=case Exp of
        <<"equal">> ->
            [
               create_relation_macro(equal, L1, L2) |
               [create_is_macro(F, E, L1, L2) || {F, E} <- [{"is_equal", true}, {"is_unequal", false}, {"is_sublist", true}, {"is_superlist", true}]]
            ];
        <<"unequal">> ->
            [
               create_relation_macro(unequal, L1, L2) |
               [create_is_macro(F, E, L1, L2) || {F, E} <- [{"is_equal", false}, {"is_unequal", true}, {"is_sublist", false}, {"is_superlist", false}]]
            ];
        <<"sublist">> ->
            [
               create_relation_macro(sublist, L1, L2) |
               [create_is_macro(F, E, L1, L2) || {F, E} <- [{"is_equal", false}, {"is_unequal", true}, {"is_sublist", true}, {"is_superlist", false}]]
            ];
        <<"superlist">> ->
            [
               create_relation_macro(superlist, L1, L2) |
               [create_is_macro(F, E, L1, L2) || {F, E} <- [{"is_equal", false}, {"is_unequal", true}, {"is_sublist", false}, {"is_superlist", true}]]
            ]
    end,

    {
        ok,
        tgs:simple_fun(TestName, Assertions),
        [
            {"relation", ["L1", "L2"]},
            {"is_equal", ["L1", "L2"]},
            {"is_unequal", ["L1", "L2"]},
            {"is_sublist", ["L1", "L2"]},
            {"is_superlist", ["L1", "L2"]}
        ]
    };
generate_test(_, _) ->
    ignore.

create_relation_macro(Exp, L1, L2) ->
    tgs:call_macro("assertEqual", [tgs:value(Exp), tgs:call_fun("sublist:relation", [tgs:value(L1), tgs:value(L2)])]).

create_is_macro(Fun, Exp, L1, L2) ->
    Assert=case Exp of
        true -> "assert";
        false -> "assertNot"
    end,
    tgs:call_macro(Assert, [tgs:call_fun("sublist:"++Fun, [tgs:value(L1), tgs:value(L2)])]).
