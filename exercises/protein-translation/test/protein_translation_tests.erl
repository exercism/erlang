%% based on canonical data version 1.1.1
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/protein-translation/canonical-data.json

-module(protein_translation_tests).

-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

methionine_rna_sequence_test() ->
	Input="AUG",
	Expected=[methionine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

phenylalanine_rna_sequence_1_test() ->
	Input="UUU",
	Expected=[phenylalanine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

phenylalanine_rna_sequence_2_test() ->
	Input="UUC",
	Expected=[phenylalanine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

leucine_rna_sequence_1_test() ->
	Input="UUA",
	Expected=[leucine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

leucine_rna_sequence_2_test() ->
	Input="UUG",
	Expected=[leucine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

serine_rna_sequence_1_test() ->
	Input="UCU",
	Expected=[serine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

serine_rna_sequence_2_test() ->
	Input="UCC",
	Expected=[serine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

serine_rna_sequence_3_test() ->
	Input="UCA",
	Expected=[serine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

serine_rna_sequence_4_test() ->
	Input="UCG",
	Expected=[serine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

tyrosine_rna_sequence_1_test() ->
	Input="UAU",
	Expected=[tyrosine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

tyrosine_rna_sequence_2_test() ->
	Input="UAC",
	Expected=[tyrosine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

cysteine_rna_sequence_1_test() ->
	Input="UGU",
	Expected=[cysteine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

cysteine_rna_sequence_2_test() ->
	Input="UGC",
	Expected=[cysteine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

tryptophan_rna_sequence_test() ->
	Input="UGG",
	Expected=[tryptophan],
	?assertMatch(Expected, protein_translation:proteins(Input)).

stop_codon_rna_sequence_1_test() ->
	Input="UAA",
	Expected=[],
	?assertMatch(Expected, protein_translation:proteins(Input)).

stop_codon_rna_sequence_2_test() ->
	Input="UAG",
	Expected=[],
	?assertMatch(Expected, protein_translation:proteins(Input)).

stop_codon_rna_sequence_3_test() ->
	Input="UGA",
	Expected=[],
	?assertMatch(Expected, protein_translation:proteins(Input)).

translate_rna_strand_into_correct_protein_list_test() ->
	Input="AUGUUUUGG",
	Expected=[methionine, phenylalanine, tryptophan],
	?assertMatch(Expected, protein_translation:proteins(Input)).

translation_stops_if_stop_codon_at_beginning_of_sequence_test() ->
	Input="UAGUGG",
	Expected=[],
	?assertMatch(Expected, protein_translation:proteins(Input)).

translation_stops_if_stop_codon_at_end_of_two_codon_sequence_test() ->
	Input="UGGUAG",
	Expected=[tryptophan],
	?assertMatch(Expected, protein_translation:proteins(Input)).

translation_stops_if_stop_codon_at_end_of_three_codon_sequence_test() ->
	Input="AUGUUUUAA",
	Expected=[methionine, phenylalanine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

translation_stops_if_stop_codon_in_middle_of_three_codon_sequence_test() ->
	Input="UGGUAGUGG",
	Expected=[tryptophan],
	?assertMatch(Expected, protein_translation:proteins(Input)).

translation_stops_if_stop_codon_in_middle_of_six_codon_sequence_test() ->
	Input="UGGUGUUAUUAAUGGUUU",
	Expected=[tryptophan, cysteine, tyrosine],
	?assertMatch(Expected, protein_translation:proteins(Input)).

version_test() ->
	?assertMatch(?TEST_VERSION, protein_translation:test_version()).
