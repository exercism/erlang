-module(example).

-export([add/3, get/2, sort/1, new/0, test_version/0]).

%% Define the grade school type
-type school() :: [{integer(),[string(),...]}].

-spec add(string(), integer(), school()) -> school().
add(Name, Grade, School) ->
  case get(Grade, School) of
    [] ->
      orddict:store(Grade, [Name], School);
    Class ->
      orddict:store(Grade, ordsets:add_element(Name, Class), School)
  end.

-spec get(integer(), school()) -> [string()].
get(Grade, Students) ->
  case orddict:find(Grade, Students) of
    {ok, Class} -> Class;
    _ -> []
  end.

-spec sort(school()) -> school().
sort(S) ->
  S.

-spec new() -> school().
new() ->
  [].

test_version() ->
    1.
