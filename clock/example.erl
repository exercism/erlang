-module(clock).

-export([create/2,
         is_equal/2,
         minutes_add/2,
         minutes_delete/2,
         to_string/1] ).


create(Hour,Minutes) when Hour >= 0, Hour < 24, Minutes >= 0, Minutes < 60 ->
  {Hour, Minutes}.

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

to_string({Hour,Minutes}) ->
  lists:flatten( io_lib:format("~2.10.0b:~2.10.0b", [Hour, Minutes]) ).
