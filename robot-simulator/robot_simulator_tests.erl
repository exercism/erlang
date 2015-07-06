-module( robot_simulator_tests ).
-include_lib( "eunit/include/eunit.hrl" ).

create_test() ->
  Robot = robot_simulator:create(),
  ?assert( robot_simulator:direction(Robot) =:= undefined ),
  ?assert( robot_simulator:position(Robot) =:= {undefined, undefined} ).

place_test() ->
  Robot = robot_simulator:create(),
  Position = {1, 2},
  robot_simulator:place( Robot, north, Position ),
  ?assert( robot_simulator:direction(Robot) =:= north ),
  ?assert( robot_simulator:position(Robot) =:= Position ).

left_test() ->
  Robot = robot_simulator:create(),
  Position = {3, 4},
  robot_simulator:place( Robot, north, Position ),
  robot_simulator:left( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= west ),
  ?assert( robot_simulator:position(Robot) =:= Position ),
  robot_simulator:left( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= south ),
  ?assert( robot_simulator:position(Robot) =:= Position ),
  robot_simulator:left( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= east ),
  ?assert( robot_simulator:position(Robot) =:= Position ),
  robot_simulator:left( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= north ),
  ?assert( robot_simulator:position(Robot) =:= Position ).

right_test() ->
  Robot = robot_simulator:create(),
  Position = {5, 6},
  robot_simulator:place( Robot, north, Position ),
  robot_simulator:right( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= east ),
  ?assert( robot_simulator:position(Robot) =:= Position ),
  robot_simulator:right( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= south ),
  ?assert( robot_simulator:position(Robot) =:= Position ),
  robot_simulator:right( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= west ),
  ?assert( robot_simulator:position(Robot) =:= Position ),
  robot_simulator:right( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= north ),
  ?assert( robot_simulator:position(Robot) =:= Position ).

advance_north_test() ->
  Robot = robot_simulator:create(),
  Direction = north,
  robot_simulator:place( Robot, Direction, {7, 8} ),
  robot_simulator:advance( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= Direction ),
  ?assert( robot_simulator:position(Robot) =:= {7, 9} ).

advance_south_test() ->
  Robot = robot_simulator:create(),
  Direction = south,
  robot_simulator:place( Robot, Direction, {9, 10} ),
  robot_simulator:advance( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= Direction ),
  ?assert( robot_simulator:position(Robot) =:= {9, 9} ).

advance_east_test() ->
  Robot = robot_simulator:create(),
  Direction = east,
  robot_simulator:place( Robot, Direction, {11, 12} ),
  robot_simulator:advance( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= Direction ),
  ?assert( robot_simulator:position(Robot) =:= {12, 12} ).

advance_west_test() ->
  Robot = robot_simulator:create(),
  Direction = west,
  robot_simulator:place( Robot, Direction, {13, 14} ),
  robot_simulator:advance( Robot ),
  ?assert( robot_simulator:direction(Robot) =:= Direction ),
  ?assert( robot_simulator:position(Robot) =:= {12, 14} ).

control_test() ->
  Robot = robot_simulator:create(),
  robot_simulator:place( Robot, north, {7, 3} ),
  robot_simulator:control( Robot, "RAALAL" ),
  ?assert( robot_simulator:direction(Robot) =:= west ),
  ?assert( robot_simulator:position(Robot) =:= {9, 4} ).

control_unknown_test() ->
  Robot = robot_simulator:create(),
  Direction = north,
  Position = {7, 3},
  robot_simulator:place( Robot, Direction, Position ),
  robot_simulator:control( Robot, "unknown" ),
  ?assert( robot_simulator:direction(Robot) =:= Direction ),
  ?assert( robot_simulator:position(Robot) =:= Position ).
