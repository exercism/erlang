-module(example).

-export([count/2, nucleotide_counts/1, validate/1, test_version/0]).

count(Dna, N) ->
  validate(N),

  lists:foldl(
    fun(X, Sum) ->
        validate([X]),
        case [X] =:= N of
          true -> 1 + Sum;
          false -> Sum
        end
    end,
    0, Dna).

% Check if N is a valid nucleotide.
validate(N) ->
  case lists:member(N, ["A", "T", "C", "G"]) of
    true -> true;
    _ -> error(badarg)
  end.

nucleotide_counts(Dna) ->
  [{"A", count(Dna, "A")},
   {"T", count(Dna, "T")},
   {"C", count(Dna, "C")},
   {"G", count(Dna, "G")}].

test_version() ->
    1.
