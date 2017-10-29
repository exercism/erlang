-module('tgen_collatz-conjecture').

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

generate_test(#{description := Desc, expected := #{error := Message}, property := Prop, number := Num}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value({error, binary_to_list(Message)}),
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:value(Num)])])]),

    {ok, Fn, [{Prop, ["N"]}]};
generate_test(#{description := Desc, expected := Exp, property := Prop, number := Num}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp),
            tgs:call_macro("TESTED_MODULE:" ++ Property, [
                tgs:value(Num)])])]),

    {ok, Fn, [{Prop, ["N"]}]}.
