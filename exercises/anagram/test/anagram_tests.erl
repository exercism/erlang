-module(anagram_tests).

-define(TESTED_MODULE, (sut(anagram))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").

no_matches_test() ->
  ?assertEqual(
     [], ?TESTED_MODULE:find("diaper", ["hello", "world", "zombies", "pants"])).

detect_simple_anagram_test() ->
  ?assertEqual(
     ["tan"], ?TESTED_MODULE:find("ant", ["tan", "stand", "at"])).

does_not_confuse_different_duplicates_test() ->
  ?assertEqual(
     [], ?TESTED_MODULE:find("galea", ["eagle"])).

eliminate_anagram_subsets_test() ->
  ?assertEqual(
     [], ?TESTED_MODULE:find("good", ["dog", "goody"])).

detect_anagram_test() ->
  ?assertEqual(
     ["inlets"], ?TESTED_MODULE:find("listen", ["enlists", "google", "inlets", "banana"])).

multiple_anagrams_test() ->
  ?assertEqual(
     ["gallery", "regally", "largely"],
     ?TESTED_MODULE:find("allergy", ["gallery", "ballerina", "regally", "clergy", "largely", "leading"])).

case_insensitive_subject_test() ->
  ?assertEqual(
     ["carthorse"], ?TESTED_MODULE:find("Orchestra", ["cashregister", "carthorse", "radishes"])).

case_insensitive_candidate_test() ->
  ?assertEqual(
     ["Carthorse"], ?TESTED_MODULE:find("orchestra", ["cashregister", "Carthorse", "radishes"])).

does_not_detect_a_word_as_its_own_anagram_test() ->
  ?assertEqual(
     ["cron"], ?TESTED_MODULE:find("corn", ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"])).
