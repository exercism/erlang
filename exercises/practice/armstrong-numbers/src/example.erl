-module(example).

-export([is_armstrong_number/1]).

is_armstrong_number(N) ->
	{Digits, Count}=to_digits(N),
	N==calc_number(Digits, Count).

calc_number(Digits, Count) ->
	calc_number(Digits, Count, 0).

calc_number([], _, Acc) ->
	Acc;

calc_number([Digit|More], Count, Acc) ->
	calc_number(More, Count, Acc+trunc(math:pow(Digit, Count))).

to_digits(N) ->
	to_digits(N, [], 0).

to_digits(0, AccD, AccN) ->
	{AccD, AccN};

to_digits(N, Digits, Count) ->
	Digit=N rem 10,
	NewN=N div 10,
	to_digits(NewN, [Digit|Digits], Count+1).
