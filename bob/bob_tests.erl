-module( bob_tests ).

-include_lib("eunit/include/eunit.hrl").

responds_to_something_test() ->
    ?assertEqual((bob:response_for("Tom-ay-to, tom-aaaah-to.")),
                 "Whatever.").

responds_to_shouts_test() ->
    ?assertEqual((bob:response_for("WATCH OUT!")), "Woah, chill out!").

responds_to_questions_test() ->
    ?assertEqual((bob:response_for("Does this cryogenic chamber make me look fat?")),
                 "Sure.").

responds_to_forceful_talking_test() ->
    ?assertEqual((bob:response_for("Let's go make out behind the gym!")),
                 "Whatever.").

responds_to_acronyms_test() ->
    ?assertEqual((bob:response_for("It's OK if you don't want to go to the DMV.")),
                 "Whatever.").

responds_to_forceful_questions_test() ->
    ?assertEqual((bob:response_for("WHAT THE HELL WERE YOU THINKING?")),
                 "Woah, chill out!").

responds_to_shouting_with_special_characters_test() ->
    ?assertEqual((bob:response_for("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")),
                 "Woah, chill out!").

responds_to_shouting_numbers_test() ->
    ?assertEqual((bob:response_for("1, 2, 3, GO!")), "Woah, chill out!").

responds_to_shouting_with_no_exclamation_mark_test() ->
    ?assertEqual((bob:response_for("I HATE YOU")), "Woah, chill out!").

responds_to_statement_containing_question_mark_test() ->
    ?assertEqual((bob:response_for("Ending with ? means a question")),
                 "Whatever.").

responds_to_silence_test() ->
    ?assertEqual((bob:response_for("")), "Fine. Be that way!").

responds_to_prolonged_silence_test() ->
    ?assertEqual((bob:response_for("    ")), "Fine. Be that way!").


responds_to_non_letters_with_question_test() ->
    ?assertEqual((bob:response_for(":) ?")), "Sure.").

responds_to_multiple_line_questions_test() ->
    ?assertEqual((bob:response_for("\nDoes this cryogenic chamber make me look fat? "
                                   "\nno")),
                 "Whatever.").

%% This one is especially challenging in Erlang, hint: use the re module.

%%responds_to_other_whitespace_test() ->
%%    bob_responds("\n\r \t\v\xA0\x{2002}",
%%                 "Fine. Be that way!").

responds_to_only_numbers_test() ->
    ?assertEqual((bob:response_for("1, 2, 3")), "Whatever.").

responds_to_question_with_only_numbers_test() ->
    ?assertEqual((bob:response_for("4?")), "Sure.").

responds_to_unicode_shout_test() ->
    ?assertEqual((bob:response_for("\xdcML\xc4\xdcTS!")),
                 "Woah, chill out!").

responds_to_unicode_non_shout_test() ->
    ?assertEqual((bob:response_for("\xdcML\xe4\xdcTS!")), "Whatever.").

