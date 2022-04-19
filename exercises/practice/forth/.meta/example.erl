-module(example).

-export([evaluate/1]).

-record(state, {instructions, definitions, stack}).

%% generate base instruction set
instruction_set() ->
    #{
        "+" => fun ([B, A|Stack]) -> [A+B|Stack] end,
        "-" => fun ([B, A|Stack]) -> [A-B|Stack] end,
        "*" => fun ([B, A|Stack]) -> [A*B|Stack] end,
        "/" => fun ([B, A|Stack]) -> [A div B|Stack] end,
        "DUP" => fun (Stack=[X|_]) -> [X|Stack] end,
        "DROP" => fun ([_|Stack]) -> Stack end,
        "SWAP" => fun ([B, A|Stack]) -> [A, B|Stack] end,
        "OVER" => fun (Stack=[_, X|_]) -> [X|Stack] end
    }.


evaluate(Instructions) ->
    State=#state{instructions=instruction_set(), definitions=#{}, stack=[]},
    evaluate([string:to_upper(I) || I <- Instructions], State).

%% no more instructions
evaluate([], #state{stack=Stack}) ->
    lists:reverse(Stack);
%% instruction is a definition
evaluate([[$:|Def]|Instructions], State) ->
    evaluate(Instructions, define(Def, State));
%% instruction is something to execute
evaluate([Instr|Instructions], State) ->
    evaluate(Instructions, exec(Instr, State)).


is_forth_number("-") -> false;
is_forth_number("-" ++ N) -> is_forth_number(N);
is_forth_number(N) -> lists:all(fun (C) -> C>=$0 andalso C=<$9 end, N).

define(Dfn0, State=#state{instructions=Instructions, definitions=Definitions}) ->
    %% split into name and definition tokens
    [Name|Dfn1]=string:tokens(Dfn0, " "),

    %% ensure name is not a number
    false=is_forth_number(Name),

    %% drop trailing ;
    Dfn2=lists:sublist(Dfn1, length(Dfn1)-1),

    %% process definition
    Dfn3=lists:map(
        fun
            (Tok) ->
                case is_forth_number(Tok) of
                    %% number, keep as is
                    true -> Tok;

                    %% word
                    false ->
                        case {maps:get(Tok, Definitions, undefined), maps:get(Tok, Instructions, undefined)} of
                            %% unknown, error
                            {undefined, undefined} -> error(undef);

                            %% non-overridden instruction, keep as is
                            {undefined, _} -> Tok;

                            %% user-defined word, replace with definition
                            {Replacement, _} -> Replacement
                        end
                end
        end,
        Dfn2
    ),

    %% normalize
    Dfn4=lists:flatten(lists:join(" ", Dfn3)),
    State#state{definitions=Definitions#{Name => Dfn4}}.


exec(Instr, State) ->
    %% split instruction string into tokens
    Tokens=string:tokens(Instr, " "),

    %% process instruction
    lists:foldl(
        fun
            (Tok, Acc=#state{instructions=Instructions, definitions=Definitions, stack=Stack}) ->
                case is_forth_number(Tok) of
                    %% number, put on stack
                    true -> Acc#state{stack=[list_to_integer(Tok)|Stack]};

                    %% word
                    false ->
                        case {maps:get(Tok, Definitions, undefined), maps:get(Tok, Instructions, undefined)} of
                            %% unknown, error
                            {undefined, undefined} -> error(undef);

                            %% non-overridden instruction, execute
                            {undefined, Fun} -> Acc#state{stack=Fun(Stack)};

                            %% user-defined word, execute
                            {Replacement, _} -> exec(Replacement, Acc)
                        end
                end
        end,
        State,
        Tokens
    ).
