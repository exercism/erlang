-module(example).

-export([convert/1, test_version/0]).

convert(Number) when Number rem 3 == 0 ->
    pling(Number);
convert(Number) when Number rem 5 == 0 ->
    plang(Number);
convert(Number) when Number rem 7 == 0 ->
    plong(Number);
convert(Number) ->
    integer_to_list(Number).

pling(Number) when Number rem 5 == 0 ->
    "Pling" ++ plang(Number);
pling(Number) when Number rem 7 == 0 ->
    "Pling" ++ plong(Number);
pling(_) ->
    "Pling".

plang(Number) when Number rem 7 == 0 ->
    "Plang" ++ plong(Number);
plang(_) ->
    "Plang".

plong(_) ->
    "Plong".

test_version() ->
    1.
