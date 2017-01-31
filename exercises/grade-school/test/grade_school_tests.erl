-module(grade_school_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

get_module_name() ->
  sut(grade_school).

add_student_test() ->
  S1 = (get_module_name()):add("Aimee", 2, (get_module_name()):new()),
  Students = (get_module_name()):get(2, S1),
  ?assertEqual(["Aimee"], lists:sort(Students)).

add_more_students_in_same_class_test() ->
  S1 = (get_module_name()):add("James", 2, (get_module_name()):new()),
  S2 = (get_module_name()):add("Blair", 2, S1),
  S3 = (get_module_name()):add("Paul", 2, S2),
  Students = (get_module_name()):get(2, S3),
  ?assertEqual(["Blair","James","Paul"], lists:sort(Students)).

add_students_to_different_grades_test() ->
  S1 = (get_module_name()):add("Chelsea", 3, (get_module_name()):new()),
  S2 = (get_module_name()):add("Logan", 7, S1),

  ?assertEqual(["Chelsea"], (get_module_name()):get(3, S2)),
  ?assertEqual(["Logan"], (get_module_name()):get(7, S2)).

get_students_in_a_grade_test() ->
  S1 = (get_module_name()):add("Franklin", 5, (get_module_name()):new()),
  S2 = (get_module_name()):add("Bradley", 5, S1),
  S3 = (get_module_name()):add("Jeff", 1, S2),
  Students = (get_module_name()):get(5, S3),
  ?assertEqual(["Bradley","Franklin"], lists:sort(Students)).

get_students_in_a_non_existant_grade_test() ->
  ?assertEqual([], (get_module_name()):get(1, (get_module_name()):new())).

sort_school_test() ->
  S1 = (get_module_name()):add("Jennifer", 4, (get_module_name()):new()),
  S2 = (get_module_name()):add("Kareem", 6, S1),
  S3 = (get_module_name()):add("Christopher", 4, S2),
  S4 = (get_module_name()):add("Kyle", 3, S3),

  Sorted = [{3, ["Kyle"]},
            {4, ["Christopher", "Jennifer"]},
            {6, ["Kareem"]}],

  ?assertEqual(Sorted, (get_module_name()):sort(S4)).
