-module(example).
-export([rebase/3]).

rebase(_Input, SrcBase, _DstBase) when SrcBase < 2 ->
    {error, "input base must be >= 2"};
rebase(_Input, _SrcBase, DstBase) when DstBase < 2 ->
    {error, "output base must be >= 2"};
rebase(Input, SrcBase, DstBase) ->
    case lists:any(fun (D) -> D<0 orelse D>=SrcBase end, Input) of
        true -> {error, "all digits must satisfy 0 <= d < input base"};
        false -> output(to_base(to_dec(Input, SrcBase), DstBase))
    end.


output([]) ->
    {ok, [0]};
output(Digits) ->
    {ok, Digits}.


to_dec(Digits, Base) ->
    to_dec(Digits, Base, length(Digits)-1, 0).

to_dec([], _, _, Acc) ->
    Acc;
to_dec([D|More], Base, N, Acc) ->
    to_dec(More, Base, N-1, Acc+D*trunc(math:pow(Base, N))).


to_base(Num, Base) ->
    to_base(Num, Base, []).

to_base(0, _, Acc) ->
    Acc;
to_base(Num, Base, Acc) ->
    to_base(Num div Base, Base, [Num rem Base|Acc]).
