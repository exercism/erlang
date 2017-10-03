-module(example).
-export([valid/1, test_version/0]).



checksum(Number) ->
  checksum(
    lists:reverse(
      lists:filter(
        fun(C) ->
            ($0 =< C) andalso (C =< $9)
        end,
        Number
       )
     ),
    odd,
    0
   ).



is_numeric(Number) ->
  lists:all(
  	fun(C) ->
  		(($0 =< C) andalso (C =< $9)) or (C == $\s)
  	end,
  	Number).



is_min_length(Number) -> 
  length(re:replace(Number, "(^\\s+)|(\\s+$)", "", [global,{return,list}])) > 1.



checksum([], _, Total) ->
  Total;

checksum([H | ReversedNumber], odd, Total) ->
  checksum(ReversedNumber, even, Total + H - $0);

checksum([H | ReversedNumber], even, Total) when H < $5 ->
  checksum(ReversedNumber, odd, Total + (H - $0) * 2);

checksum([H | ReversedNumber], even, Total) when H >= $5 ->
  checksum(ReversedNumber, odd, Total + ((H - $0) * 2) - 9).



valid(Number) ->
  case is_numeric(Number) of
    true ->
      case is_min_length(Number) of
      	true ->
	      case lists:filter(
	        fun(C) ->
	            ($0 =< C) andalso (C =< $9)
	        end,
	        Number
	      ) of
	        Number2 = [_|_] ->
	          checksum(Number2) rem 10 == 0;
	        _ -> false
	      end;
        _ -> false
      end;
    _ -> false
 end.



test_version() ->
    1.1.
