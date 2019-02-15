-module('tgen_run-length-encoding').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"consistency">>, input := #{string := String}}) ->
    TestName = tgen:to_test_name(N, Desc),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("run_length_encoding:decode", [
                tgs:call_fun("run_length_encoding:encode", [
                    tgs:value(binary_to_list(String))])])])]),

    {ok, Fn, [{"encode", ["String"]}, {"decode", ["String"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{string := String}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("run_length_encoding:" ++ Property, [
                tgs:value(binary_to_list(String))])])]),

    {ok, Fn, [{Property, ["String"]}]}.
