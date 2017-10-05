-module(example).
-export([valid/1, test_version/0]).



checksum(Number) ->
  checksum(
    lists:reverse(
      filter_input(Number)
     ),
    odd,
    0
   ).



is_numeric(Number) ->
  lists:all(
  	fun(C) ->
  		(($0 =< C) andalso (C =< $9)) or (C == $\s)
  	end,
  	Number
  ).



filter_input(Number) ->
  lists:filter(
    fun(C) ->
      ($0 =< C) andalso (C =< $9)
    end,
    Number
  ).



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
      case filter_input(Number) of
        Number2 = [_,_|_] ->
          checksum(Number2) rem 10 == 0;
        _ -> false
      end;
    _ -> false
  end.



test_version() ->
    2.
