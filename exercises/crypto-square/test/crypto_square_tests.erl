%% based on canonical data version 3.2.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/crypto-square/canonical-data.json

-module(crypto_square_tests).

-define(TESTED_MODULE, (sut(crypto_square))).
-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

plaintext_empty_test() ->
	?assertMatch("", crypto_square:ciphertext("")).

lowercase_test() ->
	?assertMatch("a", crypto_square:ciphertext("A")).

remove_spaces_test() ->
	?assertMatch("b", crypto_square:ciphertext("  b ")).

remove_punctuation_test() ->
	?assertMatch("1", crypto_square:ciphertext("@1,%!")).

plaintext_9_chars_test() ->
	?assertMatch("tsf hiu isn", crypto_square:ciphertext("This is fun!")).

plaintext_8_chars_test() ->
	?assertMatch("clu hlt io ", crypto_square:ciphertext("Chill out.")).

plaintext_54_chars_test() ->
	?assertMatch("imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau ", crypto_square:ciphertext("If man was meant to stay on the ground, god would have given us roots.")).

version_test() ->
	?assertMatch(?TEST_VERSION, crypto_square:test_version()).
