-module( robot_simulator_tests ).

-define(TESTED_MODULE, (sut(robot_simulator))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


create_test() ->
  Robot = ?TESTED_MODULE:create(),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= undefined ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= {undefined, undefined} ).

place_test() ->
  Robot = ?TESTED_MODULE:create(),
  Position = {1, 2},
  ?TESTED_MODULE:place( Robot, north, Position ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= north ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ).

left_test() ->
  Robot = ?TESTED_MODULE:create(),
  Position = {3, 4},
  ?TESTED_MODULE:place( Robot, north, Position ),
  ?TESTED_MODULE:left( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= west ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ),
  ?TESTED_MODULE:left( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= south ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ),
  ?TESTED_MODULE:left( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= east ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ),
  ?TESTED_MODULE:left( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= north ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ).

right_test() ->
  Robot = ?TESTED_MODULE:create(),
  Position = {5, 6},
  ?TESTED_MODULE:place( Robot, north, Position ),
  ?TESTED_MODULE:right( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= east ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ),
  ?TESTED_MODULE:right( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= south ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ),
  ?TESTED_MODULE:right( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= west ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ),
  ?TESTED_MODULE:right( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= north ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ).

advance_north_test() ->
  Robot = ?TESTED_MODULE:create(),
  Direction = north,
  ?TESTED_MODULE:place( Robot, Direction, {7, 8} ),
  ?TESTED_MODULE:advance( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= Direction ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= {7, 9} ).

advance_south_test() ->
  Robot = ?TESTED_MODULE:create(),
  Direction = south,
  ?TESTED_MODULE:place( Robot, Direction, {9, 10} ),
  ?TESTED_MODULE:advance( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= Direction ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= {9, 9} ).

advance_east_test() ->
  Robot = ?TESTED_MODULE:create(),
  Direction = east,
  ?TESTED_MODULE:place( Robot, Direction, {11, 12} ),
  ?TESTED_MODULE:advance( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= Direction ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= {12, 12} ).

advance_west_test() ->
  Robot = ?TESTED_MODULE:create(),
  Direction = west,
  ?TESTED_MODULE:place( Robot, Direction, {13, 14} ),
  ?TESTED_MODULE:advance( Robot ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= Direction ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= {12, 14} ).

control_test() ->
  Robot = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:place( Robot, north, {7, 3} ),
  ?TESTED_MODULE:control( Robot, "RAALAL" ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= west ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= {9, 4} ).

control_unknown_test() ->
  Robot = ?TESTED_MODULE:create(),
  Direction = north,
  Position = {7, 3},
  ?TESTED_MODULE:place( Robot, Direction, Position ),
  ?TESTED_MODULE:control( Robot, "unknown" ),
  ?assert( ?TESTED_MODULE:direction(Robot) =:= Direction ),
  ?assert( ?TESTED_MODULE:position(Robot) =:= Position ).
