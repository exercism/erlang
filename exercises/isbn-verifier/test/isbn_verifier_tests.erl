-module(isbn_verifier_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

valid_isbn_number_test() ->
	?assert(isbn_verifier:is_valid("3-598-21508-8")).

invalid_isbn_check_digit_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-21508-9")).

valid_isbn_number_with_a_check_digit_of_10_test() ->
	?assert(isbn_verifier:is_valid("3-598-21507-X")).

check_digit_is_a_character_other_than_x_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-21507-A")).

invalid_character_in_isbn_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-2K507-0")).

x_is_only_valid_as_a_check_digit_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-2X507-9")).

valid_isbn_without_separating_dashes_test() ->
	?assert(isbn_verifier:is_valid("3598215088")).

isbn_without_separating_dashes_and_x_as_check_digit_test() ->
	?assert(isbn_verifier:is_valid("359821507X")).

isbn_without_check_digit_and_dashes_test() ->
	?assertNot(isbn_verifier:is_valid("359821507")).

too_long_isbn_and_no_dashes_test() ->
	?assertNot(isbn_verifier:is_valid("3598215078X")).

isbn_without_check_digit_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-21507")).

too_long_isbn_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-21507-XX")).

check_digit_of_x_should_not_be_used_for_0_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-21515-X")).

empty_isbn_test() ->
	?assertNot(isbn_verifier:is_valid("3-598-21515-X")).

version_test() -> ?assertMatch(1, isbn_verifier:test_version()).
