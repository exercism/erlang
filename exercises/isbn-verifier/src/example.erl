-module(example).

-export([is_valid/1, test_version/0]).

is_valid(Isbn) -> is_valid(Isbn, 10, 0).

is_valid([], 0, Acc) -> Acc rem 11=:=0;
is_valid([$-|More], N, Acc) -> is_valid(More, N, Acc);
is_valid([$X|More], 1, Acc) -> is_valid(More, 0, Acc+10);
is_valid([C|More], N, Acc) when C>=$0 andalso C=<$9 -> is_valid(More, N-1, Acc+N*(C-$0));
is_valid(_, _, _) -> false.

test_version() -> 1.
