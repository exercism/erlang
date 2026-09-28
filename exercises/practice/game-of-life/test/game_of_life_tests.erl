-module(game_of_life_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_empty_matrix_test_'() ->
  {"empty matrix",
   fun() ->
     Matrix = [],
     Expected = [],
     ?assertEqual(Expected, game_of_life:tick(Matrix))
   end}.

'2_live_cells_with_zero_live_neighbors_die_test_'() ->
  {"live cells with zero live neighbors die",
   fun() ->
     Matrix = [
       [0, 0, 0],
       [0, 1, 0],
       [0, 0, 0]
     ],
     Expected = [
       [0, 0, 0],
       [0, 0, 0],
       [0, 0, 0]
     ],
     ?assertEqual(Expected, game_of_life:tick(Matrix))
   end}.

'3_live_cells_with_only_one_live_neighbor_die_test_'() ->
    {"live cells with only one live neighbor die",
     fun() ->
         Matrix = [
         [0, 0, 0],
         [0, 1, 0],
         [0, 1, 0]
         ],
         Expected = [
         [0, 0, 0],
         [0, 0, 0],
         [0, 0, 0]
         ],
         ?assertEqual(Expected, game_of_life:tick(Matrix))
     end}.

'4_live_cells_with_two_live_neighbors_stay_alive_test_'() ->
    {"live cells with two live neighbors stay alive",
     fun() ->
         Matrix = [
         [1, 0, 1],
         [1, 0, 1],
         [1, 0, 1]
         ],
         Expected = [
         [0, 0, 0],
         [1, 0, 1],
         [0, 0, 0]
         ],
         ?assertEqual(Expected, game_of_life:tick(Matrix))
     end}.

'5_live_cells_with_three_live_neighbors_stay_alive_test_'() ->
    {"live cells with three live neighbors stay alive",
     fun() ->
         Matrix = [
         [0, 1, 0],
         [1, 0, 0],
         [1, 1, 0]
         ],
         Expected = [
         [0, 0, 0],
         [1, 0, 0],
         [1, 1, 0]
         ],
         ?assertEqual(Expected, game_of_life:tick(Matrix))
     end}.

'6_dead_cells_with_three_live_neighbors_become_alive_test_'() ->
    {"dead cells with three live neighbors become alive",
     fun() ->
         Matrix = [
         [1, 1, 0],
         [0, 0, 0],
         [1, 0, 0]
         ],
         Expected = [
         [0, 0, 0],
         [1, 1, 0],
         [0, 0, 0]
         ],
         ?assertEqual(Expected, game_of_life:tick(Matrix))
     end}.

'7_live_cells_with_four_or_more_neighbors_die_test_'() ->
    {"live cells with four or more neighbors die",
     fun() ->
         Matrix = [
         [1, 1, 1],
         [1, 1, 1],
         [1, 1, 1]
         ],
         Expected = [
         [1, 0, 1],
         [0, 0, 0],
         [1, 0, 1]
         ],
         ?assertEqual(Expected, game_of_life:tick(Matrix))
     end}.

'8_bigger_matrix_test_'() ->
    {"bigger matrix",
     fun() ->
         Matrix = [
         [1, 1, 0, 1, 1, 0, 0, 0],
         [1, 0, 1, 1, 0, 0, 0, 0],
         [1, 1, 1, 0, 0, 1, 1, 1],
         [0, 0, 0, 0, 0, 1, 1, 0],
         [1, 0, 0, 0, 1, 1, 0, 0],
         [1, 1, 0, 0, 0, 1, 1, 1],
         [0, 0, 1, 0, 1, 0, 0, 1],
         [1, 0, 0, 0, 0, 0, 1, 1]
],
         Expected = [
         [1, 1, 0, 1, 1, 0, 0, 0],
         [0, 0, 0, 0, 0, 1, 1, 0],
         [1, 0, 1, 1, 1, 1, 0, 1],
         [1, 0, 0, 0, 0, 0, 0, 1],
         [1, 1, 0, 0, 1, 0, 0, 1],
         [1, 1, 0, 1, 0, 0, 0, 1],
         [1, 0, 0, 0, 0, 0, 0, 0],
         [0, 0, 0, 0, 0, 0, 1, 1]
         ],
         ?assertEqual(Expected,
                      game_of_life:tick(Matrix))
     end}.
