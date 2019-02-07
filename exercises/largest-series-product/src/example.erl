-module(example).

-export([largest_product/2]).

-define(is_digit(C), ((C >= $0) andalso (C =< $9))).

largest_product(_String, N) when N < 0 -> error(badarg);
largest_product(String, N) when N > length(String) -> error(badarg);
largest_product(String, N) -> lsp(erlang:length(String), String, N).


lsp(Length, String, N) ->
  Sets = sets(Length, N, String),
  lists:max([product(X) || X <- Sets]).

product(Set) -> lists:foldl(fun product/2, 1, Set).

product(C, _Acc) when not ?is_digit(C) -> error(badarg);
product(C, Acc) -> (C - $0) * Acc.

sets(Length, Width, [_ | T] = String) when Length > Width ->
  Set = lists:sublist(String, Width),
  [Set | sets(Length - 1, Width, T)];
sets(_Length, _Width, String) -> [String].
