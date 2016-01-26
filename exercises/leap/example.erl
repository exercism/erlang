-module(leap).

-export([leap_year/1]).

-spec leap_year(non_neg_integer()) -> boolean().
leap_year(Year) ->
  divisible_by(Year, 400)
  orelse (divisible_by(Year, 4) andalso
          not divisible_by(Year, 100)).

divisible_by(Year, Number) ->
  Year rem Number =:= 0.
