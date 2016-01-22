% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(hello_world, [verbose])" -s init stop
%

-module(hello_world_tests).
-include_lib("eunit/include/eunit.hrl").

no_name_test() ->
  ?assertEqual("Hello, World!", hello_world:greet()).

alice_test() ->
  ?assertEqual("Hello, Alice!", hello_world:greet("Alice")).

bob_test() ->
  ?assertEqual("Hello, Bob!", hello_world:greet("Bob")).

strange_test() ->
  ?assertEqual("Hello, !", hello_world:greet("")).
