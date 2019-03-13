-module('tgen_change').

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
            (Case=#{expected := #{error := _}, input := #{target := Target}}) when Target>0 -> Case#{expected := undefined};
            (Case) -> Case
        end,
        Cases
    ).

generate_test(N, #{description := Desc, expected := #{error := _}, property := Prop, input := #{target := Target, coins := Coins}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:assign(tgs:var("Target"), tgs:value(Target)),
        tgs:assign(tgs:var("Coins"), tgs:raw(format_intlist(Coins))),
        tgs:call_macro("assertError", [
            tgs:var("_"),
            tgs:call_fun("change:" ++ Property, [
                tgs:var("Target"), tgs:var("Coins")])])]),

    {ok, Fn, [{Property, ["Target", "Coins"]}]};
generate_test(N, #{description := Desc, expected := undefined, property := Prop, input := #{target := Target, coins := Coins}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:assign(tgs:var("Target"), tgs:value(Target)),
        tgs:assign(tgs:var("Coins"), tgs:raw(format_intlist(Coins))),
        tgs:assign(tgs:var("Expected"), tgs:value(undefined)),
        tgs:call_macro("assertEqual", [
            tgs:var("Expected"),
            tgs:call_fun("change:" ++ Property, [
                tgs:var("Target"), tgs:var("Coins")])])]),

    {ok, Fn, [{Property, ["Target", "Coins"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{target := Target, coins := Coins}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:assign(tgs:var("Target"), tgs:value(Target)),
        tgs:assign(tgs:var("Coins"), tgs:raw(format_intlist(Coins))),
        tgs:assign(tgs:var("Expected"), tgs:raw(format_intlist(lists:sort(Exp)))),
        tgs:call_macro("assertEqual", [
            tgs:var("Expected"),
            tgs:call_fun("change:" ++ Property, [
                tgs:var("Target"), tgs:var("Coins")])])]),

    {ok, Fn, [{Property, ["Target", "Coins"]}]}.

format_intlist(L) ->
    io_lib:format(lists:flatten([$[, lists:join(", ", ["~B" || _ <- L]), $]]), L).
