sut(Module) ->
  {ok, Files} = file:list_dir("./src"),
  case lists:member(atom_to_list(Module) ++ ".erl", Files) of
    true  -> Module;
    false -> example
  end.
