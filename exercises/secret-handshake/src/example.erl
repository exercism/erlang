-module(example).

-export([commands/1, test_version/0]).

commands(N) when N band 2#10000=:=2#10000 ->
	commands(N, [2#1000, 2#0100, 2#0010, 2#0001]);

commands(N) ->
	commands(N, [2#0001, 2#0010, 2#0100, 2#1000]).

commands(N, Bits) ->
	[action(X) || X <- Bits, N band X=:=X].

action(2#0001) -> "wink";
action(2#0010) -> "double blink";
action(2#0100) -> "close your eyes";
action(2#1000) -> "jump".

test_version() -> 1.
