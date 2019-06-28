-module('tgen_hello-world').

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

generate_test(N, #{description := Desc, expected := Exp, property := Prop}) ->
    TestName = tgen:to_test_name(N, Desc),
    Expected = binary_to_list(Exp),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName ++ "_", [
            erl_syntax:tuple([
                tgs:value(binary_to_list(Desc)),
                tgs:call_macro("_assertEqual", [
                    tgs:value(Expected),
                    tgs:call_fun("hello_world:" ++ Property, [])])])]),

    {ok, Fn, [{Prop, []}]}.
