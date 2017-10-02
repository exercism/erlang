-module(example).
-export([valid/1, create/1, checksum/1, isNumeric/1, isMinLength/1, test_version/0]).



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



isNumeric(Number) -> 
  case re:run(Number, "^[0-9 ]+$") of
    {match, Captured} -> true;
    nomatch    -> false
  end.



isMinLength(Number) -> 
  re:replace(Number, "(^\\s+)|(\\s+$)", "", [global,{return,list}]).



checksum([], _, Total) ->
  Total;

checksum([H | ReversedNumber], odd, Total) ->
  checksum(ReversedNumber, even, Total + H - $0);

checksum([H | ReversedNumber], even, Total) when H < $5 ->
  checksum(ReversedNumber, odd, Total + (H - $0) * 2);

checksum([H | ReversedNumber], even, Total) when H >= $5 ->
  checksum(ReversedNumber, odd, Total + ((H - $0) * 2) - 9).



valid(Number) ->
  isNumeric(Number) andalso checksum(Number) rem 10 == 0 andalso length(isMinLength(Number)) > 1.



create(Number) ->
  lists:flatten([Number, ($: - (checksum(Number ++ [$0]) rem 10))]).



test_version() ->
    1.
