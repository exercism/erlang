-module('tgen_nucleotide-count').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := #{error := _}, property := <<"nucleotideCounts">>, input := #{strand := Strand}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property1 = tgen:to_property_name(<<"nucleotide_counts">>),
    Property2 = tgen:to_property_name(<<"count">>),

    Asserts0=lists:map(
        fun
            (Nuc) ->
                tgs:call_macro("assertError", [
                    tgs:raw("_"),
                    tgs:call_fun("nucleotide_count:"++Property2, [
                        tgs:var("Strand"),
                        tgs:value(Nuc)])])
        end,
        ["A", "C", "G", "T"]
    ),
    Asserts1=[
        tgs:call_macro("assertError", [
            tgs:raw("_"),
            tgs:call_fun("nucleotide_count:"++Property1, [
                tgs:var("Strand")])])
        |Asserts0],

    Fn = tgs:simple_fun(TestName, [
        tgs:assign(tgs:var("Strand"), tgs:value(binary_to_list(Strand)))]
        ++Asserts1),

    {ok, Fn, [{Property1, ["Strand"]}, {Property2, ["Strand", "Nucleotide"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := <<"nucleotideCounts">>, input := #{strand := Strand}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property1 = tgen:to_property_name(<<"nucleotide_counts">>),
    Property2 = tgen:to_property_name(<<"count">>),

    Exp1 = [{binary_to_list(K), V} || {K, V} <- maps:to_list(Exp)],

    Asserts0=lists:map(
        fun
            ({K, V}) ->
                tgs:call_macro("assertEqual", [
                    tgs:value(V),
                    tgs:call_fun("nucleotide_count:"++Property2, [
                        tgs:var("Strand"),
                        tgs:value(K)])])
        end,
        Exp1
    ),
    Asserts1=[
        tgs:call_macro("assertEqual", [
            tgs:call_fun("lists:sort", [
                tgs:value(Exp1)]),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("nucleotide_count:"++Property1, [
                    tgs:var("Strand")])])])
        |Asserts0],

    Fn = tgs:simple_fun(TestName, [
        tgs:assign(tgs:var("Strand"), tgs:value(binary_to_list(Strand)))]
        ++Asserts1),

    {ok, Fn, [{Property1, ["Strand"]}, {Property2, ["Strand", "Nucleotide"]}]}.
