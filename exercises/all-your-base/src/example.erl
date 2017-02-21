-module(example).
-export([convert/3, test_version/0]).

convert(_Input, SrcBase, _DstBase) when SrcBase < 2 ->
  {error, invalid_src_base};
convert(_Input, _SrcBase, DstBase) when DstBase < 2 ->
  {error, invalid_dst_base};
convert(Input, SrcBase, DstBase) ->
  case internalize(Input, SrcBase, 0) of
    {ok, Value} -> externalize(Value, DstBase, []);
    {error, Reason} -> {error, Reason}
  end.

test_version() ->
  1.



internalize([], _, Acc) ->
  {ok, Acc};
internalize([H|_], _Base, _Acc) when H < 0 ->
  {error, negative};
internalize([H|_], Base, _Acc) when H >= Base ->
  {error, not_in_base};
internalize([H|T], Base, Acc) ->
  internalize(T, Base, Acc * Base + H).

externalize(0, Base, Acc) ->
  {ok, Acc};
externalize(Input, Base, Acc) ->
  Digit = Input rem Base,
  Input2 = Input div Base,
  externalize(Input2, Base, [Digit|Acc]).
