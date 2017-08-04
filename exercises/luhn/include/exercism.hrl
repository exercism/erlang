-include_lib("eunit/include/eunit.hrl").

sut(Module) ->
  {ok, Files} = file:list_dir("./src"),
  case lists:member("example.erl", Files) of
    true  -> example;
    false -> Module
  end.

version_test() ->
  ?assertMatch(?TEST_VERSION, ?TESTED_MODULE:test_version()).
