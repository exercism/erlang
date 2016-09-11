-module('clock_tests').
-include_lib("eunit/include/eunit.hrl").

-define(assertClockString(String, Hour, Minute), ?assertEqual(String, clock:to_string(clock:create( Hour, Minute)))).

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

%%{
%%   "add": {
%%      "description": [
%%         "Test adding and subtracting minutes."
%%      ],
%%      "cases": [
%%         {
%%            "description": "add minutes",
%%            "hour": 10,
%%            "minute": 0,
%%            "add": 3,
%%            "expected": "10:03"
%%         },
%%         {
%%            "description": "add no minutes",
%%            "hour": 6,
%%            "minute": 41,
%%            "add": 0,
%%            "expected": "06:41"
%%         },
%%         {
%%            "description": "add to next hour",
%%            "hour": 0,
%%            "minute": 45,
%%            "add": 40,
%%            "expected": "01:25"
%%         },
%%         {
%%            "description": "add more than one hour",
%%            "hour": 10,
%%            "minute": 0,
%%            "add": 61,
%%            "expected": "11:01"
%%         },
%%         {
%%            "description": "add more than two hours with carry",
%%            "hour": 0,
%%            "minute": 45,
%%            "add": 160,
%%            "expected": "03:25"
%%         },
%%         {
%%            "description": "add across midnight",
%%            "hour": 23,
%%            "minute": 59,
%%            "add": 2,
%%            "expected": "00:01"
%%         },
%%         {
%%            "description": "add more than one day (1500 min = 25 hrs)",
%%            "hour": 5,
%%            "minute": 32,
%%            "add": 1500,
%%            "expected": "06:32"
%%         },
%%         {
%%            "description": "add more than two days",
%%            "hour": 1,
%%            "minute": 1,
%%            "add": 3500,
%%            "expected": "11:21"
%%         },
%%         {
%%            "description": "subtract minutes",
%%            "hour": 10,
%%            "minute": 3,
%%            "add": -3,
%%            "expected": "10:00"
%%         },
%%         {
%%            "description": "subtract to previous hour",
%%            "hour": 10,
%%            "minute": 3,
%%            "add": -30,
%%            "expected": "09:33"
%%         },
%%         {
%%            "description": "subtract more than an hour",
%%            "hour": 10,
%%            "minute": 3,
%%            "add": -70,
%%            "expected": "08:53"
%%         },
%%         {
%%            "description": "subtract across midnight",
%%            "hour": 0,
%%            "minute": 3,
%%            "add": -4,
%%            "expected": "23:59"
%%         },
%%         {
%%            "description": "subtract more than two hours",
%%            "hour": 0,
%%            "minute": 0,
%%            "add": -160,
%%            "expected": "21:20"
%%         },
%%         {
%%            "description": "subtract more than two hours with borrow",
%%            "hour": 6,
%%            "minute": 15,
%%            "add": -160,
%%            "expected": "03:35"
%%         },
%%         {
%%            "description": "subtract more than one day (1500 min = 25 hrs)",
%%            "hour": 5,
%%            "minute": 32,
%%            "add": -1500,
%%            "expected": "04:32"
%%         },
%%         {
%%            "description": "subtract more than two days",
%%            "hour": 2,
%%            "minute": 20,
%%            "add": -3000,
%%            "expected": "00:20"
%%         }
%%      ]
%%   },
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
