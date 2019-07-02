-module('tgen_all-your-base').

-behaviour(tgen).

-export([
    available/0,
    revision/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

revision() -> 1.

generate_test(N, #{description := Desc, expected := #{error := Err}, property := Prop, input := #{inputBase := InputBase, outputBase := OutputBase, digits := Digits}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName ++ "_", [
        erl_syntax:tuple([
            tgs:value(binary_to_list(Desc)),
            tgs:call_macro("_assertMatch", [
                tgs:value({error, binary_to_list(Err)}),
                tgs:call_fun("all_your_base:" ++ Property, [
                    tgs:value(Digits),
                    tgs:value(InputBase),
                    tgs:value(OutputBase)])])])]),

    {ok, Fn, [{Property, ["Digits", "InputBase", "OutputBase"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{inputBase := InputBase, outputBase := OutputBase, digits := Digits}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName ++ "_", [
        erl_syntax:tuple([
            tgs:value(binary_to_list(Desc)),
            tgs:call_macro("_assertMatch", [
                tgs:value({ok, Exp}),
                tgs:call_fun("all_your_base:" ++ Property, [
                    tgs:value(Digits),
                    tgs:value(InputBase),
                    tgs:value(OutputBase)])])])]),

    {ok, Fn, [{Property, ["Digits", "InputBase", "OutputBase"]}]}.
