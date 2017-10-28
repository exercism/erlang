-module('tgen_leap').

-behaviour(tgen).

-export([
    available/0,
    version/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

version() -> 2.

generate_test(#{description := Desc, expected := Exp, property := <<"leapYear">>, input := In}) ->
    TestName = tgen:to_test_name(Desc),
    Property = "leap_year",

    Assert = case Exp of
        true -> "?assert";
        false -> "?assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_fun(Assert, [
            tgs:call_fun("?TESTED_MODULE:" ++ Property, [
                tgs:value(In)])])]),

    {ok, Fn, [{Property, ["Year"]}]}.
