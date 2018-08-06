-module(example).

-export([smallest/2, largest/2, test_version/0]).


smallest(Min, Max) when Min>Max -> {error, invalid_range};

smallest(Min, Max) ->
	case smallest(Min, Max, Min, Min, undefined) of
		undefined -> undefined;
		{N, Factors} -> {N, dedup_factors(Factors)}
	end.

smallest(_, Max, Cur1, Cur2, Best) when Cur1>Max andalso Cur2>Max ->
	Best;

smallest(Min, Max, Cur1, Cur2, Best) when Cur2>Max ->
	smallest(Min, Max, Cur1+1, Cur1+1, Best);

smallest(Min, Max, Cur1, Cur2, undefined) ->
	Candidate=Cur1*Cur2,
	case is_palindrome(Candidate) of
		false -> smallest(Min, Max, Cur1, Cur2+1, undefined);
		true -> smallest(Min, Max, Cur1+1, Cur1+1, {Candidate, [{Cur1, Cur2}]})
	end;

smallest(Min, Max, Cur1, Cur2, Best={BestProduct, _}) when Cur1*Cur2>BestProduct ->
	smallest(Min, Max, Cur1+1, Cur1+1, Best);

smallest(Min, Max, Cur1, Cur2, {BestProduct, BestFactors}) when Cur1*Cur2=:=BestProduct ->
	smallest(Min, Max, Cur1+1, Cur1+1, {BestProduct, [{Cur1, Cur2}|BestFactors]});

smallest(Min, Max, Cur1, Cur2, Best) ->
	Candidate=Cur1*Cur2,
	case is_palindrome(Candidate) of
		true -> smallest(Min, Max, Cur1+1, Cur1+1, {Candidate, [{Cur1, Cur2}]});
		false -> smallest(Min, Max, Cur1, Cur2+1, Best)
	end.


largest(Min, Max) when Min>Max -> {error, invalid_range};

largest(Min, Max) ->
	case largest(Min, Max, Max, Max, undefined) of
		undefined -> undefined;
		{N, Factors} -> {N, dedup_factors(Factors)}
	end.

largest(Min, _, Cur1, _, Best) when Cur1<Min ->
	Best;

largest(Min, Max, Cur1, Cur2, Best) when Cur2<Min ->
	largest(Min, Max, Cur1-1, Max, Best);

largest(Min, Max, Cur1, Cur2, undefined) ->
	Candidate=Cur1*Cur2,
	case is_palindrome(Candidate) of
		false -> largest(Min, Max, Cur1, Cur2-1, undefined);
		true -> largest(Min, Max, Cur1-1, Max, {Candidate, [{Cur1, Cur2}]})
	end;

largest(Min, Max, Cur1, Cur2, Best={BestProduct, _}) when Cur1*Cur2<BestProduct ->
	largest(Min, Max, Cur1-1, Max, Best);

largest(Min, Max, Cur1, Cur2, {BestProduct, BestFactors}) when Cur1*Cur2=:=BestProduct ->
	largest(Min, Max, Cur1-1, Max, {BestProduct, [{Cur1, Cur2}|BestFactors]});

largest(Min, Max, Cur1, Cur2, Best) ->
	Candidate=Cur1*Cur2,
	case is_palindrome(Candidate) of
		true -> largest(Min, Max, Cur1-1, Max, {Candidate, [{Cur1, Cur2}]});
		false -> largest(Min, Max, Cur1, Cur2-1, Best)
	end.


is_palindrome(Candidate) ->
	Candidate2=integer_to_list(Candidate),
	Candidate2=:=lists:reverse(Candidate2).


dedup_factors(Factors) ->
	lists:usort(
		fun
			({A1, A2}, {B1, B2}) -> min(A1, A2)=<min(B1, B2)
		end,
		Factors
	).


test_version() -> 1.
