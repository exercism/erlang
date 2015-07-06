% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(grade_school, [verbose])" -s init stop
%

-module(grade_school_tests).

-include_lib("eunit/include/eunit.hrl").

add_student_test() ->
  S1 = grade_school:add("Aimee", 2, grade_school:new()),
  Students = grade_school:get(2, S1),
  ?assertEqual(["Aimee"], lists:sort(Students)).

add_more_students_in_same_class_test() ->
  S1 = grade_school:add("James", 2, grade_school:new()),
  S2 = grade_school:add("Blair", 2, S1),
  S3 = grade_school:add("Paul", 2, S2),
  Students = grade_school:get(2, S3),
  ?assertEqual(["Blair","James","Paul"], lists:sort(Students)).

add_students_to_different_grades_test() ->
  S1 = grade_school:add("Chelsea", 3, grade_school:new()),
  S2 = grade_school:add("Logan", 7, S1),

  ?assertEqual(["Chelsea"], grade_school:get(3, S2)),
  ?assertEqual(["Logan"], grade_school:get(7, S2)).

get_students_in_a_grade_test() ->
  S1 = grade_school:add("Franklin", 5, grade_school:new()),
  S2 = grade_school:add("Bradley", 5, S1),
  S3 = grade_school:add("Jeff", 1, S2),
  Students = grade_school:get(5, S3),
  ?assertEqual(["Bradley","Franklin"], lists:sort(Students)).

get_students_in_a_non_existant_grade_test() ->
  ?assertEqual(grade_school:new(), grade_school:get(1, [])).

sort_school_test() ->
  S1 = grade_school:add("Jennifer", 4, grade_school:new()),
  S2 = grade_school:add("Kareem", 6, S1),
  S3 = grade_school:add("Christopher", 4, S2),
  S4 = grade_school:add("Kyle", 3, S3),

  Sorted = [{3, ["Kyle"]},
            {4, ["Christopher", "Jennifer"]},
            {6, ["Kareem"]}],

  ?assertEqual(Sorted, grade_school:sort(S4)).
