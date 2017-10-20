-module('tgen_hello-world').

-behaviour(tgen).

-export([
    available/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

generate_test(#{description := Desc, expected := Exp, property := Prop}) ->
    TestName = tgen:to_test_name(Desc),
    #{testname    => TestName,
      funs_tested => [Prop],
      testimpl    => lists:flatten(io_lib:format("?assertEqual(\"~s\", ?TESTED_MODULE:~s()).", [Exp, Prop]))
    }.