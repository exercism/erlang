-module(bank_account_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(TESTED_MODULE, (sut(bank_account))).

create_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 0).

close_account_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 1),
  Amount = ?TESTED_MODULE:close(BankAccount),
  ?assert(Amount =:= 1),
  ?assertEqual({error, account_closed}, ?TESTED_MODULE:balance( BankAccount )).

deposit_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 1),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 1).

deposit_fail_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, -1),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 0).

deposit_many_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  [erlang:spawn( fun () -> ?TESTED_MODULE:deposit(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  First = ?TESTED_MODULE:balance(BankAccount),
  timer:sleep(100),
  Last = ?TESTED_MODULE:balance(BankAccount),
  ?assert(First < 55),
  ?assert(Last =:= 55).

withdraw_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 10 ),
  Amount = ?TESTED_MODULE:withdraw(BankAccount, 1),
  ?assert(Amount =:= 1),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 9).

withdraw_fail_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 10),
  Amount = ?TESTED_MODULE:withdraw(BankAccount, -1),
  ?assert(Amount =:= 0),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 10).

withdraw_excessive_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 10 ),
  Amount = ?TESTED_MODULE:withdraw(BankAccount, 20),
  ?assert(Amount =:= 10),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 0).

withdraw_many_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> ?TESTED_MODULE:withdraw(BankAccount, X) end ) || X <- lists:seq(1, 10)],
  First = ?TESTED_MODULE:balance(BankAccount),
  timer:sleep(100),
  Last = ?TESTED_MODULE:balance(BankAccount),
  ?assert(First > 0),
  ?assert(Last =:= 0).

charge_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 10),
  Amount = ?TESTED_MODULE:charge(BankAccount, 2),
  ?assert(Amount =:= 2),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 8).

charge_fail_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 10),
  Amount = ?TESTED_MODULE:charge(BankAccount, -2),
  ?assert(Amount =:= 0),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 10).

charge_excessive_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 10),
  Amount = ?TESTED_MODULE:charge(BankAccount, 20),
  ?assert(Amount =:= 0),
  ?assert(?TESTED_MODULE:balance(BankAccount) =:= 10).

charge_many_test() ->
  BankAccount = ?TESTED_MODULE:create(),
  ?TESTED_MODULE:deposit(BankAccount, 55 ),
  [erlang:spawn( fun () -> ?TESTED_MODULE:charge(BankAccount, 10) end ) || _X <- lists:seq(1, 10)],
  First = ?TESTED_MODULE:balance(BankAccount),
  timer:sleep(100),
  Last = ?TESTED_MODULE:balance(BankAccount),
  ?assert(First > 0),
  ?assert(Last =:= 5).
