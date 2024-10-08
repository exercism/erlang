-module(example).

-export([value/1]).


value([First, Second | _]) ->
    color_code(First) * 10 + color_code(Second).

color_code(black) -> 0;
color_code(brown) -> 1;
color_code(red) -> 2;
color_code(orange) -> 3;
color_code(yellow) -> 4;
color_code(green) -> 5;
color_code(blue) -> 6;
color_code(violet) -> 7;
color_code(grey) -> 8;
color_code(white) -> 9.
