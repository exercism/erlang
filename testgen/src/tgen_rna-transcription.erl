-module('tgen_rna-transcription').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := null, property := Prop, input := #{dna := DNA}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(error),
            tgs:call_fun("rna_transcription:" ++ Property, [
                tgs:value(binary_to_list(DNA))])])]),

    {ok, Fn, [{Property, ["Strand"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{dna := DNA}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("rna_transcription:" ++ Property, [
                tgs:value(binary_to_list(DNA))])])]),

    {ok, Fn, [{Property, ["Strand"]}]}.
