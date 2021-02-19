-module(example).

-export([absolute/1, add/2, divide/2, exp/2, mul/2, reduce/1, sub/2]).


absolute({A, B}) ->
    reduce({abs(A), abs(B)}).

add({A1, B1}, {A2, B2}) ->
    reduce({A1*B2+A2*B1, B1*B2}).

divide(R1, {A2, B2}) ->
    mul(R1, {B2, A2}).

exp({A, B}, Exponent) when is_float(Exponent) ->
    math:pow(A, Exponent)/math:pow(B, Exponent);
exp({A, B}, Exponent) when Exponent>=0 ->
    reduce({trunc(math:pow(A, Exponent)), trunc(math:pow(B, Exponent))});
exp({A, B}, Exponent) ->
    reduce({trunc(math:pow(B, abs(Exponent))), trunc(math:pow(A, abs(Exponent)))});
exp(X, {A, B}) ->
    math:pow(math:pow(X, A), 1/B).

mul({A1, B1}, {A2, B2}) ->
    reduce({A1*A2, B1*B2}).

reduce({A, B}) ->
    GCD=gcd(A, B),
    normalize({A div GCD, B div GCD}).

sub({A1, B1}, {A2, B2}) ->
    add({A1, B1}, {-A2, B2}).


normalize({A, B}) when B<0 ->
    {-A, abs(B)};
normalize(R) ->
    R.

gcd(0, B) ->
    abs(B);
gcd(A, B) ->
    X=min(abs(A), abs(B)),
    [GCD|_]=[D || D <- lists:seq(X, 1, -1), A rem D=:=0, B rem D=:=0],
    GCD.
