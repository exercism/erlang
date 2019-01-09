-module(example).

-export([create/2,
         is_equal/2,
         minutes_add/2,
         to_string/1]).

-record(?MODULE, {normalized}).

-define(HOURS_PER_DAY, 24).
-define(MINUTES_PER_HOUR, 60).
-define(MINUTES_PER_DAY, (?HOURS_PER_DAY * ?MINUTES_PER_HOUR)).


create(Hour, Minutes) ->
  #?MODULE{normalized = mod(Hour * ?MINUTES_PER_HOUR + Minutes, ?MINUTES_PER_DAY)}.

is_equal(C, C) ->
  true;
is_equal(_, _) ->
  false.

minutes_add(#?MODULE{normalized = Mins}, Minutes) ->
  TotalMinutes = mod(Mins + Minutes, ?MINUTES_PER_DAY),
  #?MODULE{normalized = TotalMinutes}.

to_string(#?MODULE{normalized = Mins}) ->
  Hour = Mins div ?MINUTES_PER_HOUR,
  Minutes = Mins rem ?MINUTES_PER_HOUR,
  lists:flatten(io_lib:format("~2.10.0b:~2.10.0b", [Hour, Minutes])).



mod(X, Y) when X > 0 -> X rem Y;
mod(X, Y) when X < 0 -> Y + X rem Y;
mod(0, _Y) -> 0.
