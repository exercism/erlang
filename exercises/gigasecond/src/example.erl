-module(example).
-export([from/1, test_version/0]).

-define(GIGASECOND, 1000000000).

from({Year, Month, Day}) ->
  from({{Year, Month, Day}, {0, 0, 0}});
from(DateTime) ->
  Seconds = calendar:datetime_to_gregorian_seconds(DateTime),
  calendar:gregorian_seconds_to_datetime(Seconds + ?GIGASECOND).

test_version() ->
    1.
