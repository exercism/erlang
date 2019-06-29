-module('tgen_hello-world').

-behaviour(tgen).

-export([
    available/0,
    revision/0,
    prepare_test_module/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

revision() -> 1.

prepare_test_module() ->
    AssertStringEqual = tgs:raw("-define(assertStringEqual(Expect, Expr),
        begin ((fun () ->
            __X = (Expect),
            __Y = (Expr),
            case string:equal(__X, __Y) of
                true -> ok;
                false -> erlang:error({assertStringEqual,
                    [{module, ?MODULE},
                     {line, ?LINE},
                     {expression, (??Expr)},
                     {expected, unicode:characters_to_list(__X)},
                     {value, unicode:characters_to_list(__Y)}]})
            end
        end)())
    end)."),

    UnderscoreAssertStringEqual = tgs:raw("-define(_assertStringEqual(Expect, Expr), ?_test(?assertStringEqual(Expect, Expr)))."),

    {ok, [AssertStringEqual, UnderscoreAssertStringEqual]}.

generate_test(N, #{description := Desc, expected := Exp, property := Prop}) ->
    TestName = tgen:to_test_name(N, Desc),
    Expected = binary_to_list(Exp),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName ++ "_", [
            erl_syntax:tuple([
                tgs:value(binary_to_list(Desc)),
                tgs:call_macro("_assertStringEqual", [
                    tgs:value(Expected),
                    tgs:call_fun("hello_world:" ++ Property, [])])])]),

    {ok, Fn, [{Prop, []}]}.
