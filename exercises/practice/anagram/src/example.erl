-module(example).

-export([find_anagrams/2]).

-spec find_anagrams(string(), [string()]) -> [string()].
find_anagrams(Word, Candidates) ->
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
