-module(space_age_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

age_in_earth_years_test() ->
  equalFloat(space_age:ageOn(earth, 1000000000), 31.69).

age_in_mercury_years_test() ->
  Seconds = 2134835688,
  equalFloat(space_age:ageOn(earth, Seconds), 67.65),
  equalFloat(space_age:ageOn(mercury, Seconds), 280.88).

age_in_venus_years_test() ->
  Seconds = 189839836,
  equalFloat(space_age:ageOn(earth, Seconds), 6.02),
  equalFloat(space_age:ageOn(venus, Seconds), 9.78).

age_in_mars_years_test() ->
  Seconds = 2329871239,
  equalFloat(space_age:ageOn(earth, Seconds), 73.83),
  equalFloat(space_age:ageOn(mars, Seconds), 39.25).

age_in_jupiter_years_test() ->
  Seconds = 901876382,
  equalFloat(space_age:ageOn(earth, Seconds), 28.58),
  equalFloat(space_age:ageOn(jupiter, Seconds), 2.41).

age_in_saturn_years_test() ->
  Seconds = 3000000000,
  equalFloat(space_age:ageOn(earth, Seconds), 95.06),
  equalFloat(space_age:ageOn(saturn, Seconds), 3.23).

age_in_uranus_years_test() ->
  Seconds = 3210123456,
  equalFloat(space_age:ageOn(earth, Seconds), 101.72),
  equalFloat(space_age:ageOn(uranus, Seconds), 1.21).

age_in_neptune_years_test() ->
  Seconds = 8210123456,
  equalFloat(space_age:ageOn(earth, Seconds), 260.16),
  equalFloat(space_age:ageOn(neptune, Seconds), 1.58).

equalFloat(A, B) ->
  ?assertEqual(B, round(A,2)).

round(Number, Precision) ->
  P = math:pow(10, Precision),
  round(Number * P) / P.

version_test() ->
  ?assertMatch(1, space_age:test_version()).
