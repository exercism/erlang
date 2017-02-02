-module(atbash_cipher_tests).

-define(TESTED_MODULE, (sut(atbash_cipher))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").

encode(Str) ->
    ?TESTED_MODULE:encode(Str).

decode(Str) ->
    ?TESTED_MODULE:decode(Str).

encode_no_test() ->
    ?assertEqual("ml", encode("no")).

encode_yes_test() ->
    ?assertEqual("bvh", encode("yes")).

encode_OMG_test() ->
    ?assertEqual("lnt", encode("OMG")).

encode_O_M_G_test() ->
    ?assertEqual("lnt", encode("O M G")).

encode_long_word_test() ->
    ?assertEqual("nrmwy oldrm tob", encode("mindblowingly")).

encode_numbers_test() ->
    ?assertEqual("gvhgr mt123 gvhgr mt",
                 encode("Testing, 1 2 3, testing.")).

encode_sentence_test() ->
    ?assertEqual("gifgs rhurx grlm",
                 encode("Truth is fiction.")).

encode_all_things_test() ->
    Plaintext = "The quick brown fox jumps over the lazy dog.",
    Ciphertext = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt",
    ?assertEqual(Ciphertext, encode(Plaintext)).

decode_word_test() ->
    ?assertEqual("exercism", decode("vcvix rhn")).

decode_sentence_test() ->
    ?assertEqual("anobstacleisoftenasteppingstone",
                 decode("zmlyh gzxov rhlug vmzhg vkkrm thglm v")).
