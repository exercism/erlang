-module(space_age_tests).

-define(TESTED_MODULE, (sut(space_age))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


age_in_earth_years_test() ->
  equalFloat(?TESTED_MODULE:ageOn(earth, 1000000000), 31.69).

age_in_mercury_years_test() ->
  Seconds = 2134835688,
  equalFloat(?TESTED_MODULE:ageOn(earth, Seconds), 67.65),
  equalFloat(?TESTED_MODULE:ageOn(mercury, Seconds), 280.88).

age_in_venus_years_test() ->
  Seconds = 189839836,
  equalFloat(?TESTED_MODULE:ageOn(earth, Seconds), 6.02),
  equalFloat(?TESTED_MODULE:ageOn(venus, Seconds), 9.78).

age_in_mars_years_test() ->
  Seconds = 2329871239,
  equalFloat(?TESTED_MODULE:ageOn(earth, Seconds), 73.83),
  equalFloat(?TESTED_MODULE:ageOn(mars, Seconds), 39.25).

age_in_jupiter_years_test() ->
  Seconds = 901876382,
  equalFloat(?TESTED_MODULE:ageOn(earth, Seconds), 28.58),
  equalFloat(?TESTED_MODULE:ageOn(jupiter, Seconds), 2.41).

age_in_saturn_years_test() ->
  Seconds = 3000000000,
  equalFloat(?TESTED_MODULE:ageOn(earth, Seconds), 95.06),
  equalFloat(?TESTED_MODULE:ageOn(saturn, Seconds), 3.23).

age_in_uranus_years_test() ->
  Seconds = 3210123456,
  equalFloat(?TESTED_MODULE:ageOn(earth, Seconds), 101.72),
  equalFloat(?TESTED_MODULE:ageOn(uranus, Seconds), 1.21).

age_in_neptune_years_test() ->
  Seconds = 8210123456,
  equalFloat(?TESTED_MODULE:ageOn(earth, Seconds), 260.16),
  equalFloat(?TESTED_MODULE:ageOn(neptune, Seconds), 1.58).

equalFloat(A, B) ->
  ?assertEqual(B, round(A,2)).

round(Number, Precision) ->
  P = math:pow(10, Precision),
  round(Number * P) / P.
