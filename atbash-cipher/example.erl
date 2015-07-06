-module(atbash_cipher).

-export( [encode/1, decode/1] ).

encode( String ) -> [replace(X) || X <- String].

decode( String ) -> [replace(X) || X <- String].



replace( C ) when C =< $Z, C >= $A -> $Z - (C - $A);
replace( C ) when C =< $z, C >= $a -> $z - (C - $a);
replace( C ) -> C.
