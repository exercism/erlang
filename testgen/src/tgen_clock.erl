-module('tgen_clock').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"create">>, input := #{hour := Hour, minute := Minute}}) ->
    TestName = tgen:to_test_name(N, Desc),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("clock:to_string", [
                tgs:call_fun("clock:create", [
                    tgs:value(Hour), tgs:value(Minute)])])])]),

    {ok, Fn, [{"to_string", ["Clock"]}, {"create", ["Hour", "Minute"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{hour := Hour, minute := Minute, value := Value}}) when Prop =:= <<"add">>; Prop =:= <<"subtract">> ->
    TestName = tgen:to_test_name(N, Desc),

    Value1 = if
        Prop =:= <<"add">> -> Value;
        Prop =:= <<"subtract">> -> -Value
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("clock:to_string", [
                tgs:call_fun("clock:minutes_add", [
                    tgs:call_fun("clock:create", [
                        tgs:value(Hour), tgs:value(Minute)]),
                    tgs:value(Value1)])])])]),

    {ok, Fn, [{"to_string", ["Clock"]}, {"minutes_add", ["Clock", "Minutes"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := <<"equal">>, input := #{clock1 := #{hour := Hour1, minute := Minute1}, clock2 := #{hour := Hour2, minute := Minute2}}}) ->
    TestName = tgen:to_test_name(N, Desc),

    Assert = case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
                tgs:call_fun("clock:is_equal", [
                    tgs:call_fun("clock:create", [
                        tgs:value(Hour1), tgs:value(Minute1)]),
                    tgs:call_fun("clock:create", [
                        tgs:value(Hour2), tgs:value(Minute2)])])])]),

    {ok, Fn, [{"is_equal", ["Clock1", "Clock2"]}]};

generate_test(_, _) -> ignore.
