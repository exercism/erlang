-module(example).

-export([encode/1, decode/1]).

encode(Integers) ->
	lists:flatten([encode_integer(I) || I <- Integers]).

encode_integer(Integer) ->
	<<B1:4, Rest:28>> = <<Integer:32>>,
	RestBytes=[I || <<I:7>> <= <<Rest:28>>],
	flag_bytes([B1|RestBytes]).

flag_bytes(Bytes) ->
	flag_bytes(Bytes, []).
flag_bytes([], Acc) ->
	Acc;
flag_bytes([B], Acc) ->
	lists:reverse([B|Acc]);
flag_bytes([0|More], Acc=[]) ->
	flag_bytes(More, Acc);
flag_bytes([B|More], Acc) ->
	flag_bytes(More, [B bor 16#80 | Acc]).



decode(Integers) ->
	case get_bytegroups(Integers) of
		undefined -> undefined;
		ByteGroups -> [decode_bytegroup(G) || G <- ByteGroups]
	end.

get_bytegroups(Bytes) ->
	get_bytegroups(Bytes, false, [[]]).

get_bytegroups([], true, [Last|Acc]) ->
	lists:reverse([lists:reverse(Last)|Acc]);
get_bytegroups([], false, _) ->
	undefined;
get_bytegroups(More, true, [Last|Acc]) ->
	get_bytegroups(More, false, [[], lists:reverse(Last)|Acc]);
get_bytegroups([B|More], false, [Last|Acc]) when B band 16#80=:=16#80 ->
	get_bytegroups(More, false, [[B band 16#7F|Last]|Acc]);
get_bytegroups([B|More], false, [Last|Acc]) ->
	get_bytegroups(More, true, [[B|Last]|Acc]).

decode_bytegroup(Bytes) ->
	Tmp= << <<I:7/integer>> || I <- Bytes >>,
	Size=bit_size(Tmp),
	<<Integer:Size/integer>>=Tmp,
	Integer.
