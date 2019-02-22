-module('tgen_secret-handshake').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{number := Number}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value([binary_to_list(E) || E <- Exp]),
            tgs:call_fun("secret_handshake:" ++ Property, [
                tgs:value(Number)])])]),

    {ok, Fn, [{Property, ["Number"]}]}.
