-module(example).

-export([classify/1, test_version/0]).

classify(1) ->
	deficient;

classify(N) when N>1 ->
	classify(N, aliquot(N));

classify(_) ->
	{error, "Classification is only possible for natural numbers."}.

classify(N, N) ->
	perfect;

classify(N, Aliquot) when N<Aliquot ->
	abundant;

classify(_, _) ->
	deficient.

aliquot(N) ->
	aliquot(N, N div 2, 0).

aliquot(_, 0, Acc) ->
	Acc;

aliquot(N, D, Acc) when N rem D=:=0 ->
	aliquot(N, D-1, Acc+D);

aliquot(N, D, Acc) ->
	aliquot(N, D-1, Acc).

test_version() -> 1.
