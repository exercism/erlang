-module(clock).

-export([create/2, is_equal/2, minutes_add/2, to_string/1, test_version/0]).

create(_Hour, _Minutes) ->
  undefined.

is_equal(_ClockA, _ClockB) ->
  undefined.

minutes_add(_Clock, _Minutes) ->
  undefined.

to_string(_Clock) ->
  undefined.

test_version() -> 1.
