-module(example).

-export([
  balance/1,
  charge/2,
  close/1,
  create/0,
  deposit/2,
  withdraw/2,
  test_version/0
]).

-export([
  init/1,
  handle_call/3,
  handle_cast/2
]).

-behaviour(gen_server).

-record(account, {pid}).


test_version() ->
    1.


%%% Public API

create() ->
  {ok, PID} = gen_server:start(?MODULE, [], []),
  #account{pid=PID}.

balance(#account{pid=PID}) ->
  gen_server:call(PID, balance, infinity).

charge(#account{pid=PID}, Amount) ->
  gen_server:call(PID, {charge, Amount}, infinity).

close(#account{pid=PID}) ->
  gen_server:call(PID, close, infinity).

deposit(#account{pid=PID}, Amount) ->
  gen_server:call(PID, {deposit, Amount}, infinity).

withdraw(#account{pid=PID}, Amount) ->
  gen_server:call(PID, {withdraw, Amount}, infinity).

%%% gen_server API

init([]) ->
  {ok, 0}.

handle_call(_, _From, closed) ->
  {reply, {error, account_closed}, closed};
handle_call(close, _From, Balance) ->
  {reply, Balance, closed};
handle_call(balance, _From, Balance) ->
  {reply, Balance, Balance};
handle_call({deposit, Amount}, _From, Balance) when Amount > 0 ->
  {reply, Amount, Balance + Amount};
handle_call({deposit, _}, _From, Balance) ->
  {reply, Balance, Balance};
handle_call({withdraw, Amount}, _From, Balance) when Amount > Balance ->
  {reply, Balance, 0};
handle_call({withdraw, Amount}, _From, Balance) when Amount > 0 ->
  Balance1 = Balance - Amount,
  {reply, Amount, Balance1};
handle_call({withdraw, _}, _From, Balance) ->
  {reply, 0, Balance};
handle_call({charge, Amount}, _From, Balance) when Amount > Balance ->
  {reply, 0, Balance};
handle_call({charge, Amount}, _From, Balance) when Amount > 0 ->
  {reply, Amount, Balance - Amount};
handle_call({charge, _}, _From, Balance) ->
  {reply, 0, Balance}.


handle_cast(_, Balance) ->
  {noreply, Balance}.