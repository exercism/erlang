% based on canonical data version 1.3.0
% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/bracket-push/canonical-data.json

-module(bracket_push_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

paired_square_brackets_test() ->
	?assert(bracket_push:is_paired("[]")).

empty_string_test() ->
	?assert(bracket_push:is_paired("")).

unpaired_brackets_test() ->
	?assertNot(bracket_push:is_paired("[[")).

wrong_ordered_brackets_test() ->
	?assertNot(bracket_push:is_paired("}{")).

wrong_closing_bracket_test() ->
	?assertNot(bracket_push:is_paired("{]")).

paired_with_whitespace_test() ->
	?assert(bracket_push:is_paired("{ }")).

partially_paired_brackets_test() ->
	?assertNot(bracket_push:is_paired("{[])")).

simple_nested_brackets_test() ->
	?assert(bracket_push:is_paired("{[]}")).

several_paired_brackets_test() ->
	?assert(bracket_push:is_paired("{}[]")).

paired_and_nested_brackets_test() ->
	?assert(bracket_push:is_paired("([{}({}[])])")).

unopened_closing_brackets_test() ->
	?assertNot(bracket_push:is_paired("{[)][]}")).

unpaired_and_nested_brackets_test() ->
	?assertNot(bracket_push:is_paired("([{])")).

paired_and_wrong_nested_brackets_test()	->
	?assertNot(bracket_push:is_paired("[({]})")).

math_expression_test() ->
	?assert(bracket_push:is_paired("(((185 + 223.85) * 15) - 543)/2")).

complex_latex_expression_test()	->
	?assert(bracket_push:is_paired("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2	\\end{array}\\right)")).

version_test() -> ?assertMatch(1, bracket_push:test_version()).

