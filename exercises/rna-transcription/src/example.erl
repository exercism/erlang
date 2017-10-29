-module(example).
-export([to_rna/1, test_version/0]).

to_rna(Strand) ->
    try lists:map(fun transcribe_to_rna/1, Strand) of
        Result -> Result
    catch
        _:_ -> error
    end.

test_version() ->
    2.



transcribe_to_rna($G) ->
  $C;
transcribe_to_rna($C) ->
  $G;
transcribe_to_rna($T) ->
  $A;
transcribe_to_rna($A) ->
  $U.
