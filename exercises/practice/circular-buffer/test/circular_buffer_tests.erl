-module( circular_buffer_tests ).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

create_test() ->
  Pid = circular_buffer:create( 5 ),
  ?assertMatch( {ok, 5}, circular_buffer:size(Pid) ).

write_read_test() ->
  Pid = circular_buffer:create( 4 ),
  ?assertMatch( {error, empty}, circular_buffer:read(Pid) ),
  circular_buffer:write( Pid, 1 ),
  ?assertMatch( {ok, 1}, circular_buffer:read(Pid) ).

write_read_many_test() ->
  Pid = circular_buffer:create( 3 ),
  circular_buffer:write( Pid, 1 ),
  circular_buffer:write( Pid, 2 ),
  circular_buffer:write( Pid, 3 ),
  ?assertMatch( {ok, 1}, circular_buffer:read(Pid) ),
  ?assertMatch( {ok, 2}, circular_buffer:read(Pid) ),
  ?assertMatch( {ok, 3}, circular_buffer:read(Pid) ).

over_write_read_test() ->
  Pid = circular_buffer:create( 2 ),
  circular_buffer:write( Pid, 1 ),
  circular_buffer:write( Pid, 2 ),
  circular_buffer:write( Pid, 3 ),
  circular_buffer:write( Pid, 4 ),
  ?assertMatch( {ok, 3}, circular_buffer:read(Pid) ),
  ?assertMatch( {ok, 4}, circular_buffer:read(Pid) ),
  ?assertMatch( {error, empty}, circular_buffer:read(Pid) ).

write_attempt_test() ->
  Pid = circular_buffer:create( 1 ),
  Attempt1 = circular_buffer:write_attempt( Pid, 1 ),
  ?assertMatch( ok, Attempt1 ),
  Attempt2 = circular_buffer:write_attempt( Pid, 2 ),
  ?assertMatch( {error, full}, Attempt2 ),
  ?assertMatch( {ok, 1}, circular_buffer:read(Pid) ).

producer_consumer_test() ->
  Pid = circular_buffer:create( 3 ),
  erlang:spawn( fun() ->
                    [circular_buffer:write(Pid, X) || X <- [1,2,3]]
                end ),
  My_pid = erlang:self(),
  Ref = erlang:make_ref(),
  erlang:spawn( fun() ->
                    My_pid ! {Ref, [circular_buffer:read(Pid) || _X <- [1,2,3]]}
                end ),
  Reads = receive
            {Ref, R} -> R
          end,
  ?assertMatch( [{ok, 1}, {ok, 2}, {ok, 3}], Reads ).
