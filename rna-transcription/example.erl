-module(dna).
-export([to_rna/1]).

to_rna(Strand) ->
  lists:map(fun transcribe_to_rna/1, Strand).

transcribe_to_rna($G) ->
     $C;
transcribe_to_rna($C) ->
     $G;
transcribe_to_rna($T) ->
     $A;
transcribe_to_rna($A) ->
     $U.
