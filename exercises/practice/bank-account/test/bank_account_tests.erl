-module(bank_account_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

create_test() ->
  BankAccount = bank_account:create(),
  ?assertMatch(0, bank_account:balance(BankAccount)).

close_account_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 1),
  Amount = bank_account:close(BankAccount),
  ?assertMatch(1, Amount),
  ?assertMatch({error, account_closed}, bank_account:balance(BankAccount)).

deposit_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 1),
  ?assertMatch(1, bank_account:balance(BankAccount)).

deposit_fail_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, -1),
  ?assertMatch(0, bank_account:balance(BankAccount)).

deposit_many_test() ->
  BankAccount = bank_account:create(),
  [erlang:spawn( fun () -> bank_account:deposit(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  timer:sleep(100),
  Last = bank_account:balance(BankAccount),
  ?assertMatch(55, Last).

withdraw_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10 ),
  Amount = bank_account:withdraw(BankAccount, 1),
  ?assertMatch(1, Amount),
  ?assertMatch(9, bank_account:balance(BankAccount)).

withdraw_fail_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:withdraw(BankAccount, -1),
  ?assertMatch(0, Amount),
  ?assertMatch(10, bank_account:balance(BankAccount)).

withdraw_excessive_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10 ),
  Amount = bank_account:withdraw(BankAccount, 20),
  ?assertMatch(10, Amount),
  ?assertMatch(0, bank_account:balance(BankAccount)).

withdraw_many_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> bank_account:withdraw(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  timer:sleep(100),
  Last = bank_account:balance(BankAccount),
  ?assertMatch(0, Last).

charge_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:charge(BankAccount, 2),
  ?assertMatch(2, Amount),
  ?assertMatch(8, bank_account:balance(BankAccount)).

charge_fail_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:charge(BankAccount, -2),
  ?assertMatch(0, Amount),
  ?assertMatch(10, bank_account:balance(BankAccount)).

charge_excessive_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 10),
  Amount = bank_account:charge(BankAccount, 20),
  ?assertMatch(0, Amount),
  ?assertMatch(10, bank_account:balance(BankAccount)).

charge_many_test() ->
  BankAccount = bank_account:create(),
  bank_account:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> bank_account:charge(BankAccount, 10) end ) || _X <- lists:seq(1, 10)],
  timer:sleep(100),
  Last = bank_account:balance(BankAccount),
  ?assertMatch(5, Last).
