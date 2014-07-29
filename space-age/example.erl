-module(space_age).

-export([ageOn/2]).

-type planets() :: mercury | venus | earth | mars | jupiter | saturn | uranus | neptune.
-spec ageOn(planets(), integer()) -> float().
ageOn(Planet, Seconds) ->
    Seconds / secondsPerYear(Planet).

secondsPerYear (mercury) ->
    earthYear() * 0.2408467;
secondsPerYear (venus) ->
    earthYear() * 0.61519726;
secondsPerYear (earth) ->
    earthYear();
secondsPerYear (mars) ->
    earthYear() * 1.8808158;
secondsPerYear (jupiter) ->
    earthYear() * 11.862615;
secondsPerYear (saturn) ->
    earthYear() * 29.447498;
secondsPerYear (uranus) ->
    earthYear() * 84.016846;
secondsPerYear (neptune) ->
    earthYear() * 164.79132.

earthYear() ->
    365.25 * 24 * 60 * 60.
