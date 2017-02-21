-include_lib("eunit/include/eunit.hrl").

sut(Module) ->
  {ok, Files} = file:list_dir("./src"),
  case lists:member(atom_to_list(Module) ++ ".erl", Files) of
    true  -> Module;
    false -> example
  end.

version_test() ->
    ?assertMatch(?TEST_VERSION, ?TESTED_MODULE:test_version()).
