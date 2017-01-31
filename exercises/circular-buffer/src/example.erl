-module(example).

-export( [create/1, read/1, size/1, write/2, write_attempt/2] ).

create( Size ) -> erlang:spawn( fun() -> loop( 0, Size, queue:new() ) end ).

read( Pid ) -> request( Pid, read ).

size( Pid ) -> request( Pid, size ).

write( Pid, Item ) -> Pid ! {write, Item}.

write_attempt( Pid, Item ) ->
  Pid ! {write_attempt, Item, erlang:self()},
  receive
    {write_attempt, true, Pid} -> ok;
    {write_attempt, false, Pid} -> {error, full}
  end.

loop( Current_size, Max_size, Queue ) ->
  receive
    {read, Pid} ->
      {Result, New_queue} = queue:out( Queue ),
      Pid ! {read, Result, erlang:self()},
      loop( Current_size - 1, Max_size, New_queue );
    {size, Pid} ->
      Pid ! {size, Max_size, erlang:self()},
      loop( Current_size, Max_size, Queue );
    {write, Item} ->
      {New_size, New_queue} = write( Current_size, Max_size, Item, Queue ),
      loop( New_size, Max_size, New_queue );
    {write_attempt, Item, Pid} ->
      Pid ! {write_attempt, Current_size < Max_size, erlang:self()},
      {New_size, New_queue} = write_attempt( Current_size, Max_size, Item, Queue ),
      loop( New_size, Max_size, New_queue )
  end.

request( Pid, Request ) ->
  Pid ! {Request, erlang:self()},
  receive
    {Request, empty, Pid} -> {error, empty};
    {Request, {value, Answer}, Pid} -> {ok, Answer};
    {Request, Answer, Pid} -> {ok, Answer}
  end.

write( Current, Max, Item, Queue ) when Current < Max ->
  {Current + 1, queue:in( Item, Queue )};
write( Max, Max, Item, Queue ) ->
  {_Old, New_queue} = queue:out( Queue ),
  {Max, queue:in( Item, New_queue )}.

write_attempt( Max, Max, _Item, Queue ) -> {Max, Queue};
write_attempt( Current, Max, Item, Queue ) -> write( Current, Max, Item, Queue ).
