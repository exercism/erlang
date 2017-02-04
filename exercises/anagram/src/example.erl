-module(example).

-export([find/2, test_version/0]).

-spec find(string(), [string()]) -> [string()].
find(Word, Candidates) ->
  lists:filter(anagram_check(normalize(Word)), Candidates).

anagram_check({Lower, Sorted}) ->
  fun (Other) ->
      case normalize(Other) of
        {Lower, _} ->
          false;
        {_, Sorted} ->
          true;
        _ ->
          false
      end
  end.

normalize(S) ->
  Lower = string:to_lower(S),
  {Lower, lists:sort(Lower)}.

test_version() ->
    1.
