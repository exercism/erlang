-module(example).

-export([is_paired/1]).

is_paired(Str) -> is_paired(Str, []).

is_paired([], Stack) -> Stack=:=[];
is_paired([C|More], Stack) when C=:=${ orelse C=:=$[ orelse C=:=$( -> is_paired(More, [C|Stack]);
is_paired([$}|More], [${|Stack]) -> is_paired(More, Stack);
is_paired([$]|More], [$[|Stack]) -> is_paired(More, Stack);
is_paired([$)|More], [$(|Stack]) -> is_paired(More, Stack);
is_paired([C|_], _) when C=:=$} orelse C=:=$] orelse C=:=$)-> false;
is_paired([_|More], Stack) -> is_paired(More, Stack).
