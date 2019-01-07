%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/poker/canonical-data.json
-module(poker_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(test(X,Y), ?assertEqual(lists:sort(Y), lists:sort(poker:best(X)))).

single_hand_always_wins_test() ->
    ?test([
           "4S 5S 7H 8D JC"
          ],
          [
           "4S 5S 7H 8D JC"
          ]).

highest_card_out_of_all_hands_wins_test() ->
    ?test([
           "4D 5S 6S 8D 3C",
           "2S 4C 7S 9H 10H",
           "3S 4S 5D 6H JH"
          ],
          [
           "3S 4S 5D 6H JH"
          ]).
a_tie_has_multiple_winners_test() ->
    ?test([
           "4D 5S 6S 8D 3C",
           "2S 4C 7S 9H 10H",
           "3S 4S 5D 6H JH",
           "3H 4H 5C 6C JD"
          ],
          [
           "3S 4S 5D 6H JH",
           "3H 4H 5C 6C JD"
          ]).
multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card_test() ->
    ?test([
           "3S 5H 6S 8D 7H",
           "2S 5D 6D 8C 7S"
          ],
          [
           "3S 5H 6S 8D 7H"
          ]).
one_pair_beats_high_card_test() ->
    ?test([
           "4S 5H 6C 8D KH",
           "2S 4H 6S 4D JH"
          ],
          [
           "2S 4H 6S 4D JH"
          ]).
highest_pair_wins_test() ->
    ?test([
           "4S 2H 6S 2D JH",
           "2S 4H 6C 4D JD"
          ],
          [
           "2S 4H 6C 4D JD"
          ]).
two_pairs_beats_one_pair_test() ->
    ?test([
           "2S 8H 6S 8D JH",
           "4S 5H 4C 8C 5C"
          ],
          [
           "4S 5H 4C 8C 5C"
          ]).
both_hands_have_two_pairs_highest_ranked_pair_wins_test() ->
    ?test([
           "2S 8H 2D 8D 3H",
           "4S 5H 4C 8S 5D"
          ],
          [
           "2S 8H 2D 8D 3H"
          ]).
both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair_test() ->
    ?test([
           "2S QS 2C QD JH",
           "JD QH JS 8D QC"
          ],
          [
           "JD QH JS 8D QC"
          ]).
both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker_test() ->
    ?test([
           "JD QH JS 8D QC",
           "JS QS JC 2D QD"
          ],
          [
           "JD QH JS 8D QC"
          ]).
three_of_a_kind_beats_two_pair_test() ->
    ?test([
           "2S 8H 2H 8D JH",
           "4S 5H 4C 8S 4H"
          ],
          [
           "4S 5H 4C 8S 4H"
          ]).
both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet_test() ->
    ?test([
           "2S 2H 2C 8D JH",
           "4S AH AS 8C AD"
          ],
          [
           "4S AH AS 8C AD"
          ]).
with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards_test() ->
    ?test([
           "4S AH AS 7C AD",
           "4S AH AS 8C AD"
          ],
          [
           "4S AH AS 8C AD"
          ]).
a_straight_beats_three_of_a_kind_test() ->
    ?test([
           "4S 5H 4C 8D 4H",
           "3S 4D 2S 6D 5C"
          ],
          [
           "3S 4D 2S 6D 5C"
          ]).
aces_can_end_a_straight_10_J_Q_K_A_test() ->
    ?test([
           "4S 5H 4C 8D 4H",
           "10D JH QS KD AC"
          ],
          [
           "10D JH QS KD AC"
          ]).
aces_can_start_a_straight_A_2_3_4_5_test() ->
    ?test([
           "4S 5H 4C 8D 4H",
           "4D AH 3S 2D 5C"
          ],
          [
           "4D AH 3S 2D 5C"
          ]).
both_hands_with_a_straight_tie_goes_to_highest_ranked_card_test() ->
    ?test([
           "4S 6C 7S 8D 5H",
           "5S 7H 8S 9D 6H"
          ],
          [
           "5S 7H 8S 9D 6H"
          ]).
even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight_test() ->
    ?test([
           "2H 3C 4D 5D 6H",
           "4S AH 3S 2D 5H"
          ],
          [
           "2H 3C 4D 5D 6H"
          ]).
flush_beats_a_straight_test() ->
    ?test([
           "4C 6H 7D 8D 5H",
           "2S 4S 5S 6S 7S"
          ],
          [
           "2S 4S 5S 6S 7S"
          ]).
both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary_test() ->
    ?test([
           "4H 7H 8H 9H 6H",
           "2S 4S 5S 6S 7S"
          ],
          [
           "4H 7H 8H 9H 6H"
          ]).
full_house_beats_a_flush_test() ->
    ?test([
           "3H 6H 7H 8H 5H",
           "4S 5H 4C 5D 4H"
          ],
          [
           "4S 5H 4C 5D 4H"
          ]).
both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet_test() ->
    ?test([
           "4H 4S 4D 9S 9D",
           "5H 5S 5D 8S 8D"
          ],
          [
           "5H 5S 5D 8S 8D"
          ]).
with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair_test() ->
    ?test([
           "5H 5S 5D 9S 9D",
           "5H 5S 5D 8S 8D"
          ],
          [
           "5H 5S 5D 9S 9D"
          ]).
four_of_a_kind_beats_a_full_house_test() ->
    ?test([
           "4S 5H 4D 5D 4H",
           "3S 3H 2S 3D 3C"
          ],
          [
           "3S 3H 2S 3D 3C"
          ]).
both_hands_have_four_of_a_kind_tie_goes_to_high_quad_test() ->
    ?test([
           "2S 2H 2C 8D 2D",
           "4S 5H 5S 5D 5C"
          ],
          [
           "4S 5H 5S 5D 5C"
          ]).
with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker_test() ->
    ?test([
           "3S 3H 2S 3D 3C",
           "3S 3H 4S 3D 3C"
          ],
          [
           "3S 3H 4S 3D 3C"
          ]).
straight_flush_beats_four_of_a_kind_test() ->
    ?test([
           "4S 5H 5S 5D 5C",
           "7S 8S 9S 6S 10S"
          ],
          [
           "7S 8S 9S 6S 10S"
          ]).
both_hands_have_straight_flush_tie_goes_to_highest_ranked_card_test() ->
    ?test([
           "4H 6H 7H 8H 5H",
           "5S 7S 8S 9S 6S"
          ],
          [
           "5S 7S 8S 9S 6S"
          ]).
