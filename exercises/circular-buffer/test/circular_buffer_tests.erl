-module( circular_buffer_tests ).

-include("exercism.hrl").
-include_lib( "eunit/include/eunit.hrl" ).

get_module_name() ->
  sut(circular_buffer).

create_test() ->
  CircularBuffer = get_module_name(),
  Pid = CircularBuffer:create( 5 ),
  ?assert( {ok, 5} =:= CircularBuffer:size(Pid) ).

write_read_test() ->
  CircularBuffer = get_module_name(),
  Pid = CircularBuffer:create( 4 ),
  ?assert( {error, empty} =:= CircularBuffer:read(Pid) ),
  CircularBuffer:write( Pid, 1 ),
  ?assert( {ok, 1} =:= CircularBuffer:read(Pid) ).

write_read_many_test() ->
  CircularBuffer = get_module_name(),
  Pid = CircularBuffer:create( 3 ),
  CircularBuffer:write( Pid, 1 ),
  CircularBuffer:write( Pid, 2 ),
  CircularBuffer:write( Pid, 3 ),
  ?assert( {ok, 1} =:= CircularBuffer:read(Pid) ),
  ?assert( {ok, 2} =:= CircularBuffer:read(Pid) ),
  ?assert( {ok, 3} =:= CircularBuffer:read(Pid) ).

over_write_read_test() ->
  CircularBuffer = get_module_name(),
  Pid = CircularBuffer:create( 2 ),
  CircularBuffer:write( Pid, 1 ),
  CircularBuffer:write( Pid, 2 ),
  CircularBuffer:write( Pid, 3 ),
  CircularBuffer:write( Pid, 4 ),
  ?assert( {ok, 3} =:= CircularBuffer:read(Pid) ),
  ?assert( {ok, 4} =:= CircularBuffer:read(Pid) ),
  ?assert( {error, empty} =:= CircularBuffer:read(Pid) ).

write_attempt_test() ->
  CircularBuffer = get_module_name(),
  Pid = CircularBuffer:create( 1 ),
  Attempt1 = CircularBuffer:write_attempt( Pid, 1 ),
  ?assert( ok =:= Attempt1 ),
  Attempt2 = CircularBuffer:write_attempt( Pid, 2 ),
  ?assert( {error, full} =:= Attempt2 ),
  ?assert( {ok, 1} =:= CircularBuffer:read(Pid) ).

producer_consumer_test() ->
  CircularBuffer = get_module_name(),
  Pid = CircularBuffer:create( 3 ),
  erlang:spawn( fun() ->
                    [CircularBuffer:write(Pid, X) || X <- [1,2,3]]
                end ),
  My_pid = erlang:self(),
  Ref = erlang:make_ref(),
  erlang:spawn( fun() ->
                    My_pid ! {Ref, [CircularBuffer:read(Pid) || _X <- [1,2,3]]}
                end ),
  Reads = receive
            {Ref, R} -> R
          end,
  ?assert( Reads =:= [{ok, 1}, {ok, 2}, {ok, 3}] ).
