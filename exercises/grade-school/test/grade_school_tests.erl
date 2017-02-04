-module(grade_school_tests).

-define(TESTED_MODULE, (sut(grade_school))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


add_student_test() ->
  S1 = ?TESTED_MODULE:add("Aimee", 2, ?TESTED_MODULE:new()),
  Students = ?TESTED_MODULE:get(2, S1),
  ?assertEqual(["Aimee"], lists:sort(Students)).

add_more_students_in_same_class_test() ->
  S1 = ?TESTED_MODULE:add("James", 2, ?TESTED_MODULE:new()),
  S2 = ?TESTED_MODULE:add("Blair", 2, S1),
  S3 = ?TESTED_MODULE:add("Paul", 2, S2),
  Students = ?TESTED_MODULE:get(2, S3),
  ?assertEqual(["Blair","James","Paul"], lists:sort(Students)).

add_students_to_different_grades_test() ->
  S1 = ?TESTED_MODULE:add("Chelsea", 3, ?TESTED_MODULE:new()),
  S2 = ?TESTED_MODULE:add("Logan", 7, S1),

  ?assertEqual(["Chelsea"], ?TESTED_MODULE:get(3, S2)),
  ?assertEqual(["Logan"], ?TESTED_MODULE:get(7, S2)).

get_students_in_a_grade_test() ->
  S1 = ?TESTED_MODULE:add("Franklin", 5, ?TESTED_MODULE:new()),
  S2 = ?TESTED_MODULE:add("Bradley", 5, S1),
  S3 = ?TESTED_MODULE:add("Jeff", 1, S2),
  Students = ?TESTED_MODULE:get(5, S3),
  ?assertEqual(["Bradley","Franklin"], lists:sort(Students)).

get_students_in_a_non_existant_grade_test() ->
  ?assertEqual([], ?TESTED_MODULE:get(1, ?TESTED_MODULE:new())).

sort_school_test() ->
  S1 = ?TESTED_MODULE:add("Jennifer", 4, ?TESTED_MODULE:new()),
  S2 = ?TESTED_MODULE:add("Kareem", 6, S1),
  S3 = ?TESTED_MODULE:add("Christopher", 4, S2),
  S4 = ?TESTED_MODULE:add("Kyle", 3, S3),

  Sorted = [{3, ["Kyle"]},
            {4, ["Christopher", "Jennifer"]},
            {6, ["Kareem"]}],

  ?assertEqual(Sorted, ?TESTED_MODULE:sort(S4)).
