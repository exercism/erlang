-module(bank_account_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

create_test() ->
  BankAccount = bank_account:create(),
  ?assert(bank_account:balance(BankAccount) =:= 0).

close_account_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 1),
  Amount = bank_account:close(BankAccount),
  ?assert(Amount =:= 1),
  ?assertEqual({error, account_closed}, bank_account:balance( BankAccount )).

deposit_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 1),
  ?assert(bank_account:balance(BankAccount) =:= 1).

deposit_fail_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, -1),
  ?assert(bank_account:balance(BankAccount) =:= 0).

deposit_many_test() ->
  BankAccount = bank_account:create(),
  [erlang:spawn( fun () -> bank_account:deposit(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  timer:sleep(100),
  Last = bank_account:balance(BankAccount),
  ?assert(Last =:= 55).

withdraw_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10 ),
  Amount = bank_account:withdraw(BankAccount, 1),
  ?assert(Amount =:= 1),
  ?assert(bank_account:balance(BankAccount) =:= 9).

withdraw_fail_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:withdraw(BankAccount, -1),
  ?assert(Amount =:= 0),
  ?assert(bank_account:balance(BankAccount) =:= 10).

withdraw_excessive_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10 ),
  Amount = bank_account:withdraw(BankAccount, 20),
  ?assert(Amount =:= 10),
  ?assert(bank_account:balance(BankAccount) =:= 0).

withdraw_many_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> bank_account:withdraw(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  timer:sleep(100),
  Last = bank_account:balance(BankAccount),
  ?assert(Last =:= 0).

charge_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:charge(BankAccount, 2),
  ?assert(Amount =:= 2),
  ?assert(bank_account:balance(BankAccount) =:= 8).

charge_fail_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:charge(BankAccount, -2),
  ?assert(Amount =:= 0),
  ?assert(bank_account:balance(BankAccount) =:= 10).

charge_excessive_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:charge(BankAccount, 20),
  ?assert(Amount =:= 0),
  ?assert(bank_account:balance(BankAccount) =:= 10).

charge_many_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> bank_account:charge(BankAccount, 10) end ) || _X <- lists:seq(1, 10)],
  timer:sleep(100),
  Last = bank_account:balance(BankAccount),
  ?assert(Last =:= 5).
