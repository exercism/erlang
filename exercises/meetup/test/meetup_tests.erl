-module(meetup_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(TESTED_MODULE, (sut(meetup))).

monteenth_of_may_2013_test() ->
  ?assertEqual({2013, 5, 13},
               ?TESTED_MODULE:schedule(2013, 5, monday, teenth)).

monteenth_of_august_2013_test() ->
  ?assertEqual({2013, 8, 19},
               ?TESTED_MODULE:schedule(2013, 8, monday, teenth)).

monteenth_of_september_2013_test() ->
  ?assertEqual({2013, 9, 16},
               ?TESTED_MODULE:schedule(2013, 9, monday, teenth)).

tuesteenth_of_march_2013_test() ->
  ?assertEqual({2013, 3, 19},
               ?TESTED_MODULE:schedule(2013, 3, tuesday, teenth)).

tuesteenth_of_april_2013_test() ->
  ?assertEqual({2013, 4, 16},
               ?TESTED_MODULE:schedule(2013, 4, tuesday, teenth)).

tuesteenth_of_august_2013_test() ->
  ?assertEqual({2013, 8, 13},
               ?TESTED_MODULE:schedule(2013, 8, tuesday, teenth)).

wednesteenth_of_january_2013_test() ->
  ?assertEqual({2013, 1, 16},
               ?TESTED_MODULE:schedule(2013, 1, wednesday, teenth)).

wednesteenth_of_february_2013_test() ->
  ?assertEqual({2013, 2, 13},
               ?TESTED_MODULE:schedule(2013, 2, wednesday, teenth)).

wednesteenth_of_june_2013_test() ->
  ?assertEqual({2013, 6, 19},
               ?TESTED_MODULE:schedule(2013, 6, wednesday, teenth)).

thursteenth_of_may_2013_test() ->
  ?assertEqual({2013, 5, 16},
               ?TESTED_MODULE:schedule(2013, 5, thursday, teenth)).

thursteenth_of_june_2013_test() ->
  ?assertEqual({2013, 6, 13},
               ?TESTED_MODULE:schedule(2013, 6, thursday, teenth)).

thursteenth_of_september_2013_test() ->
  ?assertEqual({2013, 9, 19},
               ?TESTED_MODULE:schedule(2013, 9, thursday, teenth)).

friteenth_of_april_2013_test() ->
  ?assertEqual({2013, 4, 19},
               ?TESTED_MODULE:schedule(2013, 4, friday, teenth)).

friteenth_of_august_2013_test() ->
  ?assertEqual({2013, 8, 16},
               ?TESTED_MODULE:schedule(2013, 8, friday, teenth)).

friteenth_of_september_2013_test() ->
  ?assertEqual({2013, 9, 13},
               ?TESTED_MODULE:schedule(2013, 9, friday, teenth)).

saturteenth_of_february_2013_test() ->
  ?assertEqual({2013, 2, 16},
               ?TESTED_MODULE:schedule(2013, 2, saturday, teenth)).

saturteenth_of_april_2013_test() ->
  ?assertEqual({2013, 4, 13},
               ?TESTED_MODULE:schedule(2013, 4, saturday, teenth)).

saturteenth_of_october_2013_test() ->
  ?assertEqual({2013, 10, 19},
               ?TESTED_MODULE:schedule(2013, 10, saturday, teenth)).

sunteenth_of_map_2013_test() ->
  ?assertEqual({2013, 5, 19},
               ?TESTED_MODULE:schedule(2013, 5, sunday, teenth)).

sunteenth_of_june_2013_test() ->
  ?assertEqual({2013, 6, 16},
               ?TESTED_MODULE:schedule(2013, 6, sunday, teenth)).

sunteenth_of_october_2013_test() ->
  ?assertEqual({2013, 10, 13},
               ?TESTED_MODULE:schedule(2013, 10, sunday, teenth)).

first_monday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 4},
               ?TESTED_MODULE:schedule(2013, 3, monday, first)).

first_monday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 1},
               ?TESTED_MODULE:schedule(2013, 4, monday, first)).

first_tuesday_of_may_2013_test() ->
  ?assertEqual({2013, 5, 7},
               ?TESTED_MODULE:schedule(2013, 5, tuesday, first)).

first_tuesday_of_june_2013_test() ->
  ?assertEqual({2013, 6, 4},
               ?TESTED_MODULE:schedule(2013, 6, tuesday, first)).

first_wednesday_of_july_2013_test() ->
  ?assertEqual({2013, 7, 3},
               ?TESTED_MODULE:schedule(2013, 7, wednesday, first)).

first_wednesday_of_august_2013_test() ->
  ?assertEqual({2013, 8, 7},
               ?TESTED_MODULE:schedule(2013, 8, wednesday, first)).

first_thursday_of_september_2013_test() ->
  ?assertEqual({2013, 9, 5},
               ?TESTED_MODULE:schedule(2013, 9, thursday, first)).

first_thursday_of_october_2013_test() ->
  ?assertEqual({2013, 10, 3},
               ?TESTED_MODULE:schedule(2013, 10, thursday, first)).

first_friday_of_november_2013_test() ->
  ?assertEqual({2013, 11, 1},
               ?TESTED_MODULE:schedule(2013, 11, friday, first)).

first_friday_of_december_2013_test() ->
  ?assertEqual({2013, 12, 6},
               ?TESTED_MODULE:schedule(2013, 12, friday, first)).

first_saturday_of_january_2013_test() ->
  ?assertEqual({2013, 1, 5},
               ?TESTED_MODULE:schedule(2013, 1, saturday, first)).

first_saturday_of_february_2013_test() ->
  ?assertEqual({2013, 2, 2},
               ?TESTED_MODULE:schedule(2013, 2, saturday, first)).

first_sunday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 3},
               ?TESTED_MODULE:schedule(2013, 3, sunday, first)).

first_sunday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 7},
               ?TESTED_MODULE:schedule(2013, 4, sunday, first)).

second_monday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 11},
               ?TESTED_MODULE:schedule(2013, 3, monday, second)).

second_monday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 8},
               ?TESTED_MODULE:schedule(2013, 4, monday, second)).

second_tuesday_of_may_2013_test() ->
  ?assertEqual({2013, 5, 14},
               ?TESTED_MODULE:schedule(2013, 5, tuesday, second)).

second_tuesday_of_june_2013_test() ->
  ?assertEqual({2013, 6, 11},
               ?TESTED_MODULE:schedule(2013, 6, tuesday, second)).

second_wednesday_of_july_2013_test() ->
  ?assertEqual({2013, 7, 10},
               ?TESTED_MODULE:schedule(2013, 7, wednesday, second)).

second_wednesday_of_august_2013_test() ->
  ?assertEqual({2013, 8, 14},
               ?TESTED_MODULE:schedule(2013, 8, wednesday, second)).

second_thursday_of_september_2013_test() ->
  ?assertEqual({2013, 9, 12},
               ?TESTED_MODULE:schedule(2013, 9, thursday, second)).

second_thursday_of_october_2013_test() ->
  ?assertEqual({2013, 10, 10},
               ?TESTED_MODULE:schedule(2013, 10, thursday, second)).

second_friday_of_november_2013_test() ->
  ?assertEqual({2013, 11, 8},
               ?TESTED_MODULE:schedule(2013, 11, friday, second)).

second_friday_of_december_2013_test() ->
  ?assertEqual({2013, 12, 13},
               ?TESTED_MODULE:schedule(2013, 12, friday, second)).

second_saturday_of_january_2013_test() ->
  ?assertEqual({2013, 1, 12},
               ?TESTED_MODULE:schedule(2013, 1, saturday, second)).

second_saturday_of_february_2013_test() ->
  ?assertEqual({2013, 2, 9},
               ?TESTED_MODULE:schedule(2013, 2, saturday, second)).

second_sunday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 10},
               ?TESTED_MODULE:schedule(2013, 3, sunday, second)).

second_sunday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 14},
               ?TESTED_MODULE:schedule(2013, 4, sunday, second)).

third_monday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 18},
               ?TESTED_MODULE:schedule(2013, 3, monday, third)).

third_monday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 15},
               ?TESTED_MODULE:schedule(2013, 4, monday, third)).

third_tuesday_of_may_2013_test() ->
  ?assertEqual({2013, 5, 21},
               ?TESTED_MODULE:schedule(2013, 5, tuesday, third)).

third_tuesday_of_june_2013_test() ->
  ?assertEqual({2013, 6, 18},
               ?TESTED_MODULE:schedule(2013, 6, tuesday, third)).

third_wednesday_of_july_2013_test() ->
  ?assertEqual({2013, 7, 17},
               ?TESTED_MODULE:schedule(2013, 7, wednesday, third)).

third_wednesday_of_august_2013_test() ->
  ?assertEqual({2013, 8, 21},
               ?TESTED_MODULE:schedule(2013, 8, wednesday, third)).

third_thursday_of_september_2013_test() ->
  ?assertEqual({2013, 9, 19},
               ?TESTED_MODULE:schedule(2013, 9, thursday, third)).

third_thursday_of_october_2013_test() ->
  ?assertEqual({2013, 10, 17},
               ?TESTED_MODULE:schedule(2013, 10, thursday, third)).

third_friday_of_november_2013_test() ->
  ?assertEqual({2013, 11, 15},
               ?TESTED_MODULE:schedule(2013, 11, friday, third)).

third_friday_of_december_2013_test() ->
  ?assertEqual({2013, 12, 20},
               ?TESTED_MODULE:schedule(2013, 12, friday, third)).

third_saturday_of_january_2013_test() ->
  ?assertEqual({2013, 1, 19},
               ?TESTED_MODULE:schedule(2013, 1, saturday, third)).

third_saturday_of_february_2013_test() ->
  ?assertEqual({2013, 2, 16},
               ?TESTED_MODULE:schedule(2013, 2, saturday, third)).

third_sunday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 17},
               ?TESTED_MODULE:schedule(2013, 3, sunday, third)).

third_sunday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 21},
               ?TESTED_MODULE:schedule(2013, 4, sunday, third)).

fourth_monday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 25},
               ?TESTED_MODULE:schedule(2013, 3, monday, fourth)).

fourth_monday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 22},
               ?TESTED_MODULE:schedule(2013, 4, monday, fourth)).

fourth_tuesday_of_may_2013_test() ->
  ?assertEqual({2013, 5, 28},
               ?TESTED_MODULE:schedule(2013, 5, tuesday, fourth)).

fourth_tuesday_of_june_2013_test() ->
  ?assertEqual({2013, 6, 25},
               ?TESTED_MODULE:schedule(2013, 6, tuesday, fourth)).

fourth_wednesday_of_july_2013_test() ->
  ?assertEqual({2013, 7, 24},
               ?TESTED_MODULE:schedule(2013, 7, wednesday, fourth)).

fourth_wednesday_of_august_2013_test() ->
  ?assertEqual({2013, 8, 28},
               ?TESTED_MODULE:schedule(2013, 8, wednesday, fourth)).

fourth_thursday_of_september_2013_test() ->
  ?assertEqual({2013, 9, 26},
               ?TESTED_MODULE:schedule(2013, 9, thursday, fourth)).

fourth_thursday_of_october_2013_test() ->
  ?assertEqual({2013, 10, 24},
               ?TESTED_MODULE:schedule(2013, 10, thursday, fourth)).

fourth_friday_of_november_2013_test() ->
  ?assertEqual({2013, 11, 22},
               ?TESTED_MODULE:schedule(2013, 11, friday, fourth)).

fourth_friday_of_december_2013_test() ->
  ?assertEqual({2013, 12, 27},
               ?TESTED_MODULE:schedule(2013, 12, friday, fourth)).

fourth_saturday_of_january_2013_test() ->
  ?assertEqual({2013, 1, 26},
               ?TESTED_MODULE:schedule(2013, 1, saturday, fourth)).

fourth_saturday_of_february_2013_test() ->
  ?assertEqual({2013, 2, 23},
               ?TESTED_MODULE:schedule(2013, 2, saturday, fourth)).

fourth_sunday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 24},
               ?TESTED_MODULE:schedule(2013, 3, sunday, fourth)).

fourth_sunday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 28},
               ?TESTED_MODULE:schedule(2013, 4, sunday, fourth)).

last_monday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 25},
               ?TESTED_MODULE:schedule(2013, 3, monday, last)).

last_monday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 29},
               ?TESTED_MODULE:schedule(2013, 4, monday, last)).

last_tuesday_of_may_2013_test() ->
  ?assertEqual({2013, 5, 28},
               ?TESTED_MODULE:schedule(2013, 5, tuesday, last)).

last_tuesday_of_june_2013_test() ->
  ?assertEqual({2013, 6, 25},
               ?TESTED_MODULE:schedule(2013, 6, tuesday, last)).

last_wednesday_of_july_2013_test() ->
  ?assertEqual({2013, 7, 31},
               ?TESTED_MODULE:schedule(2013, 7, wednesday, last)).

last_wednesday_of_august_2013_test() ->
  ?assertEqual({2013, 8, 28},
               ?TESTED_MODULE:schedule(2013, 8, wednesday, last)).

last_thursday_of_september_2013_test() ->
  ?assertEqual({2013, 9, 26},
               ?TESTED_MODULE:schedule(2013, 9, thursday, last)).

last_thursday_of_october_2013_test() ->
  ?assertEqual({2013, 10, 31},
               ?TESTED_MODULE:schedule(2013, 10, thursday, last)).

last_friday_of_november_2013_test() ->
  ?assertEqual({2013, 11, 29},
               ?TESTED_MODULE:schedule(2013, 11, friday, last)).

last_friday_of_december_2013_test() ->
  ?assertEqual({2013, 12, 27},
               ?TESTED_MODULE:schedule(2013, 12, friday, last)).

last_saturday_of_january_2013_test() ->
  ?assertEqual({2013, 1, 26},
               ?TESTED_MODULE:schedule(2013, 1, saturday, last)).

last_saturday_of_february_2013_test() ->
  ?assertEqual({2013, 2, 23},
               ?TESTED_MODULE:schedule(2013, 2, saturday, last)).

last_sunday_of_march_2013_test() ->
  ?assertEqual({2013, 3, 31},
               ?TESTED_MODULE:schedule(2013, 3, sunday, last)).

last_sunday_of_april_2013_test() ->
  ?assertEqual({2013, 4, 28},
               ?TESTED_MODULE:schedule(2013, 4, sunday, last)).
