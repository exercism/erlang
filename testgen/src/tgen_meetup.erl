-module('tgen_meetup').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{year := Year, month := Month, week := Week, dayofweek := DayOfWeek}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(date_to_tuple(Exp)),
            tgs:call_fun("meetup:" ++ Property, [
                tgs:value(Year),
                tgs:value(Month),
                tgs:value(to_atom(DayOfWeek)),
                tgs:value(to_atom(Week))])])]),

    {ok, Fn, [{Property, ["Year", "Month", "DayOfWeek", "Week"]}]}.

to_atom(Str) ->
    binary_to_atom(string:lowercase(Str), latin1).

date_to_tuple(<<Year:4/bytes, $-, Month:2/bytes, $-, Day:2/bytes>>) ->
    {
        binary_to_integer(Year),
        binary_to_integer(Month),
        binary_to_integer(Day)
    }.
