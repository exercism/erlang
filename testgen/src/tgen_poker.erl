-module('tgen_poker').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{hands := Hands}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Hands1=[binary_to_list(H) || H <- Hands],
    Exp1=lists:sort([binary_to_list(H) || H <- Exp]),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(Exp1),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("poker:" ++ Property, [
                    tgs:value(Hands1)])])])]),

    {ok, Fn, [{Property, ["Hands"]}]}.
