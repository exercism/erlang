-module(binary_string_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

get_module_name() ->
  sut(binary_string).

one_test() -> check( "1" ).

two_test() -> check( "10" ).

three_test() -> check( "11" ).

four_test() -> check( "100" ).

nine_test() -> check( "1001" ).

twenty_six_test() -> check( "11010" ).

large_test() -> check( "10001101000" ).

carrot_test() ->
  Binary = get_module_name(),
  ?assert(0 =:= Binary:to_decimal( "carrot" )).

check(String) ->
  Binary = get_module_name(),
  ?assert(Binary:to_decimal(String) =:= erlang:list_to_integer(String, 2)).
