-module(example).

-export([triplets_with_sum/1]).


triplets_with_sum(Limit) ->
    [Triplet || Triplet={A, B, C} <- range_triplets(1, Limit div 2), A+B+C=:=Limit].



coprimes(Limit) ->
    MN = Limit div 2,
    lists:filtermap(
        fun
            (N) when MN rem N=:=0 ->
                M = MN div N,
                case (M-N) rem 2=:=1 andalso gcd(M, N)=:=1 of
                    true -> {true, {M, N}};
                    false -> false
                end;
            (_) -> false
        end,
        lists:seq(1, ceil2(math:sqrt(MN)))
    ).



base_triplets(Limit) ->
    lists:map(
        fun
            ({M, N}) ->
                SqM=M*M,
                SqN=N*N,
                case {SqM-SqN, 2*M*N, SqM+SqN} of
                    {A, B, C} when A>B -> {B, A, C};
                    ABC -> ABC
                end
        end,
        coprimes(Limit)
    ).



range_triplets(From, To) ->
    lists:foldl(
        fun
            (N, Acc) ->
                range_triplets1(From, To, N, Acc)
        end,
        [],
        lists:seq(4, To+1, 4)
    ).

range_triplets1(From, To, N, Acc) ->
    lists:foldl(
        fun
            (XYZ, Acc2) ->
                range_triplets2(From, To, XYZ, Acc2)
        end,
        Acc,
        base_triplets(N)
    ).

range_triplets2(From, To, XYZ={X, Y, Z}, Acc) ->
    Fwd=ceil2(From/X),
    ABC={Fwd*X, Fwd*Y, Fwd*Z},
    range_triplets3(ABC, XYZ, To, Acc).

range_triplets3({_, _, C}, _, To, Acc) when C>To ->
    Acc;
range_triplets3(ABC={A, B, C}, XYZ={X, Y, Z}, To, Acc) ->
    range_triplets3({A+X, B+Y, C+Z}, XYZ, To, [ABC|Acc]).



gcd(X, X) ->
    X;
gcd(M, N) when M<N ->
    gcd(N, M);
gcd(M, N) ->
    case M rem N of
        0 -> N;
        X -> gcd(M, X)
    end.

%% for OTP19-compatibility
ceil2(X) ->
    case trunc(X) of
        Y when X>Y -> Y+1;
        Y -> Y
    end.
