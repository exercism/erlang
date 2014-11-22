-module( leap ).

-export( [is_leap_year/1] ).

is_leap_year( Year ) when (Year rem 4) =:= 0, (Year rem 100) =/= 0 -> true;
is_leap_year( Year ) when (Year rem 400) =:= 0 -> true;
is_leap_year( _ ) -> false.
