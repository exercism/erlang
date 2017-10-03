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
  case re:run(Number, "^[0-9 ]+$") of
    {match, _} -> true;
    nomatch    -> false
  end.



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
  is_numeric(Number) andalso checksum(Number) rem 10 == 0 andalso is_min_length(Number).



test_version() ->
    1.1.
