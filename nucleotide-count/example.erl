-module( nucleotide_count ).
-compile(export_all).
-export( [count/2, dna/1, validate/1] ).

count(Dna, N) ->
    validate_strand(Dna),

    lists:foldl(
      fun(X, Sum) ->
              case [X] =:= N of
                  true -> 1 + Sum;
                  false -> Sum
              end
      end,
      0, Dna).


validate_strand("") -> true;
validate_strand(Strand) ->
  lists:all( fun validate/1, Strand).

validate(N) ->
    case lists:member(N, "ATCGU") of
        true -> true;
        _ -> erlang:error("Invalid nucleotide")
    end.

dna( Dna ) ->
    {{"A", count(Dna, "A")},
     {"T", count(Dna, "T")},
     {"C", count(Dna, "C")},
     {"G", count(Dna, "G")}}.
