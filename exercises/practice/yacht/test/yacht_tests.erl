-module(yacht_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_yacht_test_'() ->
    {"Yacht",
     ?_assertMatch(50, yacht:score([5, 5, 5, 5, 5], yacht))}.

'2_not_yacht_test_'() ->
    {"Not Yacht",
     ?_assertMatch(0, yacht:score([1, 3, 3, 2, 5], yacht))}.

'3_ones_test_'() ->
    {"Ones",
     ?_assertMatch(3, yacht:score([1, 1, 1, 3, 5], ones))}.

'4_ones_out_of_order_test_'() ->
    {"Ones, out of order",
     ?_assertMatch(3, yacht:score([3, 1, 1, 5, 1], ones))}.

'5_no_ones_test_'() ->
    {"No ones",
     ?_assertMatch(0, yacht:score([4, 3, 6, 5, 5], ones))}.

'6_twos_test_'() ->
    {"Twos",
     ?_assertMatch(2, yacht:score([2, 3, 4, 5, 6], twos))}.

'7_fours_test_'() ->
    {"Fours",
     ?_assertMatch(8, yacht:score([1, 4, 1, 4, 1], fours))}.

'8_yacht_counted_as_threes_test_'() ->
    {"Yacht counted as threes",
     ?_assertMatch(15, yacht:score([3, 3, 3, 3, 3], threes))}.

'9_yacht_of_threes_counted_as_fives_test_'() ->
    {"Yacht of threes counted as fives",
     ?_assertMatch(0, yacht:score([3, 3, 3, 3, 3], fives))}.

'10_fives_test_'() ->
    {"Fives",
     ?_assertMatch(10, yacht:score([1, 5, 3, 5, 3], fives))}.

'11_sixes_test_'() ->
    {"Sixes",
     ?_assertMatch(6, yacht:score([2, 3, 4, 5, 6], sixes))}.

'12_full_house_two_small_three_big_test_'() ->
    {"Full house, two small, three big",
     ?_assertMatch(16, yacht:score([2, 2, 4, 4, 4], full_house))}.

'13_full_house_three_small_two_big_test_'() ->
    {"Full house, three small, two big",
     ?_assertMatch(19, yacht:score([5, 3, 3, 5, 3], full_house))}.

'14_two_pair_is_not_a_full_house_test_'() ->
    {"Two pair is not a full house",
     ?_assertMatch(0, yacht:score([2, 2, 4, 4, 5], full_house))}.

'15_four_of_a_kind_is_not_a_full_house_test_'() ->
    {"Four of a kind is not a full house",
     ?_assertMatch(0, yacht:score([1, 4, 4, 4, 4], full_house))}.

'16_yacht_is_not_a_full_house_test_'() ->
    {"Yacht is not a full house",
     ?_assertMatch(0, yacht:score([2, 2, 2, 2, 2], full_house))}.

'17_four_of_a_kind_test_'() ->
    {"Four of a kind",
     ?_assertMatch(24, yacht:score([6, 6, 4, 6, 6], four_of_a_kind))}.

'18_yacht_can_be_scored_as_four_of_a_kind_test_'() ->
    {"Yacht can be scored as four of a kind",
     ?_assertMatch(12, yacht:score([3, 3, 3, 3, 3], four_of_a_kind))}.

'19_full_house_is_not_four_of_a_kind_test_'() ->
    {"Full house is not four of a kind",
     ?_assertMatch(0, yacht:score([3, 3, 3, 5, 5], four_of_a_kind))}.

'20_little_straight_test_'() ->
    {"Little straight",
     ?_assertMatch(30, yacht:score([3, 5, 4, 1, 2], little_straight))}.

'21_little_straight_as_big_straight_test_'() ->
    {"Little straight as big straight",
     ?_assertMatch(0, yacht:score([1, 2, 3, 4, 5], big_straight))}.

'22_four_in_order_but_not_a_little_straight_test_'() ->
    {"Four in order but not a little straight",
     ?_assertMatch(0, yacht:score([1, 1, 2, 3, 4], little_straight))}.

'23_no_pairs_but_not_a_little_straight_test_'() ->
    {"No pairs but not a little straight",
     ?_assertMatch(0, yacht:score([1, 2, 3, 4, 6], little_straight))}.

'24_minimum_is_1_maximum_is_5_but_nt_a_small_straight_test_'() ->
    {"Minimum is 1, maximum is 5, but not a small straight",
     ?_assertMatch(0, yacht:score([1, 1, 3, 4, 5], little_straight))}.

'25_big_straight_test_'() ->
    {"Big straight",
     ?_assertMatch(30, yacht:score([4, 6, 2, 5, 3], big_straight))}.

'26_big_straight_as_little_straight_test_'() ->
    {"Big straight as little straight",
     ?_assertMatch(0, yacht:score([6, 5, 4, 3, 2], little_straight))}.

'27_no_pairs_but_not_a_big_straight_test_'() ->
    {"No pairs but not a big straight",
     ?_assertMatch(0, yacht:score([6, 5, 4, 3, 1], big_straight))}.

'28_choice_test_'() ->
    {"Choice",
     ?_assertMatch(23, yacht:score([3, 3, 5, 6, 6], choice))}.

'29_yacht_as_choice_test_'() ->
    {"Yacht as choice",
     ?_assertMatch(10, yacht:score([2, 2, 2, 2, 2], choice))}.
