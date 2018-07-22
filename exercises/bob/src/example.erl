-module(example).

-export([response/1, test_version/0]).

-spec response(string()) -> string().
response(String) ->
  first_match(
    trim(String),
    [{fun is_forceful_question/1, "Calm down, I know what I'm doing!"},
     {fun is_silent/1, "Fine. Be that way!"},
     {fun is_shouting/1, "Whoa, chill out!"},
     {fun is_question/1, "Sure."},
     {fun (_) -> true end, "Whatever."}]).

test_version() ->
    3.



first_match(S, [{F, Res} | Fs]) ->
    case F(S) of
        true -> Res;
        false -> first_match(S, Fs)
    end.

is_shouting(String) ->
    lists:any(fun (C) -> C >= $A andalso C =< $Z end, String) andalso
    string:to_upper(String) =:= String.

is_question(String) ->
    lists:last(String) =:= $?.

is_forceful_question(String) ->
    is_shouting(String) andalso is_question(String).

is_silent("") -> true;
is_silent(_) -> false.

trim(String) ->
    trim_left(trim_right(String)).

trim_left("") -> "";
trim_left([$\s|T]) -> trim_left(T);
trim_left([$\t|T]) -> trim_left(T);
trim_left([$\n|T]) -> trim_left(T);
trim_left([$\r|T]) -> trim_left(T);
trim_left(S) -> S.

trim_right(S) ->
    S1 = lists:reverse(S),
    S2 = trim_left(S1),
    lists:reverse(S2).
