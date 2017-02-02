-module(example).

-export([allergies/1, is_allergic_to/2, test_version/0]).

-define(ALLERGIES, ['eggs',         % 2^0
                    'peanuts',      % 2^1
                    'shellfish',    % 2^2
                    'strawberries', % 2^3
                    'tomatoes',     % 2^4
                    'chocolate',    % 2^5
                    'pollen',       % 2^6
                    'cats']).       % 2^7

allergies(Score) ->
  lists:filter(fun (X) -> is_allergic_to(X, Score) end, ?ALLERGIES).

is_allergic_to(Allergy, Score) ->
  Index = indexOf(Allergy, ?ALLERGIES),
  case Index of
    not_found ->
      false;
    _ ->
      (Score band trunc(math:pow(2, Index))) > 0.0
  end.

indexOf(A, Allergies) ->
  index(0, Allergies, A).

index(Index, [A|_], A) ->
  Index;
index(Index, [_|Allergies], A) ->
  index(Index+1, Allergies, A);
index(_, [], _) ->
  not_found.

test_version() ->
    1.
