-module('tgen_isbn-verifier').

-behaviour(tgen).

-export([
    available/0,
    generate_test/1
]).

-spec available() -> true.
available() ->
    true.

generate_test(#{description := Desc, expected := Exp, property := Prop, input := #{isbn := Isbn}}) ->
    TestName = tgen:to_test_name(Desc),
    Property = tgen:to_property_name(Prop),

    Assert = case Exp of
        true -> "assert";
        false -> "assertNot"
    end,

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro(Assert, [
            tgs:call_fun("isbn_verifier:" ++ Property, [
                tgs:value(binary_to_list(Isbn))])])]),

    {ok, Fn, [{Property, ["Isbn"]}]}.
