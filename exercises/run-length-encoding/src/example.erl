-module(example).

-export([encode/1, decode/1, test_version/0]).

encode(String) ->
	lists:flatten(encode_string(String)).

decode(String) ->
	lists:flatten(decode_string(String)).


encode_string(String) ->
	encode_string(String, []).

encode_string([], Acc) ->
	lists:filtermap(
		fun
			({0, _}) -> false;
			({1, C}) -> {true, C};
			({N, C}) -> {true, [integer_to_list(N)|[C]]}
		end,
		lists:reverse(Acc)
	);

encode_string(String, Acc) ->
	{NC, More}=encode_sequence(String),
	encode_string(More, [NC|Acc]).

encode_sequence(String=[C|_]) ->
	encode_sequence(String, C, 0).

encode_sequence([], C, N) ->
	{{N, C}, []};

encode_sequence([C|More], C, N) ->
	encode_sequence(More, C, N+1);

encode_sequence(Rest, C, N) ->
	{{N, C}, Rest}.


decode_string(String) ->
	decode_string(String, []).

decode_string([], Acc) ->
	lists:reverse(Acc);

decode_string(String, Acc) ->
	{Seq, More}=decode_sequence(String),
	decode_string(More, [Seq|Acc]).

decode_sequence(String) ->
	decode_sequence(String, []).

decode_sequence([N|More], Acc) when N>=$0 andalso N=<$9 ->
	decode_sequence(More, [N|Acc]);

decode_sequence([C|More], []) ->
	{[C], More};

decode_sequence([C|More], Acc) ->
	N=list_to_integer(lists:reverse(Acc)),
	Seq=[C || _ <- lists:seq(1, N)],
	{Seq, More}.


test_version() -> 1.
