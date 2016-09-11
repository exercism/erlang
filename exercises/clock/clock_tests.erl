-module('clock_tests').
-include_lib("eunit/include/eunit.hrl").

-define(assertClockString(String, Hour, Minute), ?assertEqual(String, clock:to_string(clock:create( Hour, Minute)))).

-define(assertClockAdd(String, Hour, Minute, Add), ?assertEqual(String, clock:to_string(clock:minutes_add(clock:create(Hour, Minute), Add)))).

create_on_the_hour_test() ->
  ?assertClockString("08:00", 8, 0).

create_past_the_hour_test() ->
  ?assertClockString("11:09", 11, 9).

create_midnight_is_zero_hours_test() ->
  ?assertClockString("00:00", 24, 0).

create_hour_rolls_over_test() ->
  ?assertClockString("01:00", 25, 0).

create_hour_rolls_over_continuously_test() ->
  ?assertClockString("04:00", 100, 0).

create_sixty_minutes_is_next_hour_test() ->
  ?assertClockString("02:00", 1, 60).

create_minutes_roll_over_test() ->
  ?assertClockString("02:40", 0, 160).

create_minutes_roll_over_continuously_test() ->
  ?assertClockString("04:43", 0, 1723).

create_hour_and_minutes_roll_over_test() ->
  ?assertClockString("03:40", 25, 160).

create_hour_and_minutes_roll_over_continuously_test() ->
  ?assertClockString("11:01", 201, 3001).

create_hour_and_minutes_roll_over_to_exactly_midnight_test() ->
  ?assertClockString("00:00", 72, 8640).

create_negative_hour_test() ->
  ?assertClockString("23:15", -1, 15).

create_negative_hour_rolls_over_test() ->
  ?assertClockString("23:00", -25, 0).

create_negative_hour_rolls_over_continuously_test() ->
  ?assertClockString("05:00", -91, 0).

create_negative_minutes_test() ->
  ?assertClockString("00:20", 1, -40).

create_negative_minutes_roll_over_test() ->
  ?assertClockString("22:20", 1, -160).

create_negative_minutes_roll_over_continuously_test() ->
  ?assertClockString("16:40", 1, -4820).

create_negative_hour_and_minutes_both_roll_over_test() ->
  ?assertClockString("20:20", -25, -160).

create_negative_hour_and_minutes_both_roll_over_continuously_test() ->
  ?assertClockString("22:10", -121, -5810).



add_minutes_test() ->
  ?assertClockAdd("10:03", 10, 0, 3).

add_no_minutes_test() ->
  ?assertClockAdd("06:41", 6, 41, 0).

add_to_next_hour_test() ->
  ?assertClockAdd("01:25", 0, 45, 40).

add_more_than_one_hour_test() ->
  ?assertClockAdd("11:01", 10, 0, 61).

add_more_than_two_hours_with_carry_test() ->
  ?assertClockAdd("03:25", 0, 45, 160).


add_across_midnight_test() ->
  ?assertClockAdd("00:01", 23, 59, 2).

add_more_than_one_day_test() ->
  ?assertClockAdd("06:32", 5, 32, 1500). %% 1500 min => 25 h

add_more_than_two_days_test() ->
  ?assertClockAdd("11:21", 1, 1, 3500).

subtract_minutes_test() ->
  ?assertClockAdd("10:00", 10, 3, -3).

subtract_to_previous_hour_test() ->
  ?assertClockAdd("09:33", 10, 3, -30).

subtract_more_than_an_hour_test() ->
  ?assertClockAdd("08:53", 10, 3, -70).

subtract_across_midnight_test() ->
  ?assertClockAdd("23:59", 0, 3, -4).

subtract_more_than_two_hours_test() ->
  ?assertClockAdd("21:20", 0, 0, -160).

subtract_more_than_two_hours_with_borrow_test() ->
  ?assertClockAdd("03:35", 6, 15, -160).

subtract_more_than_one_day_test() ->
  ?assertClockAdd("04:32", 5, 32, -1500). %%1500 min => 25 h

subtract_more_than_two_days_test() ->
  ?assertClockAdd("00:20", 2, 20, -3000).

%%{
%%   "equal": {
%%      "description": [
%%         "Construct two separate clocks, set times, test if they are equal."
%%      ],
%%      "cases": [
%%         {
%%            "description": "clocks with same time",
%%            "clock1": {
%%               "hour": 15,
%%               "minute": 37
%%            },
%%            "clock2": {
%%               "hour": 15,
%%               "minute": 37
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks a minute apart",
%%            "clock1": {
%%               "hour": 15,
%%               "minute": 36
%%            },
%%            "clock2": {
%%               "hour": 15,
%%               "minute": 37
%%            },
%%            "expected": false
%%         },
%%         {
%%            "description": "clocks an hour apart",
%%            "clock1": {
%%               "hour": 14,
%%               "minute": 37
%%            },
%%            "clock2": {
%%               "hour": 15,
%%               "minute": 37
%%            },
%%            "expected": false
%%         },
%%         {
%%            "description": "clocks with hour overflow",
%%            "clock1": {
%%               "hour": 10,
%%               "minute": 37
%%            },
%%            "clock2": {
%%               "hour": 34,
%%               "minute": 37
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with hour overflow by several days",
%%            "clock1": {
%%               "hour": 3,
%%               "minute": 11
%%            },
%%            "clock2": {
%%               "hour": 99,
%%               "minute": 11
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative hour",
%%            "clock1": {
%%               "hour": 22,
%%               "minute": 40
%%            },
%%            "clock2": {
%%               "hour": -2,
%%               "minute": 40
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative hour that wraps",
%%            "clock1": {
%%               "hour": 17,
%%               "minute": 3
%%            },
%%            "clock2": {
%%               "hour": -31,
%%               "minute": 3
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative hour that wraps multiple times",
%%            "clock1": {
%%               "hour": 13,
%%               "minute": 49
%%            },
%%            "clock2": {
%%               "hour": -83,
%%               "minute": 49
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with minute overflow",
%%            "clock1": {
%%               "hour": 0,
%%               "minute": 1
%%            },
%%            "clock2": {
%%               "hour": 0,
%%               "minute": 1441
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with minute overflow by several days",
%%            "clock1": {
%%               "hour": 2,
%%               "minute": 2
%%            },
%%            "clock2": {
%%               "hour": 2,
%%               "minute": 4322
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative minute",
%%            "clock1": {
%%               "hour": 2,
%%               "minute": 40
%%            },
%%            "clock2": {
%%               "hour": 3,
%%               "minute": -20
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative minute that wraps",
%%            "clock1": {
%%               "hour": 4,
%%               "minute": 10
%%            },
%%            "clock2": {
%%               "hour": 5,
%%               "minute": -1490
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative minute that wraps multiple times",
%%            "clock1": {
%%               "hour": 6,
%%               "minute": 15
%%            },
%%            "clock2": {
%%               "hour": 6,
%%               "minute": -4305
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative hours and minutes",
%%            "clock1": {
%%               "hour": 7,
%%               "minute": 32
%%            },
%%            "clock2": {
%%               "hour": -12,
%%               "minute": -268
%%            },
%%            "expected": true
%%         },
%%         {
%%            "description": "clocks with negative hours and minutes that wrap",
%%            "clock1": {
%%               "hour": 18,
%%               "minute": 7
%%            },
%%            "clock2": {
%%               "hour": -54,
%%               "minute": -11513
%%            },
%%            "expected": true
%%         }
%%      ]
%%   }
%%}
