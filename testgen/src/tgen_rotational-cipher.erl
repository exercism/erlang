-module('tgen_rotational-cipher').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"rotate">>, input := #{text := String, shiftKey := Key}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property1 = tgen:to_property_name(<<"encrypt">>),
    Property2 = tgen:to_property_name(<<"decrypt">>),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("rotational_cipher:" ++ Property1, [
                tgs:value(binary_to_list(String)), tgs:value(Key)])]),
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(String)),
            tgs:call_fun("rotational_cipher:" ++ Property2, [
                tgs:value(binary_to_list(Exp)), tgs:value(Key)])])]),

    {ok, Fn, [{Property1, ["String", "Key"]}, {Property2, ["String", "Key"]}]}.
