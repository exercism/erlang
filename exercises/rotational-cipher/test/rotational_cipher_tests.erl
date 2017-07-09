-module(rotational_cipher_tests).

-define(TESTED_MODULE, (sut(rotational_cipher))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").

%%% To use this testsuite completely do run
%%% rebar3 do eunit, proper


%%% These tests are inspired by
%%% https://github.com/exercism/problem-specifications/blob/932c674a0554ad0db3645e9d2a473a515876d6eb/exercises/rotational-cipher/canonical-data.json
%%% But don't have a generic `rotate/2` function, but split the tests into
%%% encryption and decryption.
%%% Also some property based tests are added into the mix.

%% Encryption tests

encrypt_a_by_1_test() ->
  ?assertEqual("b", ?TESTED_MODULE:encrypt("a", 1)).

encrypt_a_by_26_same_output_as_input_test() ->
  ?assertEqual("a", ?TESTED_MODULE:encrypt("a", 26)).

encrypt_a_by_0_same_output_as_input_test() ->
  ?assertEqual("a", ?TESTED_MODULE:encrypt("a", 0)).

encrypt_m_by_13_test() ->
  ?assertEqual("m", ?TESTED_MODULE:encrypt("z", 13)).

encrypt_wraps_alphabet_test() ->
  ?assertEqual("a", ?TESTED_MODULE:encrypt("z", 1)).

encrypt_capital_letters_test() ->
  ?assertEqual("TRL", ?TESTED_MODULE:encrypt("OMG", 5)).

encrypt_spaces_test() ->
  ?assertEqual("T R L", ?TESTED_MODULE:encrypt("O M G", 5)).

encrypt_numbers_test() ->
  ?assertEqual("Xiwxmrk 1 2 3 xiwxmrk", ?TESTED_MODULE:encrypt("Testing 1 2 3 testing", 4)).

encrypt_punctuation_test() ->
  ?assertEqual("Gzo'n zvo, Bmviyhv!", ?TESTED_MODULE:encrypt("Let's eat, Grandma!", 21)).

encrypt_all_letters_test() ->
  ?assertEqual("Gur dhvpx oebja sbk whzcf bire gur ynml qbt.", ?TESTED_MODULE:encrypt("The quick brown fox jumps over the lazy dog.", 13)).

%% Decryption tests

decrypt_b_by_1_test() ->
  ?assertEqual("a", ?TESTED_MODULE:decrypt("b", 1)).

decrypt_a_by_26_same_output_as_input_test() ->
  ?assertEqual("a", ?TESTED_MODULE:decrypt("a", 26)).

decrypt_a_by_0_same_output_as_input_test() ->
  ?assertEqual("a", ?TESTED_MODULE:decrypt("a", 0)).

decrypt_z_by_13_test() ->
  ?assertEqual("z", ?TESTED_MODULE:decrypt("m", 13)).

decrypt_wraps_alphabet_test() ->
  ?assertEqual("z", ?TESTED_MODULE:decrypt("a", 1)).

decrypt_capital_letters_test() ->
  ?assertEqual("OMG", ?TESTED_MODULE:decrypt("TRL", 5)).

decrypt_spaces_test() ->
  ?assertEqual("O M G", ?TESTED_MODULE:decrypt("T R L", 5)).

decrypt_numbers_test() ->
  ?assertEqual("Testing 1 2 3 testing", ?TESTED_MODULE:decrypt("Xiwxmrk 1 2 3 xiwxmrk", 4)).

decrypt_punctuation_test() ->
  ?assertEqual("Let's eat, Grandma!", ?TESTED_MODULE:decrypt("Gzo'n zvo, Bmviyhv!", 21)).

decrypt_all_letters_test() ->
  ?assertEqual("The quick brown fox jumps over the lazy dog.", ?TESTED_MODULE:decrypt("Gur dhvpx oebja sbk whzcf bire gur ynml qbt.", 13)).

%%% Properties tested via `proper`
%
%prop_decrypt_encrypt_is_id() ->
%  ?FORALL({Input, N}, {string(), integer(0,26)},
%    ?TESTED_MODULE:decrypt(?TESTED_MODULE:encrypt(Input, N), N) == Input).
%
%prop_decrypt_is_encrypt_with_another_key() ->
%  ?FORALL({Input, N}, {string(), integer(0,26)},
%    ?TESTED_MODULE:decrypt(Input, 26 - N) == ?TESTED_MODULE:encrypt(Input, N)).
%
%prop_encrypt_13_twice_is_id() ->
%  ?FORALL(Input, string(),
%    ?TESTED_MODULE:encrypt(?TESTED_MODULE:encrypt(Input, 13), 13) == Input).
%
%prop_decrypt_13_twice_is_id() ->
%  ?FORALL(Input, string(),
%    ?TESTED_MODULE:decrypt(?TESTED_MODULE:decrypt(Input, 13), 13) == Input).
%
