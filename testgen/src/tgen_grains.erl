-module('tgen_grains').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := #{error := Message}, property := Prop = <<"square">>, input := #{square := Square}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value({error, binary_to_list(Message)}),
            tgs:call_fun("grains:square", [
                tgs:value(Square)])])]),

    {ok, Fn, [{Property, ["Square"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop = <<"square">>, input := #{square := Square}}) ->
    TestName = tgen:to_test_name(N, <<"square_", Desc/binary>>),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp),
            tgs:call_fun("grains:square", [
                tgs:value(Square)])])]),

    {ok, Fn, [{Property, ["Square"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop = <<"total">>}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp),
            tgs:call_fun("grains:total", [])])]),

    {ok, Fn, [{Property, []}]};
generate_test(_, _) ->
    ignore.
