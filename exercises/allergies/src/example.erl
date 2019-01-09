-module(example).

-export([allergies/1, is_allergic_to/2]).

-define(SUBSTANCES, #{
                        eggs => 2#00000001,
                        peanuts => 2#00000010,
                        shellfish => 2#00000100,
                        strawberries => 2#00001000,
                        tomatoes => 2#00010000,
                        chocolate => 2#00100000,
                        pollen => 2#01000000,
                        cats => 2#10000000
                    }).

is_allergic_to(Code, Score) when is_integer(Code) ->
    Code band Score =/= 0;
is_allergic_to(Substance, Score) ->
    try
        is_allergic_to(maps:get(Substance, ?SUBSTANCES), Score)
    catch
        error:{badkey, _} -> false
    end.

allergies(Score) ->
    [ Substance || {Substance, Code} <- maps:to_list(?SUBSTANCES), is_allergic_to(Code, Score) ].
