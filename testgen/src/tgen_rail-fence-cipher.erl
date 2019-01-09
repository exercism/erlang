-module('tgen_rail-fence-cipher').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{msg := Message, rails := Rails}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertMatch", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("rail_fence_cipher:" ++ Property, [
                tgs:value(binary_to_list(Message)), tgs:value(Rails)])])]),

    {ok, Fn, [{Property, ["Message", "Rails"]}]}.
