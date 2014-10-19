-module( rna_transcription ).
-export( [from_dna/1] ).

from_dna( Strand ) -> lists:map( fun transcribe_to_rna/1, Strand ).



transcribe_to_rna($T) ->
     $U;
transcribe_to_rna(Nucleotide) ->
    Nucleotide.
