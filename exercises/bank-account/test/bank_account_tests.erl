-module(bank_account_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

get_module_name() ->
  sut(bank_account).

create_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  ?assert(BankAccountModule:balance(BankAccount) =:= 0).

close_account_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 1),
  Amount = BankAccountModule:close(BankAccount),
  ?assert(Amount =:= 1),
  ?assertEqual({error, account_closed}, BankAccountModule:balance( BankAccount )).

deposit_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 1),
  ?assert(BankAccountModule:balance(BankAccount) =:= 1).

deposit_fail_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, -1),
  ?assert(BankAccountModule:balance(BankAccount) =:= 0).

deposit_many_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  [erlang:spawn( fun () -> BankAccountModule:deposit(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  First = BankAccountModule:balance(BankAccount),
  timer:sleep(100),
  Last = BankAccountModule:balance(BankAccount),
  ?assert(First < 55),
  ?assert(Last =:= 55).

withdraw_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 10 ),
  Amount = BankAccountModule:withdraw(BankAccount, 1),
  ?assert(Amount =:= 1),
  ?assert(BankAccountModule:balance(BankAccount) =:= 9).

withdraw_fail_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 10),
  Amount = BankAccountModule:withdraw(BankAccount, -1),
  ?assert(Amount =:= 0),
  ?assert(BankAccountModule:balance(BankAccount) =:= 10).

withdraw_excessive_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 10 ),
  Amount = BankAccountModule:withdraw(BankAccount, 20),
  ?assert(Amount =:= 10),
  ?assert(BankAccountModule:balance(BankAccount) =:= 0).

withdraw_many_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> BankAccountModule:withdraw(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  First = BankAccountModule:balance(BankAccount),
  timer:sleep(100),
  Last = BankAccountModule:balance(BankAccount),
  ?assert(First > 0),
  ?assert(Last =:= 0).

charge_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 10),
  Amount = BankAccountModule:charge(BankAccount, 2),
  ?assert(Amount =:= 2),
  ?assert(BankAccountModule:balance(BankAccount) =:= 8).

charge_fail_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 10),
  Amount = BankAccountModule:charge(BankAccount, -2),
  ?assert(Amount =:= 0),
  ?assert(BankAccountModule:balance(BankAccount) =:= 10).

charge_excessive_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 10),
  Amount = BankAccountModule:charge(BankAccount, 20),
  ?assert(Amount =:= 0),
  ?assert(BankAccountModule:balance(BankAccount) =:= 10).

charge_many_test() ->
  BankAccountModule = get_module_name(),
  BankAccount = BankAccountModule:create(),
  BankAccountModule:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> BankAccountModule:charge(BankAccount, 10) end ) || _X <- lists:seq(1, 10)],
  First = BankAccountModule:balance(BankAccount),
  timer:sleep(100),
  Last = BankAccountModule:balance(BankAccount),
  ?assert(First > 0),
  ?assert(Last =:= 5).
