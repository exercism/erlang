-module(example).
-export([to_rna/1, test_version/0]).

to_rna(Strand) ->
    lists:map(fun transcribe_to_rna/1, Strand).

test_version() ->
    3.



transcribe_to_rna($G) ->
  $C;
transcribe_to_rna($C) ->
  $G;
transcribe_to_rna($T) ->
  $A;
transcribe_to_rna($A) ->
  $U.
