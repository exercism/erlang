-module('tgen_etl').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := Input}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Input1 = normalize_input(Input),
    Exp1 = normalize_expected(Exp),

    Input2 = format_lines(Input1),
    Exp2 = format_lines(Exp1),

    Fn = tgs:simple_fun(TestName, [
        tgs:raw("Input="++Input2),
        tgs:raw("Expected="++Exp2),
        tgs:call_macro("assertEqual", [
            tgs:call_fun("lists:sort", [tgs:raw("Expected")]),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("etl:" ++ Property, [
                    tgs:raw("Input")])])])]),

    {ok, Fn, [{Property, ["Old"]}]}.

normalize_input(Input) ->
    normalize_input(maps:to_list(Input), []).

normalize_input([], Acc) ->
    lists:sort(Acc);
normalize_input([{Score, Chars}|Input], Acc) ->
    normalize_input(Input, [{binary_to_integer(Score), [binary_to_list(C) || C <- Chars]}|Acc]).

normalize_expected(Expected) ->
    normalize_expected(maps:to_list(Expected), []).

normalize_expected([], Acc) ->
    lists:sort(Acc);
normalize_expected([{Char, Score}|Expected], Acc) when is_atom(Char) ->
    normalize_expected(Expected, [{atom_to_list(Char), Score}|Acc]);
normalize_expected([{Char, Score}|Expected], Acc) when is_binary(Char) ->
    normalize_expected(Expected, [{binary_to_list(Char), Score}|Acc]);
normalize_expected([{Char, Score}|Expected], Acc) ->
    normalize_expected(Expected, [{Char, Score}|Acc]).

format_lines(Lines0) ->
    Lines1=[format_line(L) || L <- Lines0],
    Fmt0=["        ~s" || _ <- Lines1],
    Fmt1=lists:join(",~n", Fmt0),
    Fmt2=io_lib:format("[~n~s~n    ]", [Fmt1]),
    Fmt3=lists:flatten(Fmt2),
    lists:flatten(io_lib:format(Fmt3, Lines1)).

format_line({Score, Chars}) when is_integer(Score) ->
    lists:flatten(io_lib:format("{~B, [~s]}", [Score, format_charlist(Chars)]));
format_line({Char, Score}) when is_integer(Score) ->
    lists:flatten(io_lib:format("{~s, ~B}", [format_charlist([Char]), Score])).


format_charlist(Chars) ->
    lists:flatten(lists:join(", ", [io_lib:format("\"~s\"", [C]) || C <- Chars])).
