-module( circular_buffer_tests ).

-define(TESTED_MODULE, (sut(circular_buffer))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


create_test() ->
  Pid = ?TESTED_MODULE:create( 5 ),
  ?assert( {ok, 5} =:= ?TESTED_MODULE:size(Pid) ).

write_read_test() ->
  Pid = ?TESTED_MODULE:create( 4 ),
  ?assert( {error, empty} =:= ?TESTED_MODULE:read(Pid) ),
  ?TESTED_MODULE:write( Pid, 1 ),
  ?assert( {ok, 1} =:= ?TESTED_MODULE:read(Pid) ).

write_read_many_test() ->
  Pid = ?TESTED_MODULE:create( 3 ),
  ?TESTED_MODULE:write( Pid, 1 ),
  ?TESTED_MODULE:write( Pid, 2 ),
  ?TESTED_MODULE:write( Pid, 3 ),
  ?assert( {ok, 1} =:= ?TESTED_MODULE:read(Pid) ),
  ?assert( {ok, 2} =:= ?TESTED_MODULE:read(Pid) ),
  ?assert( {ok, 3} =:= ?TESTED_MODULE:read(Pid) ).

over_write_read_test() ->
  Pid = ?TESTED_MODULE:create( 2 ),
  ?TESTED_MODULE:write( Pid, 1 ),
  ?TESTED_MODULE:write( Pid, 2 ),
  ?TESTED_MODULE:write( Pid, 3 ),
  ?TESTED_MODULE:write( Pid, 4 ),
  ?assert( {ok, 3} =:= ?TESTED_MODULE:read(Pid) ),
  ?assert( {ok, 4} =:= ?TESTED_MODULE:read(Pid) ),
  ?assert( {error, empty} =:= ?TESTED_MODULE:read(Pid) ).

write_attempt_test() ->
  Pid = ?TESTED_MODULE:create( 1 ),
  Attempt1 = ?TESTED_MODULE:write_attempt( Pid, 1 ),
  ?assert( ok =:= Attempt1 ),
  Attempt2 = ?TESTED_MODULE:write_attempt( Pid, 2 ),
  ?assert( {error, full} =:= Attempt2 ),
  ?assert( {ok, 1} =:= ?TESTED_MODULE:read(Pid) ).

producer_consumer_test() ->
  Pid = ?TESTED_MODULE:create( 3 ),
  erlang:spawn( fun() ->
                    [?TESTED_MODULE:write(Pid, X) || X <- [1,2,3]]
                end ),
  My_pid = erlang:self(),
  Ref = erlang:make_ref(),
  erlang:spawn( fun() ->
                    My_pid ! {Ref, [?TESTED_MODULE:read(Pid) || _X <- [1,2,3]]}
                end ),
  Reads = receive
            {Ref, R} -> R
          end,
  ?assert( Reads =:= [{ok, 1}, {ok, 2}, {ok, 3}] ).
