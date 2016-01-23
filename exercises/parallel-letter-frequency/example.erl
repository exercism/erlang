-module( parallel_letter_frequency ).

-export( [dict/1] ).

dict( Texts ) ->
  Pids = [letter_frequency(X) || X <- Texts],
  Dicts = [receive_dict(X) || X <- Pids],
  merge_dicts( Dicts ).



letter_frequency( String ) ->
  My_pid = erlang:self(),
  erlang:spawn( fun() -> My_pid ! {erlang:self(), letter_freqency_dict(String)} end ).

letter_freqency_dict( String ) ->
  lists:foldl( fun letter_freqency_dict/2, dict:new(), String ).

letter_freqency_dict( Character, Dict ) -> dict:update_counter( Character, 1, Dict ).

merge_dicts( [Dict | Dicts] ) ->
  lists:foldl( fun merge_dicts/2, Dict, Dicts ).

merge_dicts( Dict, Acc ) -> dict:merge( fun merge_dicts/3, Dict, Acc ).

merge_dicts( _Key, Value, Acc_value ) -> Value + Acc_value.

receive_dict( Pid ) ->
  receive
    {Pid, Dict} -> Dict
  end.
