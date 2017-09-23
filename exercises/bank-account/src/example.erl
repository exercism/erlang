-module(example).

-export( [balance/1, charge/2, close/1, create/0, deposit/2, withdraw/2, test_version/0] ).


balance( Pid ) -> call( erlang:is_process_alive(Pid), Pid, balance, 0 ).

charge( Pid, Amount ) when Amount > 0 -> call( erlang:is_process_alive(Pid), Pid, charge, Amount );
charge( _Pid, _Amount ) -> 0.

close( Pid ) -> call( erlang:is_process_alive(Pid), Pid, close, 0 ).

create() -> erlang:spawn( fun () -> loop(0) end ).

deposit( Pid, Amount ) when Amount > 0 -> call( erlang:is_process_alive(Pid), Pid, deposit, Amount );
deposit( _Pid, _Amount ) -> ok.

withdraw( Pid, Amount ) when Amount > 0 -> call( erlang:is_process_alive(Pid), Pid, withdraw, Amount );
withdraw( _Pid, _Amount ) -> 0.

test_version() ->
    1.



call( true, Pid, Request, Argument ) ->
  Pid ! {Request, Argument, erlang:self()},
  receive
    {Request, Answer} -> Answer
  end;
call( false, _Pid, _Request, _Argument ) ->
  {error, account_closed}.

loop( Balance ) ->
  receive
    {balance, _Argument, Pid} ->
      Pid ! {balance, Balance},
      loop( Balance );
    {charge, Amount, Pid} ->
      Charge = loop_charge( Balance, Amount ),
      Pid ! {charge, Charge},
      loop( Balance - Charge );
    {close, _Argument, Pid} ->
      Pid ! {close, Balance};
    {deposit, Amount, Pid} ->
      Pid ! {deposit, Amount},
      loop( Balance + Amount );
    {withdraw, Amount, Pid} ->
      Withdraw = erlang:min( Balance, Amount ),
      Pid ! {withdraw, Withdraw},
      loop( Balance - Withdraw )
  end.

loop_charge( Balance, Amount ) when Balance >= Amount -> Amount;
loop_charge( _Balance, _Amount ) -> 0.
