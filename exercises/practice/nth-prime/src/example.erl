-module(example).

-export([prime/1]).


prime(N) when is_integer(N), N>0 ->
	Generator=prime_generator(),
	prime(Generator, N, []).

prime(Generator, N, KnownPrimes0) when length(KnownPrimes0)<N ->
	Next=next_candidate(Generator),
	KnownPrimes1=case is_prime(Next, KnownPrimes0) of
		true -> KnownPrimes0++[Next];
		false -> KnownPrimes0
	end,
	prime(Generator, N, KnownPrimes1);
prime(_, _, Primes) ->
	lists:last(Primes).

is_prime(Candidate, KnownPrimes) ->
	SqrtCandidate=math:sqrt(Candidate),
	is_prime(Candidate, SqrtCandidate, KnownPrimes).

is_prime(_, _, []) ->
	true;
is_prime(_, SqrtCandidate, [KnownPrime|_]) when KnownPrime>SqrtCandidate ->
	true;
is_prime(Candidate, _, [KnownPrime|_]) when Candidate rem KnownPrime=:=0 ->
	false;
is_prime(Candidate, SqrtCandidate, [_|KnownPrimes]) ->
	is_prime(Candidate, SqrtCandidate, KnownPrimes).

next_candidate(Generator) ->
	Candidate=receive {Generator, Candidate1} -> Candidate1 end,
	Generator ! {self(), next},
	Candidate.

prime_generator() ->
	Generator=spawn_link(
		fun () -> prime_generator_loop() end
	),
	Generator ! {self(), next},
	Generator.

prime_generator_loop() ->
	prime_generator_loop(2).

prime_generator_loop(2) ->
	receive {Reply, next} -> Reply ! {self(), 2} end,
	prime_generator_loop(3);
prime_generator_loop(3) ->
	receive {Reply, next} -> Reply ! {self(), 3} end,
	prime_generator_loop(6);
prime_generator_loop(N) ->
	receive {Reply1, next} -> Reply1 ! {self(), N-1} end,
	receive {Reply2, next} -> Reply2 ! {self(), N+1} end,
	prime_generator_loop(N+6).
