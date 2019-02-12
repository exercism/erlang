-module('tgen_palindrome-products').

-behaviour(tgen).

-export([
    available/0,
    prepare_test_module/0,
    prepare_tests/1,
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
                    "normalize({V, F}) ->~n"
                    "    {~n"
                    "        V,~n"
                    "        lists:sort(~n"
                    "            lists:map(~n"
                    "                fun~n"
                    "                    ({A, B}) when A>B -> {B, A};~n"
                    "                    (AB) -> AB~n"
                    "                end,~n"
                    "                F~n"
                    "            )~n"
                    "        )~n"
                    "    }.",
                    []
                )
            )
        ]
    }.

prepare_tests(Cases) ->
    lists:filtermap(
        fun
            (Case=#{expected := #{error := _}, input := #{min := Min, max := Max}}) when Min=<Max ->
                {true, Case#{expected := undefined}};
            (Case=#{expected := #{factors := []}}) ->
                {true, Case#{expected := undefined}};
            (_) -> true
        end,
        Cases
    ).

generate_test(N, #{description := Desc, expected := #{error := _}, property := Prop, input := #{min := Min, max := Max}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertError", [
            tgs:raw("_"),
            tgs:call_fun("palindrome_products:" ++ Property, [
                tgs:value(Min), tgs:value(Max)])])]),

    {ok, Fn, [{Property, ["Min", "Max"]}]};

generate_test(N, #{description := Desc, expected := undefined, property := Prop, input := #{min := Min, max := Max}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(undefined),
            tgs:call_fun("palindrome_products:" ++ Property, [
                tgs:value(Min), tgs:value(Max)])])]),

    {ok, Fn, [{Property, ["Min", "Max"]}]};

generate_test(N, #{description := Desc, expected := #{value := ExpVal, factors := ExpFactors}, property := Prop, input := #{min := Min, max := Max}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:call_fun("normalize", [
                tgs:value({ExpVal, transform_factors(ExpFactors)})
            ]),
            tgs:call_fun("normalize", [
                tgs:call_fun("palindrome_products:" ++ Property, [
                    tgs:value(Min), tgs:value(Max)])])])]),

    {ok, Fn, [{Property, ["Min", "Max"]}]};

generate_test(_, _) ->
    ignore.

transform_factors(Factors) ->
    [{F1, F2} || [F1, F2] <- Factors].
