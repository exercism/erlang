-module('tgen_hello-world').

-behaviour(tgen).

-export([
    available/0,
    version/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

version() -> "2".

generate_test(#{description := Desc, expected := Exp, property := Prop}) ->
    TestName = tgen:to_test_name(Desc),
    Expected = binary_to_list(Exp),
    Property = binary_to_list(Prop),

    Fn = erl_syntax:function(
        erl_syntax:text(TestName), [
            erl_syntax:clause(none, [
                erl_syntax:application(
                    erl_syntax:text("?assertEqual"), [
                        erl_syntax:abstract(Expected),
                        erl_syntax:application(
                            erl_syntax:text("?TESTED_MODULE:" ++ Property), [])])])]),

    {ok, Fn, [{Prop, []}]}.
