-module('tgen_leap').

-behaviour(tgen).

-export([
    available/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

generate_test(#{description := Desc, expected := Exp, property := <<"leapYear">>, input := #{year := Year}}) ->
    TestName = tgen:to_test_name(Desc),
    Property = "leap_year",

    Assert = case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
            tgs:call_fun("leap:" ++ Property, [
                tgs:value(Year)])])]),

    {ok, Fn, [{Property, ["Year"]}]}.
