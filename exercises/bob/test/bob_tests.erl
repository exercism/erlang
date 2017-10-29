-module(bob_tests).

-define(TESTED_MODULE, (sut(bob))).
-define(TEST_VERSION, 2).
-include("exercism.hrl").


stating_something_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("Tom-ay-to, tom-aaaah-to.")).

shouting_test() ->
    ?assertMatch("Whoa, chill out!",
		 ?TESTED_MODULE:response("WATCH OUT!")).

shouting_gibberish_test() ->
    ?assertMatch("Whoa, chill out!",
		 ?TESTED_MODULE:response("FCECDFCAAB")).

asking_a_question_test() ->
    ?assertMatch("Sure.",
		 ?TESTED_MODULE:response("Does this cryogenic chamber make me "
					 "look fat?")).

asking_a_numeric_question_test() ->
    ?assertMatch("Sure.",
		 ?TESTED_MODULE:response("You are, what, like 15?")).

asking_gibberish_test() ->
    ?assertMatch("Sure.",
		 ?TESTED_MODULE:response("fffbbcbeab?")).

talking_forcefully_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("Let's go make out behind the gym!")).

using_acronyms_in_regular_speech_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("It's OK if you don't want to go to the "
					 "DMV.")).

forceful_question_test() ->
    ?assertMatch("Whoa, chill out!",
		 ?TESTED_MODULE:response("WHAT THE HELL WERE YOU THINKING?")).

shouting_numbers_test() ->
    ?assertMatch("Whoa, chill out!",
		 ?TESTED_MODULE:response("1, 2, 3 GO!")).

only_numbers_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("1, 2, 3")).

question_with_only_numbers_test() ->
    ?assertMatch("Sure.", ?TESTED_MODULE:response("4?")).

shouting_with_special_characters_test() ->
    ?assertMatch("Whoa, chill out!",
		 ?TESTED_MODULE:response("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")).

shouting_with_no_exclamation_mark_test() ->
    ?assertMatch("Whoa, chill out!",
		 ?TESTED_MODULE:response("I HATE YOU")).

statement_containing_question_mark_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("Ending with ? means a question.")).

non_letters_with_question_test() ->
    ?assertMatch("Sure.", ?TESTED_MODULE:response(":) ?")).

prattling_on_test() ->
    ?assertMatch("Sure.",
		 ?TESTED_MODULE:response("Wait! Hang on. Are you going to be OK?")).

silence_test() ->
    ?assertMatch("Fine. Be that way!",
		 ?TESTED_MODULE:response([])).

prolonged_silence_test() ->
    ?assertMatch("Fine. Be that way!",
		 ?TESTED_MODULE:response("          ")).

alternate_silence_test() ->
    ?assertMatch("Fine. Be that way!",
		 ?TESTED_MODULE:response("\t\t\t\t\t\t\t\t\t\t")).

multiple_line_question_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("\nDoes this cryogenic chamber make me "
					 "look fat?\nno")).

starting_with_whitespace_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("         hmmmmmmm...")).

ending_with_whitespace_test() ->
    ?assertMatch("Sure.",
		 ?TESTED_MODULE:response("Okay if like my  spacebar  quite a bit?   ")).

other_whitespace_test() ->
    ?assertMatch("Fine. Be that way!",
		 ?TESTED_MODULE:response("\n\r \t")).

non_question_ending_with_whitespace_test() ->
    ?assertMatch("Whatever.",
		 ?TESTED_MODULE:response("This is a statement ending with whitespace "
					 "     ")).
