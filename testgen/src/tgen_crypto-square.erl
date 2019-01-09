-module('tgen_crypto-square').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{plaintext := PlainText}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("crypto_square:" ++ Property, [
                tgs:value(binary_to_list(PlainText))])])]),

    {ok, Fn, [{Property, ["PlainText"]}]}.
