-module(anagram_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

no_matches_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     [], Anagram:find("diaper", ["hello", "world", "zombies", "pants"])).

detect_simple_anagram_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     ["tan"], Anagram:find("ant", ["tan", "stand", "at"])).

does_not_confuse_different_duplicates_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     [], Anagram:find("galea", ["eagle"])).

eliminate_anagram_subsets_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     [], Anagram:find("good", ["dog", "goody"])).

detect_anagram_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     ["inlets"], Anagram:find("listen", ["enlists", "google", "inlets", "banana"])).

multiple_anagrams_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     ["gallery", "regally", "largely"],
     Anagram:find("allergy", ["gallery", "ballerina", "regally", "clergy", "largely", "leading"])).

case_insensitive_subject_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     ["carthorse"], Anagram:find("Orchestra", ["cashregister", "carthorse", "radishes"])).

case_insensitive_candidate_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     ["Carthorse"], Anagram:find("orchestra", ["cashregister", "Carthorse", "radishes"])).

does_not_detect_a_word_as_its_own_anagram_test() ->
  Anagram = sut(anagram),
  ?assertEqual(
     ["cron"], Anagram:find("corn", ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"])).
