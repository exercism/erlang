-module('tgen_rational-numbers').

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
                    "equal_float(A, B) ->~n"
                    "    round(A*100) / 100==round(B*100) / 100.",
                    []
                )
            )
        ]
    }.

generate_test(N, #{description := Desc, expected := [ExpA, ExpB], property := <<"exprational">>, input := #{r := [A, B], n := Exponent}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(<<"exp">>),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value({ExpA, ExpB}),
            tgs:call_fun("rational_numbers:" ++ Property, [
                tgs:value({A, B}), tgs:value(Exponent)])])]),

    {ok, Fn, [{Property, ["Base", "Exponent"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := <<"expreal">>, input := #{x := X, r := [A, B]}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(<<"exp">>),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assert", [
            tgs:call_fun("equal_float", [tgs:value(Exp),
                tgs:call_fun("rational_numbers:" ++ Property, [
                    tgs:value(X), tgs:value({A, B})])])])]),

    {ok, Fn, [{Property, ["Base", "Exponent"]}]};
generate_test(N, #{description := Desc, expected := [ExpA, ExpB], property := Prop = <<"reduce">>, input := #{r := [A, B]}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value({ExpA, ExpB}),
            tgs:call_fun("rational_numbers:" ++ Property, [
                tgs:value({A, B})])])]),

    {ok, Fn, [{Property, ["R"]}]};
generate_test(N, #{description := Desc, expected := [ExpA, ExpB], property := <<"abs">>, input := #{r := [A, B]}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(<<"absolute">>),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value({ExpA, ExpB}),
            tgs:call_fun("rational_numbers:" ++ Property, [
                tgs:value({A, B})])])]),

    {ok, Fn, [{Property, ["R"]}]};
generate_test(N, #{description := Desc, expected := [ExpA, ExpB], property := Prop, input := #{r1 := [A1, B1], r2 := [A2, B2]}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(
        case Prop of
            <<"div">> -> <<"divide">>;
            _ -> Prop
        end
    ),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value({ExpA, ExpB}),
            tgs:call_fun("rational_numbers:" ++ Property, [
                tgs:value({A1, B1}), tgs:value({A2, B2})])])]),

    {ok, Fn, [{Property, ["R1", "R2"]}]};
generate_test(_, _) ->
    ignore.
