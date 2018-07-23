-module(example).

-export([ciphertext/1, test_version/0]).

ciphertext(Plaintext) ->
	Normalized=normalize(Plaintext),
	Dim=calc_dimension(Normalized),
	encode(Normalized, Dim).

normalize(S) ->
	normalize(S, []).

normalize([], Acc) ->
	lists:reverse(Acc);

normalize([C|More], Acc) when C>=$a andalso C=<$z orelse C>=$0 andalso C=<$9 ->
	normalize(More, [C|Acc]);

normalize([C|More], Acc) when C>=$A andalso C=<$Z ->
	normalize(More, [C-$A+$a|Acc]);

normalize([_|More], Acc) ->
	normalize(More, Acc).

calc_dimension(S) ->
	L=length(S),
	Tmp=math:sqrt(L),
	R=trunc(Tmp),
	C=ceiling(Tmp),
	{C, R}.

ceiling(N) ->
	Tmp=trunc(N),
	if
		Tmp-N<0 -> Tmp+1;
		true -> Tmp
	end.

encode([], _) ->
	[];

encode(S, {C, _}) ->
	Split=split(S, C),
	Transposed=transpose(Split),
	flatjoin(Transposed).

flatjoin(L) ->
	flatjoin(L, []).

flatjoin([], Acc) ->
	Acc;

flatjoin([E|More], []) ->
	flatjoin(More, E);

flatjoin([E|More], Acc) ->
	flatjoin(More, Acc++[16#20|E]).


split(S, L) ->
	split(S, L, []).

split([], _, Acc) ->
	lists:reverse(Acc);

split(S, L, Acc) when length(S)<L ->
	lists:reverse([S++[16#20 || _ <- lists:seq(length(S)+1, L)]|Acc]);

split(S, L, Acc) ->
	{Chunk, More}=lists:split(L, S),
	split(More, L, [Chunk|Acc]).

transpose([[]|_]) ->
	[];

transpose(Matrix) ->
	[lists:map(fun hd/1, Matrix) | transpose(lists:map(fun tl/1, Matrix))].

test_version() -> 1.
