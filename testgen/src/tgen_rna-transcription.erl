-module('tgen_rna-transcription').

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

generate_test(#{description := Desc, expected := null, property := <<"toRna">>, dna := DNA}) ->
    TestName = tgen:to_test_name(Desc),
    Property = "to_rna",

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(error),
            tgs:call_fun("rna_transcription:" ++ Property, [
                tgs:value(binary_to_list(DNA))])])]),

    {ok, Fn, [{Property, ["Strand"]}]};
generate_test(#{description := Desc, expected := Exp, property := <<"toRna">>, dna := DNA}) ->
    TestName = tgen:to_test_name(Desc),
    Property = "to_rna",

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("rna_transcription:" ++ Property, [
                tgs:value(binary_to_list(DNA))])])]),

    {ok, Fn, [{Property, ["Strand"]}]}.
