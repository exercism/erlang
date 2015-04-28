-module(gigasecond).
-export([from/1]).

-define(GIGASECOND, 1000000000).

from({Year, Month, Day}) ->
  from({{Year, Month, Day}, {0, 0, 0}});
from(DateTime) ->
  Seconds = calendar:datetime_to_gregorian_seconds(DateTime),
  calendar:gregorian_seconds_to_datetime(Seconds + ?GIGASECOND).

