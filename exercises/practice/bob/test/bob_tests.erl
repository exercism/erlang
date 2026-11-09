-module(bob_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_asking_a_question_test_'() ->
    {"asking a question",
     ?_assertMatch("Sure.",
		   bob:response("Does this cryogenic chamber make me "
				"look fat?"))}.

'2_shouting_test_'() ->
    {"shouting",
     ?_assertMatch("Whoa, chill out!",
		   bob:response("WATCH OUT!"))}.

'3_forceful_question_test_'() ->
    {"forceful question",
     ?_assertMatch("Calm down, I know what I'm doing!",
		   bob:response("WHAT'S GOING ON?"))}.

'4_silence_test_'() ->
    {"silence",
     ?_assertMatch("Fine. Be that way!", bob:response([]))}.

'5_stating_something_test_'() ->
    {"stating something",
     ?_assertMatch("Whatever.",
		   bob:response("Tom-ay-to, tom-aaaah-to."))}.

'6_asking_a_numeric_question_test_'() ->
    {"asking a numeric question",
     ?_assertMatch("Sure.",
		   bob:response("You are, what, like 15?"))}.

'7_asking_gibberish_test_'() ->
    {"asking gibberish",
     ?_assertMatch("Sure.", bob:response("fffbbcbeab?"))}.

'8_question_with_no_letters_test_'() ->
    {"question with no letters",
     ?_assertMatch("Sure.", bob:response("4?"))}.

'9_non_letters_with_question_test_'() ->
    {"non-letters with question",
     ?_assertMatch("Sure.", bob:response(":) ?"))}.

'10_prattling_on_test_'() ->
    {"prattling on",
     ?_assertMatch("Sure.",
		   bob:response("Wait! Hang on. Are you going to be OK?"))}.

'11_ending_with_whitespace_test_'() ->
    {"ending with whitespace",
     ?_assertMatch("Sure.",
		   bob:response("Okay if like my  spacebar  quite a bit?   "))}.

'12_multiple_line_question_test_'() ->
    {"multiple line question",
     ?_assertMatch("Sure.",
		   bob:response("\nDoes this cryogenic chamber make\n "
				"me look fat?"))}.

'13_shouting_gibberish_test_'() ->
    {"shouting gibberish",
     ?_assertMatch("Whoa, chill out!",
		   bob:response("FCECDFCAAB"))}.

'14_shouting_a_statement_containing_a_question_mark_test_'() ->
    {"shouting a statement containing a question mark",
     ?_assertMatch("Whoa, chill out!",
		   bob:response("DO LIONS EAT PEOPLE? AHHHHH."))}.

'15_shouting_numbers_test_'() ->
    {"shouting numbers",
     ?_assertMatch("Whoa, chill out!",
		   bob:response("1, 2, 3 GO!"))}.

'16_shouting_with_special_characters_test_'() ->
    {"shouting with special characters",
     ?_assertMatch("Whoa, chill out!",
		   bob:response("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"))}.

'17_shouting_with_no_exclamation_mark_test_'() ->
    {"shouting with no exclamation mark",
     ?_assertMatch("Whoa, chill out!",
		   bob:response("I HATE THE DENTIST"))}.

'18_prolonged_silence_test_'() ->
    {"prolonged silence",
     ?_assertMatch("Fine. Be that way!",
		   bob:response("          "))}.

'19_alternate_silence_test_'() ->
    {"alternate silence",
     ?_assertMatch("Fine. Be that way!",
		   bob:response("\t\t\t\t\t\t\t\t\t\t"))}.

'20_other_whitespace_test_'() ->
    {"other whitespace",
     ?_assertMatch("Fine. Be that way!",
		   bob:response("\n\r \t"))}.

'21_talking_forcefully_test_'() ->
    {"talking forcefully",
     ?_assertMatch("Whatever.", bob:response("Hi there!"))}.

'22_using_acronyms_in_regular_speech_test_'() ->
    {"using acronyms in regular speech",
     ?_assertMatch("Whatever.",
		   bob:response("It's OK if you don't want to go work "
				"for NASA."))}.

'23_no_letters_test_'() ->
    {"no letters",
     ?_assertMatch("Whatever.", bob:response("1, 2, 3"))}.

'24_statement_containing_question_mark_test_'() ->
    {"statement containing question mark",
     ?_assertMatch("Whatever.",
		   bob:response("Ending with ? means a question."))}.

'25_starting_with_whitespace_test_'() ->
    {"starting with whitespace",
     ?_assertMatch("Whatever.",
		   bob:response("         hmmmmmmm..."))}.

'26_non_question_ending_with_whitespace_test_'() ->
    {"non-question ending with whitespace",
     ?_assertMatch("Whatever.",
		   bob:response("This is a statement ending with whitespace "
				"     "))}.
