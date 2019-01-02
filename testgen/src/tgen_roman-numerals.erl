-module('tgen_roman-numerals').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := _Desc, expected := Exp, property := Prop, input := #{number := Number}}) ->
    TestName = tgen:to_test_name(N, "convert " ++ integer_to_list(Number)),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("roman_numerals:" ++ Property, [
                tgs:value(Number)])])]),

    {ok, Fn, [{Property, ["Number"]}]}.
