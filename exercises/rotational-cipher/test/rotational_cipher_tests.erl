-module(rotational_cipher_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

%%% To use this testsuite completely do run
%%% rebar3 do eunit, proper


%%% These tests are inspired by
%%% https://github.com/exercism/problem-specifications/blob/932c674a0554ad0db3645e9d2a473a515876d6eb/exercises/rotational-cipher/canonical-data.json
%%% But don't have a generic `rotate/2` function, but split the tests into
%%% encryption and decryption.
%%% Also some property based tests are added into the mix.

%% Encryption tests

encrypt_a_by_1_test() ->
  ?assertEqual("b", rotational_cipher:encrypt("a", 1)).

encrypt_a_by_26_same_output_as_input_test() ->
  ?assertEqual("a", rotational_cipher:encrypt("a", 26)).

encrypt_a_by_0_same_output_as_input_test() ->
  ?assertEqual("a", rotational_cipher:encrypt("a", 0)).

encrypt_m_by_13_test() ->
  ?assertEqual("m", rotational_cipher:encrypt("z", 13)).

encrypt_wraps_alphabet_test() ->
  ?assertEqual("a", rotational_cipher:encrypt("z", 1)).

encrypt_capital_letters_test() ->
  ?assertEqual("TRL", rotational_cipher:encrypt("OMG", 5)).

encrypt_spaces_test() ->
  ?assertEqual("T R L", rotational_cipher:encrypt("O M G", 5)).

encrypt_numbers_test() ->
  ?assertEqual("Xiwxmrk 1 2 3 xiwxmrk", rotational_cipher:encrypt("Testing 1 2 3 testing", 4)).

encrypt_punctuation_test() ->
  ?assertEqual("Gzo'n zvo, Bmviyhv!", rotational_cipher:encrypt("Let's eat, Grandma!", 21)).

encrypt_all_letters_test() ->
  ?assertEqual("Gur dhvpx oebja sbk whzcf bire gur ynml qbt.", rotational_cipher:encrypt("The quick brown fox jumps over the lazy dog.", 13)).

%% Decryption tests

decrypt_b_by_1_test() ->
  ?assertEqual("a", rotational_cipher:decrypt("b", 1)).

decrypt_a_by_26_same_output_as_input_test() ->
  ?assertEqual("a", rotational_cipher:decrypt("a", 26)).

decrypt_a_by_0_same_output_as_input_test() ->
  ?assertEqual("a", rotational_cipher:decrypt("a", 0)).

decrypt_z_by_13_test() ->
  ?assertEqual("z", rotational_cipher:decrypt("m", 13)).

decrypt_wraps_alphabet_test() ->
  ?assertEqual("z", rotational_cipher:decrypt("a", 1)).

decrypt_capital_letters_test() ->
  ?assertEqual("OMG", rotational_cipher:decrypt("TRL", 5)).

decrypt_spaces_test() ->
  ?assertEqual("O M G", rotational_cipher:decrypt("T R L", 5)).

decrypt_numbers_test() ->
  ?assertEqual("Testing 1 2 3 testing", rotational_cipher:decrypt("Xiwxmrk 1 2 3 xiwxmrk", 4)).

decrypt_punctuation_test() ->
  ?assertEqual("Let's eat, Grandma!", rotational_cipher:decrypt("Gzo'n zvo, Bmviyhv!", 21)).

decrypt_all_letters_test() ->
  ?assertEqual("The quick brown fox jumps over the lazy dog.", rotational_cipher:decrypt("Gur dhvpx oebja sbk whzcf bire gur ynml qbt.", 13)).

%%% Properties tested via `proper`
%
%prop_decrypt_encrypt_is_id() ->
%  ?FORALL({Input, N}, {string(), integer(0,26)},
%    rotational_cipher:decrypt(rotational_cipher:encrypt(Input, N), N) == Input).
%
%prop_decrypt_is_encrypt_with_another_key() ->
%  ?FORALL({Input, N}, {string(), integer(0,26)},
%    rotational_cipher:decrypt(Input, 26 - N) == rotational_cipher:encrypt(Input, N)).
%
%prop_encrypt_13_twice_is_id() ->
%  ?FORALL(Input, string(),
%    rotational_cipher:encrypt(rotational_cipher:encrypt(Input, 13), 13) == Input).
%
%prop_decrypt_13_twice_is_id() ->
%  ?FORALL(Input, string(),
%    rotational_cipher:decrypt(rotational_cipher:decrypt(Input, 13), 13) == Input).
%

version_test() ->
  ?assertMatch(1, rotational_cipher:test_version()).
