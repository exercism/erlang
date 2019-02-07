-module('tgen_gigasecond').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"add">>, input := #{moment := From}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(<<"from">>),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(ts_transform(Exp, strict)),
            tgs:call_fun("gigasecond:" ++ Property, [
                tgs:value(ts_transform(From, relaxed))])])]),

    {ok, Fn, [{Property, ["From"]}]}.

ts_transform(<<Year:4/bytes, $-, Month:2/bytes, $-, Day:2/bytes, $T, Hours:2/bytes, $:, Minutes:2/bytes, $:, Seconds:2/bytes>>, _) ->
    {
        {binary_to_integer(Year), binary_to_integer(Month), binary_to_integer(Day)},
        {binary_to_integer(Hours), binary_to_integer(Minutes), binary_to_integer(Seconds)}
    };
ts_transform(<<Year:4/bytes, $-, Month:2/bytes, $-, Day:2/bytes>>, strict) ->
    {
        {binary_to_integer(Year), binary_to_integer(Month), binary_to_integer(Day)},
        {0, 0, 0}
    };
ts_transform(<<Year:4/bytes, $-, Month:2/bytes, $-, Day:2/bytes>>, relaxed) ->
    {binary_to_integer(Year), binary_to_integer(Month), binary_to_integer(Day)}.
