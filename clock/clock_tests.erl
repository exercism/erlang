-module( clock_tests ).
-include_lib( "eunit/include/eunit.hrl" ).

create_test() ->
  clock:create( 0, 0 ),
  ?assertException( error, function_clause, clock:create(-1, 0) ),
  ?assertException( error, function_clause, clock:create(0, -1) ),
  ?assertException( error, function_clause, clock:create(24, 0) ),
  ?assertException( error, function_clause, clock:create(0, 60) ).

to_string_test() ->
  ?assert( "00:00" =:= clock:to_string(clock:create(0, 0)) ),
  ?assert( "00:01" =:= clock:to_string(clock:create(0, 1)) ),
  ?assert( "01:00" =:= clock:to_string(clock:create(1, 0)) ),
  ?assert( "23:59" =:= clock:to_string(clock:create(23, 59)) ).

is_equal_test() ->
  Clock1 = clock:create( 1, 0 ),
  Clock2 = clock:create( 1, 0 ),
  ?assert( clock:is_equal(Clock1, Clock2) ).

minutes_add_test() ->
  Clock1 = clock:create( 1, 0 ),
  Clock2 = clock:minutes_add( Clock1, 10 ),
  ?assert( "01:10" =:= clock:to_string(Clock2) ),
  Clock3 = clock:minutes_add( Clock1, 4 * 60 + 50 ),
  ?assert( "05:50" =:= clock:to_string(Clock3) ),
  Clock4 = clock:create( 23, 59 ),
  Clock5 = clock:minutes_add( Clock4, 1 ),
  ?assert( "00:00" =:= clock:to_string(Clock5) ).

minutes_delete_test() ->
  Clock1 = clock:create( 1, 0 ),
  Clock2 = clock:minutes_delete( Clock1, 10 ),
  ?assert( "00:50" =:= clock:to_string(Clock2) ),
  Clock3 = clock:minutes_delete( Clock1, 4 * 60 + 50 ),
  ?assert( "20:10" =:= clock:to_string(Clock3) ).
