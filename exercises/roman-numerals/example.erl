-module(roman_numerals).

-export([numerals/1]).

-define(DIGITS, [{"M", 1000}, {"CM", 900}, {"D", 500}, {"CD", 400},
                 {"C", 100}, {"XC", 90},  {"L", 50}, {"XL", 40},
                 {"X", 10}, {"IX", 9}, {"V", 5}, {"IV", 4}, {"I", 1}]).

-spec numerals(non_neg_integer()) -> string().
numerals(Number) ->
    to_roman(Number, "", ?DIGITS).

to_roman(0, Roman, _) -> Roman;
to_roman(_, Roman, []) -> Roman;
to_roman(N, Roman, Digits) ->
    {R, D} = hd(Digits),
    if
        N >= D -> to_roman(N - D, Roman ++ R, Digits);
        true   -> to_roman(N, Roman, tl(Digits))
    end.
