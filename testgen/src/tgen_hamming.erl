-module('tgen_hamming').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := #{error := Message}, property := Prop, input := #{strand1 := S1, strand2 := S2}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),
    Reason = binary_to_list(Message),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value({error, Reason}),
            tgs:call_fun("hamming:" ++ Property, [
                tgs:value(binary_to_list(S1)),
                tgs:value(binary_to_list(S2))])])]),

    {ok, Fn, [{Property, ["Strand1", "Strand2"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{strand1 := S1, strand2 := S2}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp),
            tgs:call_fun("hamming:" ++ Property, [
                tgs:value(binary_to_list(S1)),
                tgs:value(binary_to_list(S2))])])]),

    {ok, Fn, [{Property, ["Strand1", "Strand2"]}]}.
