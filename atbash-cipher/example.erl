-module( atbash_cipher ).

-export( [encode/1, decode/1] ).

encode( String ) -> [replace(X) || X <- String].

decode( String ) -> [replace(X) || X <- String].



replace( $A ) -> $Z;
replace( $B ) -> $Y;
replace( $C ) -> $X;
replace( $D ) -> $W;
replace( $E ) -> $V;
replace( $F ) -> $U;
replace( $G ) -> $T;
replace( $H ) -> $S;
replace( $I ) -> $R;
replace( $J ) -> $Q;
replace( $K ) -> $P;
replace( $L ) -> $O;
replace( $M ) -> $N;
replace( $N ) -> $M;
replace( $O ) -> $L;
replace( $P ) -> $K;
replace( $Q ) -> $J;
replace( $R ) -> $I;
replace( $S ) -> $H;
replace( $T ) -> $G;
replace( $U ) -> $F;
replace( $V ) -> $E;
replace( $W ) -> $D;
replace( $X ) -> $C;
replace( $Y ) -> $B;
replace( $Z ) -> $A;
replace( $a ) -> $z;
replace( $b ) -> $y;
replace( $c ) -> $x;
replace( $d ) -> $w;
replace( $e ) -> $v;
replace( $f ) -> $u;
replace( $g ) -> $t;
replace( $h ) -> $s;
replace( $i ) -> $r;
replace( $j ) -> $q;
replace( $k ) -> $p;
replace( $l ) -> $o;
replace( $m ) -> $n;
replace( $n ) -> $m;
replace( $o ) -> $l;
replace( $p ) -> $k;
replace( $q ) -> $j;
replace( $r ) -> $i;
replace( $s ) -> $h;
replace( $t ) -> $g;
replace( $u ) -> $f;
replace( $v ) -> $e;
replace( $w ) -> $d;
replace( $x ) -> $c;
replace( $y ) -> $b;
replace( $z ) -> $a;
replace( C ) -> C.
