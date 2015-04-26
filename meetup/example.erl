-module(meetup).
-export([schedule/4]).

-type year() :: non_neg_integer().
-type month() :: 1..12.
-type day() :: 1..31.
-type date() :: {year(), month(), day()}.
-type day_of_week() :: monday | tuesday | wednesday | thursday | friday | saturday | sunday.
-type period() :: first | second | third | fourth | teenth | last.

-define (DAY_MAP, #{monday => 1, tuesday => 2, wednesday => 3, thursday => 4,
                    friday => 5, saturday => 6, sunday => 7}).

-spec schedule(year(), month(), day_of_week(), period()) -> date().
schedule(Year, Month, DayOfWeek, Period) ->
  DoW = maps:get(DayOfWeek, ?DAY_MAP),
  [Day] = [Day || Day <- day_range(Period, Year, Month),
          calendar:day_of_the_week({Year, Month, Day}) =:= DoW],
  {Year, Month, Day}.

day_range(first, _Year, _Month) ->
  lists:seq(1, 7);
day_range(second, _Year, _Month) ->
  lists:seq(8, 14);
day_range(third, _Year, _Month) ->
  lists:seq(15, 21);
day_range(fourth, _Year, _Month) ->
  lists:seq(22, 28);
day_range(teenth, _Year, _Month) ->
  lists:seq(13, 19);
day_range(last, Year, Month) ->
  LastDay = calendar:last_day_of_the_month(Year, Month),
  lists:seq(LastDay - 6, LastDay).

