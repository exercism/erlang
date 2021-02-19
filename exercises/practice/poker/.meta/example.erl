-module(example).
-export([best_hands/1]).

-spec best_hands([string()]) -> [string()].
best_hands(Hands) ->
    HandScores = [ {eval_hand(Hand), Hand} || Hand <- Hands ],
    {MaxScore, _} = lists:max(HandScores),
    [ Hand || {Score, Hand} <- HandScores, Score =:= MaxScore ].

%% for a given hand, come up with a term that can be directly compared to
%% a term representing another hand
%% the first integer of a list represents the highest combination:
%% 1 = high card, 2 = one pair, 3 = two pairs, 4 = three of a kind,
%% 5 = straight, 6 = flush, 7 = full house, 8 = four of a kind,
%% 9 = straight flush
%% consequent integers represent the ranks of the cards in the order of
%% decreasing importance for the particular combination
eval_hand(HandStr) ->
    Hand = lists:map(fun([$1, $0, Suit]) -> {10, Suit};
                        ([Rank, Suit]) -> {num(Rank), Suit}
                     end, string:tokens(HandStr, " ")),
    case {test_flush(Hand), test_straight(Hand)} of
        {false, false} ->
            Xs0 = lists:foldl(
                    fun({Rank, _}, Acc) ->
                            [{length([ x || {ThisRank, _} <- Hand,
                                            ThisRank =:= Rank]), Rank}|Acc]
                    end, [], Hand),
            lists:foldr(fun({4, Rank}, _) ->
                                [8, Rank];
                           ({3, Rank}, _) ->
                                [4, Rank];
                           ({2, Rank}, [4, Rank3]) ->
                                [7, Rank3, Rank];
                           ({2, Rank}, [2, Rank2]) ->
                                [3, Rank2, Rank];
                           ({2, Rank}, _) ->
                                [2, Rank];
                           ({1, Rank}, []) ->
                                [1, Rank];
                           ({1, Rank}, Ranks) ->
                                Ranks ++ [Rank]
                        end,[], lists:usort(Xs0));
        {High, false}  -> [6, High];
        {false, High}  -> [5, High];
        {High, High}   -> [9, High]
    end.

num($J)                        -> 11;
num($Q)                        -> 12;
num($K)                        -> 13;
num($A)                        -> 14;
num(Num) when Num>=$0, Num=<$9 -> Num-$0.

test_flush([{_, Suit}|Rest] = Hand) ->
    case lists:all(fun({_, ThisSuit}) -> ThisSuit =:= Suit end, Rest) of
        true  -> element(1, lists:max(Hand));
        false -> false
    end.

test_straight(Hand) ->
    case lists:foldl(fun({Cur, _}, true) ->
                             {true, Cur};
                        ({Cur, _}, {true, Prev}) when Prev+1 =:= Cur ->
                             {true, Cur};
                        ({14, _}, {true, 5}) -> % A 2 3 4 5 case
                             {last, 5};
                        (_, _) ->
                             false
                     end, true, lists:sort(Hand)) of
        {_, High} -> High;
        false     -> false
    end.
