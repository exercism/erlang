-module(allergies_tests).

-define(TESTED_MODULE, (sut(allergies))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").

no_allergies_at_all_test() ->
  ?assertEqual([], ?TESTED_MODULE:allergies(0)).

allergic_to_just_eggs_test() ->
  ?assertEqual(['eggs'], ?TESTED_MODULE:allergies(1)).

allergic_to_just_peanuts_test() ->
  ?assertEqual(['peanuts'], ?TESTED_MODULE:allergies(2)).

allergic_to_just_strawberries_test() ->
  ?assertEqual(['strawberries'], ?TESTED_MODULE:allergies(8)).

allergic_to_eggs_and_peanuts_test() ->
  ?assertEqual(['eggs', 'peanuts'], ?TESTED_MODULE:allergies(3)).

allergic_to_more_than_eggs_but_not_peanuts_test() ->
  ?assertEqual(['eggs', 'shellfish'], ?TESTED_MODULE:allergies(5)).

allergic_to_lots_of_stuff_test() ->
  ?assertEqual(
     ['strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'], ?TESTED_MODULE:allergies(248)).

allergic_to_everything_test() ->
  ?assertEqual(
     ['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'],
     ?TESTED_MODULE:allergies(255)).

no_allergies_means_not_allergic_test() ->
  ?assertNot(?TESTED_MODULE:is_allergic_to('peanuts', 0)),
  ?assertNot(?TESTED_MODULE:is_allergic_to('cats', 0)),
  ?assertNot(?TESTED_MODULE:is_allergic_to('strawberries', 0)).

is_allergic_to_eggs_test() ->
  ?assert(?TESTED_MODULE:is_allergic_to('eggs', 1)).

allergic_to_eggs_and_other_stuff_test() ->
  ?assert(?TESTED_MODULE:is_allergic_to('eggs', 5)).

ignore_non_allergen_score_parts_test() ->
  ?assertEqual(
     ['eggs', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'],
     ?TESTED_MODULE:allergies(509)).
