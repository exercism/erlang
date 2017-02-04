-module(example).

-export([transform/1, test_version/0]).

transform(OldValue) ->
  orddict:to_list(
    orddict:from_list(
      lists:flatten(
        invert(OldValue)
       )
     )
   ).

test_version() ->
    1.



invert(Pairs) ->
  lists:foldl(
    fun({Key, Values}, A) ->
        lists:foldl(
          fun(Value, Acc) ->
              orddict:update(
                string:to_lower(Value),
                fun (Old) ->
                    lists:flatten([Old] ++ [Key])
                end,
                Key,
                Acc
               )
          end,
          A,
          Values
         )
    end,
    orddict:new(),
    Pairs
   ).
