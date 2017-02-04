-module(triangle_tests).

-define(TESTED_MODULE, (sut(triangle))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


equilateral_triangles_have_equal_sides_test() ->
    ?assertMatch(equilateral, ?TESTED_MODULE:kind(2,2,2)).

larger_equilateral_triangles_also_have_equal_sides_test() ->
    ?assertMatch(equilateral, ?TESTED_MODULE:kind(10, 10, 10)).

isosceles_triangles_have_at_least_two_sides_equal_test() ->
    ?assertMatch(isosceles, ?TESTED_MODULE:kind(3, 4, 4)).

isosceles_triangles_have_first_and_last_sides_equal_test() ->
    ?assertMatch(isosceles, ?TESTED_MODULE:kind(4, 3, 4)).

isosceles_triangles_have_two_first_sides_equal_test() ->
    ?assertMatch(isosceles, ?TESTED_MODULE:kind(4, 4, 3)).

isosceles_triangles_have_in_fact_exactly_two_sides_equal_test() ->
    ?assertMatch(isosceles, ?TESTED_MODULE:kind(10, 10, 2)).

scalene_triangles_have_no_equal_sides_test() ->
    ?assertMatch(scalene, ?TESTED_MODULE:kind(3, 4, 5)).

scalene_triangles_have_no_equal_sides_at_a_larger_scale_too_test() ->
    ?assertMatch(scalene, ?TESTED_MODULE:kind(10, 11, 12)).

scalene_triangles_have_no_equal_sides_in_descending_order_either_test() ->
    ?assertMatch(scalene, ?TESTED_MODULE:kind(5, 4, 2)).

very_small_triangles_are_legal_test() ->
    ?assertMatch(scalene, ?TESTED_MODULE:kind(0.4, 0.6, 0.3)).

triangles_with_no_size_are_illegal_test() ->
    ?assertMatch({error, "all side lengths must be positive"},
                 ?TESTED_MODULE:kind(0, 0, 0)).

triangles_with_negative_sides_are_illegal_test() ->
    ?assertMatch({error, "all side lengths must be positive"},
                 ?TESTED_MODULE:kind(3, 4, -5)).

triangles_violating_triangle_inequality_are_illegel_test() ->
    ?assertMatch({error, "side lengths violate triangle inequality"},
                 ?TESTED_MODULE:kind(1, 1, 3)).

triangles_violating_triangle_inequality_are_illegel_2_test() ->
    ?assertMatch({error, "side lengths violate triangle inequality"},
                 ?TESTED_MODULE:kind(2, 4, 2)).

triangles_violating_triangle_inequality_are_illegel_3_test() ->
    ?assertMatch({error, "side lengths violate triangle inequality"},
                 ?TESTED_MODULE:kind(7, 3, 2)).
