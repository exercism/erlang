-module('tgen_word-count').

-behaviour(tgen).

-export([
    available/0,
    prepare_test_module/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

prepare_test_module() ->
    {
        ok,
        [
            tgs:raw(
                io_lib:format(
                    "assertCount(Exp0, Actual0) ->~n"
                    "    Exp1=lists:sort(maps:to_list(Exp0)),~n"
                    "    Actual1=lists:sort(maps:to_list(Actual0)),~n"
                    "    ?assertMatch(Exp1, Actual1).",
                    []
                )
            )
        ]
    }.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{sentence := Sentence}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Exp1=maps:fold(
        fun
            (K, V, Acc) when is_binary(K) ->
                Acc#{binary_to_list(K) => V};
            (K, V, Acc) when is_atom(K) -> %% jsx may return an atom instead of a binary for map keys
                Acc#{atom_to_list(K) => V}
        end,
        #{},
        Exp
    ),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_fun("assertCount", [
            tgs:value(Exp1),
            tgs:call_fun("word_count:" ++ Property, [
                tgs:value(binary_to_list(Sentence))])])]),

    {ok, Fn, [{Property, ["Sentence"]}]}.
