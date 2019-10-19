-module(circular_buffer).

-export([create/1, read/1, size/1, write/2, write_attempt/2]).

-spec create(integer()) -> pid().

create(_Size) ->
  undefined.

-spec read(pid()) -> {ok, Item :: term()} | {error, empty}.

read(_Pid) ->
  undefined.

-spec size(pid()) -> integer().

size(_Pid) ->
  undefined.

-spec write(pid(), Item :: term()) -> ok.

write(_Pid, _Item) ->
  undefined.

-spec write_attempt(pid(), Item :: term()) -> ok | {error, full}.

write_attempt(_Pid, _Item) ->
  undefined.
