-module('tgen_protein-translation').

-behaviour(tgen).

-export([
    available/0,
    prepare_tests/1,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

prepare_tests(Cases) ->
    lists:map(
        fun
            (Case=#{expected := Exp}) -> Case#{expected => [protein_b2a(P) || P <- Exp]}
        end,
        Cases
    ).

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{strand := Strand}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp),
            tgs:call_fun("protein_translation:" ++ Property, [
                tgs:value(binary_to_list(Strand))])])]),

    {ok, Fn, [{Property, ["Strand"]}]}.


protein_b2a(P) ->
    binary_to_atom(string:lowercase(P), latin1).
