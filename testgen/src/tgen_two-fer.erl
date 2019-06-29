-module('tgen_two-fer').

-behaviour(tgen).

-export([
    available/0,
    revision/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

revision() ->
    1.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{name := null}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("two_fer:" ++ Property, [])])]),

    {ok, Fn, [{Property, []}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{name := Name}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("two_fer:" ++ Property, [
                tgs:value(binary_to_list(Name))])])]),

    {ok, Fn, [{Property, ["Name"]}]}.
