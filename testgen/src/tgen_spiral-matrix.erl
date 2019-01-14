-module('tgen_spiral-matrix').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"spiralMatrix">>, input := #{size := Size}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(<<"make">>),

    Fn = tgs:simple_fun(TestName, [
        tgs:raw("Expected="++format_lines(Exp)),
        tgs:call_macro("assertEqual", [
            tgs:raw("Expected"),
            tgs:call_fun("spiral_matrix:" ++ Property, [
                tgs:value(Size)])])]),

    {ok, Fn, [{Property, ["Size"]}]}.

format_lines(Lines0) ->
    Width=calc_width(Lines0),
    Lines1=[format_line(L, Width) || L <- Lines0],
    Fmt0=["        ~s" || _ <- Lines1],
    Fmt1=lists:join(",~n", Fmt0),
    Fmt2=io_lib:format("[~n~s~n    ]", [Fmt1]),
    Fmt3=lists:flatten(Fmt2),
    lists:flatten(io_lib:format(Fmt3, Lines1)).

format_line(Line, undefined) ->
    format_line1(Line, "~B");
format_line(Line, ElWidth) ->
    format_line1(Line, "~"++integer_to_list(ElWidth)++"B").

format_line1(Line, Fmt) ->
    lists:flatten([$[, lists:join(", ", [io_lib:format(Fmt, [N]) || N <- Line]), $]]).

calc_width([]) ->
    undefined;
calc_width(Lines) ->
    MaxN=lists:max(lists:flatten(Lines)),
    length(integer_to_list(MaxN)).
