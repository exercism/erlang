-module(spiral_matrix_tests).

-define(TESTED_MODULE, (sut(spiral_matrix))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").

-define(spiral1, [[1]]).
-define(spiral2, [[1,2],
                  [4,3]]).
-define(spiral3, [[1,2,3],
                  [8,9,4],
                  [7,6,5]]).
-define(spiral4, [[ 1, 2, 3, 4],
                  [12,13,14, 5],
                  [11,16,15, 6],
                  [10, 9, 8, 7]]).
-define(spiral5, [[ 1,  2,  3,  4, 5],
                  [16, 17, 18, 19, 6],
                  [15, 24, 25, 20, 7],
                  [14, 23, 22, 21, 8],
                  [13, 12, 11, 10, 9]]).
-define(get(X,Y,L), lists:nth(X,lists:nth(Y,L))).

empty_spiral_test() ->
    ?assertEqual([], ?TESTED_MODULE:make(0)).
trivial_spiral_test() ->
    ?assertEqual(?spiral1, ?TESTED_MODULE:make(1)).
spiral_of_size_2_test() ->
    ?assertEqual(?spiral2, ?TESTED_MODULE:make(2)).
spiral_of_size_3_test() ->
    ?assertEqual(?spiral3, ?TESTED_MODULE:make(3)).
spiral_of_size_4_test() ->
    ?assertEqual(?spiral4, ?TESTED_MODULE:make(4)).
spiral_of_size_5_test() ->
    ?assertEqual(?spiral5, ?TESTED_MODULE:make(5)).
spiral_of_size_500_test() ->
    M = ?TESTED_MODULE:make(500),
    ?assertEqual(1, ?get(1,1,M)),
    ?assertEqual(1997, ?get(2,2,M)),
    ?assertEqual(38894, ?get(480,55,M)),
    ?assertEqual(121053, ?get(430,364,M)),
    ?assertEqual(158597, ?get(99,299,M)),
    ?assertEqual(250000, ?get(250,251,M)).
