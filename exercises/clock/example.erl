-module('clock').

-export([create/2,
         is_equal/2,
         minutes_add/2,
         minutes_delete/2,
         to_string/1] ).

-record(?MODULE, {normalized}).

-define(HOURS_PER_DAY, 24).
-define(MINUTES_PER_HOUR, 60).
-define(MINUTES_PER_DAY, (?HOURS_PER_DAY * ?MINUTES_PER_HOUR)).


create(Hour,Minutes) ->
  #?MODULE{normalized = mod(Hour * ?MINUTES_PER_HOUR + Minutes, ?MINUTES_PER_DAY)}.

is_equal(C, C) ->
  true;
is_equal(_, _) ->
  false.

minutes_add( Clock, Minutes ) ->
  TotalMinutes =  (hour_minutes2minutes(Clock) + Minutes) rem day_minutes(),
  minutes2hour_minutes(TotalMinutes).


minutes_delete( Clock, Minutes) ->
  TotalMinutes =  (hour_minutes2minutes(Clock) + day_minutes() - Minutes) rem day_minutes(),
  minutes2hour_minutes(TotalMinutes).


day_minutes() ->
  24*60.

hour_minutes2minutes({H,M}) ->
  60*H + M.

minutes2hour_minutes(Mraw) ->
  M = Mraw rem day_minutes(),
  { M div 60, M rem 60}.

to_string(#?MODULE{normalized = Mins}) ->
  Hour = Mins div ?MINUTES_PER_HOUR,
  Minutes = Mins rem ?MINUTES_PER_HOUR,
  lists:flatten( io_lib:format("~2.10.0b:~2.10.0b", [Hour, Minutes]) ).

mod(X,Y) when X > 0 -> X rem Y;
mod(X,Y) when X < 0 -> Y + X rem Y;
mod(0,Y) -> 0.
