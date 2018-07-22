-module('tgen_complex-numbers').

-behaviour(tgen).

-export([
    available/0,
    version/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

version() -> 1.

generate_test(F = #{description := Desc, cases := Cases}) ->
    rewrap(lists:flatten(lists:map(fun generate_test/1, Cases)), {[], []});
generate_test(#{description := Desc, expected := Exp, property := Prop, input := #{z := Z}}) when is_number(Exp) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Cplx = lists:map(fun to_num/1, Z),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assert", [
            erl_syntax:infix_expr(
                tgs:value(Exp),
                erl_syntax:operator("=="),
                tgs:call_fun("complex_numbers:" ++ Property, [
                    tgs:call_fun("complex_numbers:new", lists:map(fun tgs:value/1, Cplx))]))])]),

    {ok, Fn, [{Property, ["Z"]}]};
generate_test(#{description := Desc, expected := Exp, property := Prop, input := #{z := Z}}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Cplx = lists:map(fun to_num/1, Z),
    Expected = lists:map(fun to_num/1, Exp),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assert", [
            tgs:call_fun("complex_numbers:equal", [
                tgs:call_fun("complex_numbers:new", lists:map(fun tgs:value/1, Expected)),
                tgs:call_fun("complex_numbers:" ++ Property, [
                    tgs:call_fun("complex_numbers:new", lists:map(fun tgs:value/1, Cplx))])])])]),

    {ok, Fn, [{Property, ["Z"]}]};
generate_test(#{description := Desc, expected := Exp, property := <<"div">>, input := #{z1 := Z1, z2 := Z2}}) ->
    generate_test(#{description => Desc, expected => Exp, property => <<"divide">>, input => #{z1 => Z1, z2 => Z2}});
generate_test(#{description := Desc, expected := Exp, property := Prop, input := #{z1 := Z1, z2 := Z2}}) ->
    TestName = tgen:to_test_name(Desc),
    Property = binary_to_list(Prop),

    Cplx1 = lists:map(fun to_num/1, Z1),
    Cplx2 = lists:map(fun to_num/1, Z2),
    Expected = lists:map(fun to_num/1, Exp),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assert", [
            tgs:call_fun("complex_numbers:equal", [
                tgs:call_fun("complex_numbers:new", lists:map(fun tgs:value/1, Expected)),
                tgs:call_fun("complex_numbers:" ++ Property, [
                    tgs:call_fun("complex_numbers:new", lists:map(fun tgs:value/1, Cplx1)),
                    tgs:call_fun("complex_numbers:new", lists:map(fun tgs:value/1, Cplx2))])])])]),

    {ok, Fn, [{Property, ["Z1", "Z2"]}, {"equal", ["Z1", "Z2"]}, {"new", ["R", "I"]}]}.

rewrap([], {Fns, Props}) -> {ok, lists:reverse(Fns), Props};
rewrap([{ok, Fn, Props}|Tail], {Fns, AccProps}) ->
    rewrap(Tail, {[Fn|Fns], Props ++ AccProps}).

to_num(N) when is_number(N) -> N;
to_num(<<"ln(2)">>) -> math:log(2);
to_num(<<"pi">>) -> math:pi();
to_num(<<"e">>) -> math:exp(1).
