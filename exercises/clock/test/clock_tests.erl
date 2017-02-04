-module('clock_tests').

-define(TESTED_MODULE, (sut(clock))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


-define(assertClockString(String, Hour, Minute), ?assertEqual(String, ?TESTED_MODULE:to_string(?TESTED_MODULE:create( Hour, Minute)))).

-define(assertClockAdd(String, Hour, Minute, Add), ?assertEqual(String, ?TESTED_MODULE:to_string(?TESTED_MODULE:minutes_add(?TESTED_MODULE:create(Hour, Minute), Add)))).

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


equal_clocks_with_same_time_test() ->
  Clock1 = ?TESTED_MODULE:create(15, 37),
  Clock2 = ?TESTED_MODULE:create(15, 37),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_a_minute_apart_test() ->
  Clock1 = ?TESTED_MODULE:create(15, 36),
  Clock2 = ?TESTED_MODULE:create(15, 37),
  ?assertNot(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_an_hour_apart_test() ->
  Clock1 = ?TESTED_MODULE:create(14, 37),
  Clock2 = ?TESTED_MODULE:create(15, 37),
  ?assertNot(?TESTED_MODULE:is_equal(Clock1, Clock2)).


equal_clocks_with_hour_overflow_test() ->
  Clock1 = ?TESTED_MODULE:create(10, 37),
  Clock2 = ?TESTED_MODULE:create(34, 37),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_hour_overflow_by_several_days_test() ->
  Clock1 = ?TESTED_MODULE:create(3, 11),
  Clock2 = ?TESTED_MODULE:create(99, 11),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_hour_test() ->
  Clock1 = ?TESTED_MODULE:create(22, 40),
  Clock2 = ?TESTED_MODULE:create(-2, 40),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_hour_that_wraps_test() ->
  Clock1 = ?TESTED_MODULE:create(17, 3),
  Clock2 = ?TESTED_MODULE:create(-31, 3),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_hour_that_wraps_multiple_times_test() ->
  Clock1 = ?TESTED_MODULE:create(13, 49),
  Clock2 = ?TESTED_MODULE:create(-83, 49),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_minute_overflow_test() ->
  Clock1 = ?TESTED_MODULE:create(0, 1),
  Clock2 = ?TESTED_MODULE:create(0, 1441),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_minute_overflow_by_several_days_test() ->
  Clock1 = ?TESTED_MODULE:create(2, 2),
  Clock2 = ?TESTED_MODULE:create(2, 4322),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_minute_test() ->
  Clock1 = ?TESTED_MODULE:create(2, 40),
  Clock2 = ?TESTED_MODULE:create(3, -20),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_minute_that_wraps_test() ->
  Clock1 = ?TESTED_MODULE:create(4, 10),
  Clock2 = ?TESTED_MODULE:create(5, -1490),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_minute_that_wraps_multiple_times_test() ->
  Clock1 = ?TESTED_MODULE:create(6, 15),
  Clock2 = ?TESTED_MODULE:create(6, -4305),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_hours_and_minutes_test() ->
  Clock1 = ?TESTED_MODULE:create(7, 32),
  Clock2 = ?TESTED_MODULE:create(-12, -268),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).

equal_clocks_with_negative_hours_and_minutes_that_wrap_test() ->
  Clock1 = ?TESTED_MODULE:create(18, 7),
  Clock2 = ?TESTED_MODULE:create(-54, -11513),
  ?assert(?TESTED_MODULE:is_equal(Clock1, Clock2)).
