-module(bank_account_tests).
-include_lib("eunit/include/eunit.hrl").


create_test() ->
  Bank_account = bank_account:create(),
  ?assert(bank_account:balance( Bank_account ) =:= 0).

close_account_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 1 ),
  Amount = bank_account:close( Bank_account ),
  ?assert(Amount =:= 1),
  ?assertEqual({error, account_closed}, bank_account:balance( Bank_account )).

deposit_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 1 ),
  ?assert(bank_account:balance( Bank_account ) =:= 1).

deposit_fail_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, -1 ),
  ?assert(bank_account:balance( Bank_account ) =:= 0).

deposit_many_test() ->
  Bank_account = bank_account:create(),
  [erlang:spawn( fun () -> bank_account:deposit(Bank_account, X) end ) || X <- lists:seq(1, 10)],
  First = bank_account:balance( Bank_account ),
  timer:sleep( 100 ),
  Last = bank_account:balance( Bank_account ),
  ?assert(First < 55),
  ?assert(Last =:= 55).

withdraw_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 10 ),
  Amount = bank_account:withdraw( Bank_account, 1 ),
  ?assert(Amount =:= 1),
  ?assert(bank_account:balance( Bank_account ) =:= 9).

withdraw_fail_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 10 ),
  Amount = bank_account:withdraw( Bank_account, -1 ),
  ?assert(Amount =:= 0),
  ?assert(bank_account:balance( Bank_account ) =:= 10).

withdraw_excessive_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 10 ),
  Amount = bank_account:withdraw( Bank_account, 20 ),
  ?assert(Amount =:= 10),
  ?assert(bank_account:balance( Bank_account ) =:= 0).

withdraw_many_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit(Bank_account, 55 ),
  [erlang:spawn( fun () -> bank_account:withdraw(Bank_account, X) end ) || X <- lists:seq(1, 10)],
  First = bank_account:balance( Bank_account ),
  timer:sleep( 100 ),
  Last = bank_account:balance( Bank_account ),
  ?assert(First > 0),
  ?assert(Last =:= 0).

charge_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 10 ),
  Amount = bank_account:charge( Bank_account, 2 ),
  ?assert(Amount =:= 2),
  ?assert(bank_account:balance( Bank_account ) =:= 8).

charge_fail_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 10 ),
  Amount = bank_account:charge( Bank_account, -2 ),
  ?assert(Amount =:= 0),
  ?assert(bank_account:balance( Bank_account ) =:= 10).

charge_excessive_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit( Bank_account, 10 ),
  Amount = bank_account:charge( Bank_account, 20 ),
  ?assert(Amount =:= 0),
  ?assert(bank_account:balance( Bank_account ) =:= 10).

charge_many_test() ->
  Bank_account = bank_account:create(),
  bank_account:deposit(Bank_account, 55 ),
  [erlang:spawn( fun () -> bank_account:charge(Bank_account, 10) end ) || _X <- lists:seq(1, 10)],
  First = bank_account:balance( Bank_account ),
  timer:sleep( 100 ),
  Last = bank_account:balance( Bank_account ),
  ?assert(First > 0),
  ?assert(Last =:= 5).
