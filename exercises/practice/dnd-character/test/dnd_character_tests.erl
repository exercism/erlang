-module(dnd_character_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

%% Ability modifier tests

'1_ability_modifier_for_score_3_is_minus_4_test_'() ->
    {"ability modifier for score 3 is -4",
     ?_assertEqual(-4, dnd_character:modifier(3))}.

'2_ability_modifier_for_score_4_is_minus_3_test_'() ->
    {"ability modifier for score 4 is -3",
     ?_assertEqual(-3, dnd_character:modifier(4))}.

'3_ability_modifier_for_score_5_is_minus_3_test_'() ->
    {"ability modifier for score 5 is -3",
     ?_assertEqual(-3, dnd_character:modifier(5))}.

'4_ability_modifier_for_score_6_is_minus_2_test_'() ->
    {"ability modifier for score 6 is -2",
     ?_assertEqual(-2, dnd_character:modifier(6))}.

'5_ability_modifier_for_score_7_is_minus_2_test_'() ->
    {"ability modifier for score 7 is -2",
     ?_assertEqual(-2, dnd_character:modifier(7))}.

'6_ability_modifier_for_score_8_is_minus_1_test_'() ->
    {"ability modifier for score 8 is -1",
     ?_assertEqual(-1, dnd_character:modifier(8))}.

'7_ability_modifier_for_score_9_is_minus_1_test_'() ->
    {"ability modifier for score 9 is -1",
     ?_assertEqual(-1, dnd_character:modifier(9))}.

'8_ability_modifier_for_score_10_is_0_test_'() ->
    {"ability modifier for score 10 is 0",
     ?_assertEqual(0, dnd_character:modifier(10))}.

'9_ability_modifier_for_score_11_is_0_test_'() ->
    {"ability modifier for score 11 is 0",
     ?_assertEqual(0, dnd_character:modifier(11))}.

'10_ability_modifier_for_score_12_is_plus_1_test_'() ->
    {"ability modifier for score 12 is +1",
     ?_assertEqual(1, dnd_character:modifier(12))}.

'11_ability_modifier_for_score_13_is_plus_1_test_'() ->
    {"ability modifier for score 13 is +1",
     ?_assertEqual(1, dnd_character:modifier(13))}.

'12_ability_modifier_for_score_14_is_plus_2_test_'() ->
    {"ability modifier for score 14 is +2",
     ?_assertEqual(2, dnd_character:modifier(14))}.

'13_ability_modifier_for_score_15_is_plus_2_test_'() ->
    {"ability modifier for score 15 is +2",
     ?_assertEqual(2, dnd_character:modifier(15))}.

'14_ability_modifier_for_score_16_is_plus_3_test_'() ->
    {"ability modifier for score 16 is +3",
     ?_assertEqual(3, dnd_character:modifier(16))}.

'15_ability_modifier_for_score_17_is_plus_3_test_'() ->
    {"ability modifier for score 17 is +3",
     ?_assertEqual(3, dnd_character:modifier(17))}.

'16_ability_modifier_for_score_18_is_plus_4_test_'() ->
    {"ability modifier for score 18 is +4",
     ?_assertEqual(4, dnd_character:modifier(18))}.

%% Random ability tests

'17_random_ability_is_within_range_test_'() ->
    {"random ability is within range",
     fun() ->
        Results = [dnd_character:ability() || _ <- lists:seq(1, 200)],
        [?assert(Result >= 3 andalso Result =< 18) || Result <- Results],
        ok
     end}.

%% Random character tests

'18_random_character_has_valid_values_test_'() ->
    {"random character has each ability within range and valid hitpoints",
     fun() ->
        Characters = [dnd_character:character() || _ <- lists:seq(1, 20)],

        lists:foreach(fun(Character) ->
            #{strength := Strength,
              dexterity := Dexterity,
              constitution := Constitution,
              intelligence := Intelligence,
              wisdom := Wisdom,
              charisma := Charisma,
              hitpoints := Hitpoints} = Character,

            ?assert(Strength >= 3 andalso Strength =< 18),
            ?assert(Dexterity >= 3 andalso Dexterity =< 18),
            ?assert(Constitution >= 3 andalso Constitution =< 18),
            ?assert(Intelligence >= 3 andalso Intelligence =< 18),
            ?assert(Wisdom >= 3 andalso Wisdom =< 18),
            ?assert(Charisma >= 3 andalso Charisma =< 18),
            ?assertEqual(10 + dnd_character:modifier(Constitution), Hitpoints)
        end, Characters),
        ok
     end}.
