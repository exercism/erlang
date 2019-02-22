-module('tgen_sieve').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{limit := Limit}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:assign(tgs:var("Expected"), tgs:raw(format_list(Exp))),
        tgs:call_macro("assertEqual", [
            tgs:var("Expected"),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("sieve:" ++ Property, [
                    tgs:value(Limit)])])])]),

    {ok, Fn, [{Property, ["Limit"]}]}.

format_list([]) -> "[]";
format_list(List) when length(List)=<10 ->
    "["++lists:flatten(lists:join(", ", [io_lib:format("~B", [N]) || N <- List]))++"]";
format_list(List) ->
    MaxLen=length(integer_to_list(lists:max(List))),
    List1=[io_lib:format("~*B", [MaxLen, N]) || N <- lists:sort(List)],
    format_list(List1, 10, []).

format_list([], _, Acc) ->
    io_lib:format("[~n        ~s~n    ]", [lists:flatten(lists:join(io_lib:format(",~n        ", []), lists:reverse(Acc)))]);
format_list(List, M, Acc) ->
    {Cur, Rest}=lists:split(min(M, length(List)), List),
    format_list(Rest, M, [lists:join(", ", Cur)|Acc]).
