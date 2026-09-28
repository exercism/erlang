-module(kindergarten_garden_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_garden_with_single_student_test_'() ->
    {"Garden with single student",
     ?_assertEqual([radishes, clover, grass, grass],
		   kindergarten_garden:plants("RC\nGG", alice))}.

'2_different_garden_with_single_student_test_'() ->
    {"Different garden with single student",
     ?_assertEqual([violets, clover, radishes, clover],
           kindergarten_garden:plants("VC\nRC", alice))}.

'3_garden_with_two_students_test_'() ->
    {"Garden with two students",
     ?_assertEqual([clover, grass, radishes, clover],
           kindergarten_garden:plants("VVCG\nVVRC", bob))}.

'4_Multiple_students_second_students_garden_test_'() ->
    {"Multiple students - second student's garden",
     ?_assertEqual([clover, clover, clover, clover],
           kindergarten_garden:plants("VVCCGG\nVVCCGG", bob))}.

'5_Multiple_students_third_students_garden_test_'() ->
    {"Multiple students - third student's garden",
        ?_assertEqual([grass, grass, grass, grass],
            kindergarten_garden:plants("VVCCGG\nVVCCGG", charlie))}.

'6_full_garden_for_alice_test_'() ->
    {"Full garden - for Alice",
     ?_assertEqual([violets, radishes, violets, radishes],
           kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", alice))}.

'7_full_garden_for_bob_test_'() ->
    {"Full garden - for Bob",
     ?_assertEqual([clover, grass, clover, clover],
           kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", bob))}.

'8_full_garden_for_charlie_test_'() ->
    {"Full garden - for Charlie",
     ?_assertEqual([violets, violets, clover, grass],
           kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", charlie))}.

'9_full_garden_for_david_test_'() ->
    {"Full garden - for David",
     ?_assertEqual([radishes, violets, clover, radishes],
           kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", david))}.

'10_full_garden_for_eve_test_'() ->
    {"Full garden - for Eve",
     ?_assertEqual([clover, grass, radishes, grass],
           kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", eve))}.

'11_full_garden_for_fred_test_'() ->
    {"Full garden - for Fred",
     ?_assertEqual([grass, clover, violets, clover],
           kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", fred))}.

'12_full_garden_for_ginny_test_'() ->
    {"Full garden - for Ginny",
        ?_assertEqual([clover, grass, grass, clover],
            kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", ginny))}.

'13_full_garden_for_harriet_test_'() ->
    {"Full garden - for Harriet",
        ?_assertEqual([violets, radishes, radishes, violets],
            kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", harriet))}.

'14_full_garden_for_ileana_test_'() ->
    {"Full garden - for Ileana",
        ?_assertEqual([grass, clover, violets, clover],
            kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", ileana))}.

'15_full_garden_for_joseph_test_'() ->
    {"Full garden - for Joseph",
        ?_assertEqual([violets, clover, violets, grass],
            kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", joseph))}.

'16_full_garden_for_kincaid_test_'() ->
    {"Full garden - for Kincaid",
        ?_assertEqual([grass, clover, clover, grass],
            kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", kincaid))}.

'17_full_garden_for_larry_test_'() ->
    {"Full garden - for Larry",
        ?_assertEqual([grass, violets, clover, violets],
            kindergarten_garden:plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", larry))}.
