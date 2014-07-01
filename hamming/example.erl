-module( hamming ).

-export( [distance/2] ).

distance( [], _ ) -> 0;
distance( _, [] ) -> 0;
distance( [A|As], [A|Bs] ) -> distance( As, Bs );
distance( [_|As], [_|Bs] ) -> 1 + distance( As, Bs ).
