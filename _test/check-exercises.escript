#!/usr/bin/env escript

main([])->
    main(["all"]);
main(["all"]) ->
    Examples = filelib:wildcard("exercises/*/rebar.conf"),
    ExampleBasePaths = [extract_base_pathes(X) || X <- Examples],
    Exercises = [X -- "exercises/" || X <- ExampleBasePaths],
    run_exercises(Exercises);
main(["single", Exercise]) ->
    main(["list", Exercise]);
main(["list"|Exercises]) ->
    run_exercises(Exercises).


extract_base_pathes(ConfPath) ->
    ConfPath1 = lists:reverse(ConfPath),
    ConfPath2 = ConfPath1 -- "rebar.conf/",
    lists:reverse(ConfPath2).


run_exercises([E|Es]) when is_list(E)->
    run_exercises([E|Es], length([E|Es]), 0, 0).


run_exercises([], Items, Items, Result) ->
    io:format("Finished.~n"),
    halt(Result);
run_exercises([E|Es], Items, Current, Result) ->
    io:format("Processing ~p. of ~p Items (~p%).~n",
              [Current + 1, Items, Current/Items*100]),
    run_exercises(Es, Items, Current + 1, Result + run_rebar(E)).


run_rebar(Exercise) ->
    Rebar = os:find_executable("rebar3"),
    Port = open_port({spawn_executable, Rebar},
                     [{line, 1024},
                      {cd, "exercises/" ++ Exercise},
                      {args, ["eunit"]},
                      exit_status,
                      in,
                      binary,
                      eof]),
    loop_rebar(Port, no_exitcode, no_eof).


loop_rebar(Port, 0, eof) ->
    true = port_close(Port),
    0;
loop_rebar(Port, ExCode, eof) when is_integer(ExCode) ->
    true = port_close(Port),
    1;
loop_rebar(Port, ExCode, EOF) ->
    {ExCode1, EOF1} =
        receive
            {Port, {data, {eol, Data}}} ->
                io:format("~s~n", [Data]),
                {ExCode, EOF};
            {Port, {data, {noeol, Data}}} ->
                io:format("~s", [Data]),
                {ExCode, EOF};
            {Port, {exit_status, Code}} ->
                {Code, EOF};
            {Port, eof} ->
                {ExCode, eof};
            Foo ->
                io:format("~p~n", [Foo]),
                {ExCode, EOF}
        end,
    loop_rebar(Port, ExCode1, EOF1).

