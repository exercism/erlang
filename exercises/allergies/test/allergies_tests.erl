% To run tests:
% erlc *.erl
% erl -noshell -eval "eunit:test(allergies, [verbose])" -s init stop
%

-module(allergies_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

no_allergies_at_all_test() ->
  Allergies = sut(allergies),
  ?assertEqual([], Allergies:allergies(0)).

allergic_to_just_eggs_test() ->
  Allergies = sut(allergies),
  ?assertEqual(['eggs'], Allergies:allergies(1)).

allergic_to_just_peanuts_test() ->
  Allergies = sut(allergies),
  ?assertEqual(['peanuts'], Allergies:allergies(2)).

allergic_to_just_strawberries_test() ->
  Allergies = sut(allergies),
  ?assertEqual(['strawberries'], Allergies:allergies(8)).

allergic_to_eggs_and_peanuts_test() ->
  Allergies = sut(allergies),
  ?assertEqual(['eggs', 'peanuts'], Allergies:allergies(3)).

allergic_to_more_than_eggs_but_not_peanuts_test() ->
  Allergies = sut(allergies),
  ?assertEqual(['eggs', 'shellfish'], Allergies:allergies(5)).

allergic_to_lots_of_stuff_test() ->
  Allergies = sut(allergies),
  ?assertEqual(
     ['strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'], Allergies:allergies(248)).

allergic_to_everything_test() ->
  Allergies = sut(allergies),
  ?assertEqual(
     ['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'],
     Allergies:allergies(255)).

no_allergies_means_not_allergic_test() ->
  Allergies = sut(allergies),
  ?assertNot(Allergies:is_allergic_to('peanuts', 0)),
  ?assertNot(Allergies:is_allergic_to('cats', 0)),
  ?assertNot(Allergies:is_allergic_to('strawberries', 0)).

is_allergic_to_eggs_test() ->
  Allergies = sut(allergies),
  ?assert(Allergies:is_allergic_to('eggs', 1)).

allergic_to_eggs_and_other_stuff_test() ->
  Allergies = sut(allergies),
  ?assert(Allergies:is_allergic_to('eggs', 5)).

ignore_non_allergen_score_parts_test() ->
  Allergies = sut(allergies),
  ?assertEqual(
     ['eggs', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'],
     Allergies:allergies(509)).

