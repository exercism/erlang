-module(example).

-export([tick/1]).

tick([]) -> [];
tick(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    RowIndices = lists:seq(0, Rows - 1),
    ColIndices = lists:seq(0, Cols - 1),
    lists:map(
        fun(R) ->
            lists:map(
                fun(C) -> next_tick(Matrix, R, C, Rows, Cols) end,
                ColIndices
            )
        end,
        RowIndices
    ).

next_tick(Matrix, Row, Col, Rows, Cols) ->
    CurrentCell = get_cell(Matrix, Row, Col),
    LiveNeighbors = count_live_neighbors(Matrix, Row, Col, Rows, Cols),
    update_cell(CurrentCell, LiveNeighbors).

get_cell(Matrix, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Matrix)).

update_cell(1, LiveNeighbors) when LiveNeighbors =:= 2 orelse LiveNeighbors =:= 3 -> 1;
update_cell(0, 3) -> 1;
update_cell(_, _) -> 0.  

count_live_neighbors(Matrix, Row, Col, Rows, Cols) ->
    Neighbors = [
        {Row - 1, Col - 1}, {Row - 1, Col}, {Row - 1, Col + 1},
        {Row, Col - 1},                     {Row, Col + 1},
        {Row + 1, Col - 1}, {Row + 1, Col}, {Row + 1, Col + 1}
    ],
    lists:foldl(
        fun({NRow, NCol}, Acc) ->
            case NRow >= 0 andalso NRow < Rows andalso NCol >= 0 andalso NCol < Cols of
                true ->
                    Acc + get_cell(Matrix, NRow, NCol);
                false ->
                    Acc
            end
        end,
        0,
        Neighbors
    ).
