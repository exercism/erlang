-module('tgen_hello-world').

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

generate_test(#{description := Desc, expected := Exp, property := Prop}) ->
    TestName = tgen:to_test_name(Desc),
    Expected = binary_to_list(Exp),
    Property = binary_to_list(Prop),

    Fn = tgs:simple_fun(TestName, [
            tgs:call_macro("assertEqual", [
                tgs:value(Expected),
                tgs:call_macro("TESTED_MODULE:" ++ Property, [])])]),

    {ok, Fn, [{Prop, []}]}.
