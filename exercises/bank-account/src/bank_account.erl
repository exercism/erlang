-module(bank_account).

-export([balance/1, charge/2, close/1, create/0, deposit/2, withdraw/2]).

-type account_closed() :: {error, account_closed}.

-type amount() :: integer().

-type response() :: amount() | account_closed().

-spec balance(pid()) -> response().

balance(_Pid) ->
  undefined.

-spec charge(pid(), amount()) -> response().

charge(_Pid, _Amount) ->
  undefined.

-spec close(pid()) -> response().

close(_Pid) ->
  undefined.

-spec create() -> pid().

create() ->
  undefined.

-spec deposit(pid(), amount()) -> response().

deposit(_Pid, _Amount) ->
  undefined.

-spec withdraw(pid(), amount()) -> response().

withdraw(_Pid, _Amount) ->
  undefined.
