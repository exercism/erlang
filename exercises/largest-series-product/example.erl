-module('largest_series_product').

-export([lsp/2]).

-define(is_digit(C), ((C >= $0) and (C =< $9))).

lsp(_String, N) when N < 0 -> error;
lsp(String, N) -> lsp(erlang:length(String), String, N).



lsp(Length, _String, N) when Length < N -> error;
lsp(Length, String, N) ->
  Sets = sets(Length, N, String),
  lists:max([product(X) || X <- Sets]).

product(Set) -> lists:foldl(fun product/2, 1, Set).

product(_C, error) -> error;
product(C, _Acc) when not ?is_digit(C) -> error;
product(C, Acc) -> (C - $0) * Acc.

sets(Length, Width, [_ | T] = String) when Length > Width ->
  Set = lists:sublist(String, Width),
  [Set | sets(Length - 1, Width, T)];
sets(_Length, _Width, String) -> [String].
