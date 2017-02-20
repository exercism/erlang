-module(example).

-export([encrypt/2, decrypt/2, test_version/0]).

encrypt(String, N) ->
  lists:map(fun
    (C) when $a =< C, C =< $z ->
      ((C - $a + N) rem 26) + $a;
    (C) when $A =< C, C =< $Z ->
      ((C - $A + N) rem 26) + $A;
    (C) ->
      C
  end, String).

decrypt(String, N) ->
  encrypt(String, 26 - N).

test_version() ->
  1.
