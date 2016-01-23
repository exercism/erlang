-module(anagram_tests).
-include_lib("eunit/include/eunit.hrl").

no_matches_test() ->
  ?assertEqual(
     [], anagram:find("diaper", ["hello", "world", "zombies", "pants"])).

detect_simple_anagram_test() ->
  ?assertEqual(
     ["tan"], anagram:find("ant", ["tan", "stand", "at"])).

does_not_confuse_different_duplicates_test() ->
  ?assertEqual(
     [], anagram:find("galea", ["eagle"])).

eliminate_anagram_subsets_test() ->
  ?assertEqual(
     [], anagram:find("good", ["dog", "goody"])).

detect_anagram_test() ->
  ?assertEqual(
     ["inlets"], anagram:find("listen", ["enlists", "google", "inlets", "banana"])).

multiple_anagrams_test() ->
  ?assertEqual(
     ["gallery", "regally", "largely"],
     anagram:find("allergy", ["gallery", "ballerina", "regally", "clergy", "largely", "leading"])).

case_insensitive_subject_test() ->
  ?assertEqual(
     ["carthorse"], anagram:find("Orchestra", ["cashregister", "carthorse", "radishes"])).

case_insensitive_candidate_test() ->
  ?assertEqual(
     ["Carthorse"], anagram:find("orchestra", ["cashregister", "Carthorse", "radishes"])).

does_not_detect_a_word_as_its_own_anagram_test() ->
  ?assertEqual(
     ["cron"], anagram:find("corn", ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"])).
