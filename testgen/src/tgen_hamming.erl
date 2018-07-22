-module('tgen_hamming').

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

generate_test(#{description := Desc, expected := #{error := Message}, property := Prop, 'strand1' := S1, 'strand2' := S2}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),
    Reason = binary_to_list(Message),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value({error, Reason}),
            tgs:call_fun("hamming:" ++ Property, [
                tgs:value(binary_to_list(S1)),
                tgs:value(binary_to_list(S2))])])]),

    {ok, Fn, [{Property, ["Strand1", "Strand2"]}]};
generate_test(#{description := Desc, expected := Exp, property := Prop, input := #{strand1 := S1, strand2 := S2}}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp),
            tgs:call_fun("hamming:" ++ Property, [
                tgs:value(binary_to_list(S1)),
                tgs:value(binary_to_list(S2))])])]),

    {ok, Fn, [{Property, ["Strand1", "Strand2"]}]}.
