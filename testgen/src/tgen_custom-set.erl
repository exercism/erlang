-module('tgen_custom-set').

-behaviour(tgen).

-export([
    available/0,
    version/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

version() -> 1.

generate_test(#{description := _, cases := Cases}) ->
    rewrap(lists:flatten(lists:map(fun generate_test/1, Cases)), {[], []});
generate_test(F=#{description := Desc, expected := Exp, property := Prop, set1 := Set1, set2 := Set2}) when is_list(Exp) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:call_macro("TESTED_MODULE:from_list", [
                tgs:value(Exp)]),
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:call_macro("TESTED_MODULE:from_list", [tgs:value(Set1)]),
                tgs:call_macro("TESTED_MODULE:from_list", [tgs:value(Set2)])])])]),

    {ok, Fn, [{Property, ["Set1", "Set2"]}]};
generate_test(F=#{description := Desc, expected := Exp, property := Prop, set1 := Set1, set2 := Set2}) when Exp =:= true; Exp =:= false ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Assert = case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:call_macro("TESTED_MODULE:from_list", [tgs:value(Set1)]),
                tgs:call_macro("TESTED_MODULE:from_list", [tgs:value(Set2)])])])]),

    {ok, Fn, [{Property, ["Set1", "Set2"]}, {"from_list", ["List"]}]};
generate_test(#{description := Desc, expected := Exp, property := Prop, set := Set, element := Elem}) when is_list(Exp) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:call_macro("TESTED_MODULE:from_list", [
                tgs:value(Exp)]),
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:value(Elem),
                tgs:call_macro("TESTED_MODULE:from_list", [
                    erl_syntax:abstract(Set)])])])]),

    {ok, Fn, [{Property, ["Elem", "Set"]}, {"from_list", ["List"]}]};
generate_test(#{description := Desc, expected := Exp, property := Prop, set := Set, element := Elem}) when Exp =:= true; Exp =:= false ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Assert = case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:value(Elem),
                tgs:call_macro("TESTED_MODULE:from_list", [
                    erl_syntax:abstract(Set)])])])]),

    {ok, Fn, [{Property, ["Elem", "Set"]}, {"from_list", ["List"]}]};
generate_test(#{description := Desc, expected := Exp, property := <<"empty">>, set := Set}) when Exp =:= true; Exp =:= false ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(<<"empty">>),

    Assert = case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:call_macro("TESTED_MODULE:from_list", [
                    tgs:value(Set)])])])]),

    {ok, Fn, [{Property, ["Set"]}, {"from_list", ["List"]}]}.

rewrap([], {Fns, Props}) -> {ok, lists:reverse(Fns), Props};
rewrap([{ok, Fn, Props}|Tail], {Fns, AccProps}) ->
    rewrap(Tail, {[Fn|Fns], Props ++ AccProps}).
