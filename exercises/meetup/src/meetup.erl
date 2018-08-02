-module(meetup).

-export([schedule/4, test_version/0]).

schedule(_Year, _Month, _DayOfWeek, _Period) ->
  undefined.

test_version() -> 1.
