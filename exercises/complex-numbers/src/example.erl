-module(example).

-export([abs/1, add/2, conjugate/1, divide/2, equal/2, exp/1, imaginary/1, mul/2, new/2,
    real/1, sub/2, test_version/0]).

-record(complex, {r = 0, i = 0}).

new(R, I) -> #complex{r = R, i = I}.

abs(#complex{r = A, i = B}) ->
    erlang:abs(math:sqrt(A * A + B * B)).

add(#complex{r = A, i = B}, #complex{r = C, i = D}) ->
    #complex{r = A + C, i = B + D}.

conjugate(#complex{r = A, i = B}) ->
    #complex{r = A, i = -B}.

divide(#complex{r = A, i = B}, #complex{r = C, i = D}) ->
    #complex{
        r = (A * C + B * D) / (C * C + D * D),
        i = (B * C - A * D) / (C * C + D * D)}.

equal(#complex{r = A, i = B}, #complex{r = C, i = D}) when erlang:abs(A - C) < 0.005, erlang:abs(B - D) < 0.005 -> true;
equal(X, Y) -> false.

exp(#complex{r = A, i = B}) ->
    mul(
        new(math:exp(A), 0),
        new(math:cos(B), math:sin(B))).

imaginary(#complex{i = B}) ->
    B.

mul(#complex{r = A, i = B}, #complex{r = C, i = D}) ->
    #complex{r = A * C - B * D, i = B * C + A * D}.

real(#complex{r = A}) ->
    A.

sub(#complex{r = A, i = B}, #complex{r = C, i = D}) ->
    #complex{r = A - C, i = B - D}.

test_version() -> 1.
