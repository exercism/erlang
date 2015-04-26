% To run tests:
% erlc *.erl
% erl -noshell -eval "eunit:test(allergies, [verbose])" -s init stop
%

-module(allergies_tests).

-include_lib("eunit/include/eunit.hrl").

no_allergies_at_all_test() ->
  ?assertEqual([], allergies:allergies(0)).

allergic_to_just_eggs_test() ->
  ?assertEqual(['eggs'], allergies:allergies(1)).

allergic_to_just_peanuts_test() ->
  ?assertEqual(['peanuts'], allergies:allergies(2)).

allergic_to_just_strawberries_test() ->
  ?assertEqual(['strawberries'], allergies:allergies(8)).

allergic_to_eggs_and_peanuts_test() ->
  ?assertEqual(['eggs', 'peanuts'], allergies:allergies(3)).

allergic_to_more_than_eggs_but_not_peanuts_test() ->
  ?assertEqual(['eggs', 'shellfish'], allergies:allergies(5)).

allergic_to_lots_of_stuff_test() ->
  ?assertEqual(
     ['strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'], allergies:allergies(248)).

allergic_to_everything_test() ->
  ?assertEqual(
     ['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'],
     allergies:allergies(255)).

no_allergies_means_not_allergic_test() ->
  ?assertNot(allergies:is_allergic_to('peanuts', 0)),
  ?assertNot(allergies:is_allergic_to('cats', 0)),
  ?assertNot(allergies:is_allergic_to('strawberries', 0)).

is_allergic_to_eggs_test() ->
  ?assert(allergies:is_allergic_to('eggs', 1)).

allergic_to_eggs_and_other_stuff_test() ->
  ?assert(allergies:is_allergic_to('eggs', 5)).

ignore_non_allergen_score_parts_test() ->
  ?assertEqual(
     ['eggs', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'],
     allergies:allergies(509)).

