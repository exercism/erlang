#! /usr/bin/env escript

main( [] ) ->
	Examples = filelib:wildcard( "*/example.erl" ),
	Modules = [{X, compile(X)} || X <- Examples],
	[compile_tests(X) || X <- Modules],
	Results = [run_tests(X) || X <- Modules],
	erlang:halt( erlang:length([X || X <- Results, X =/= ok]) );
main( _ ) -> usage().

compile( File ) ->
	Compile = compile:file( File, [binary, return_errors] ),
	{compile, File, {ok, Module, Binary}} = {compile, File, Compile},
	Load = code:load_binary( Module, File, Binary ),
	{load, Module, Load} = {load, Module, Load},
	{Module, Binary}.


compile_tests( {Example, {Example_module, _Binary}} ) ->
	Filename = erlang:atom_to_list(Example_module) ++ "_tests.erl",
	Filepath = filename:join( [filename:dirname(Example), Filename] ),
	compile( Filepath ).


run_tests( {_Example, {Module, _Binary}} ) ->
	io:fwrite( "~p: ", [Module] ),
	eunit:test( Module ).


usage() ->
	io:fwrite( "Usage: ~s~n", [escript:script_name()] ),
	io:fwrite( "~s will compile and run Erlang examples and test cases in sub directories of where it is started.~n", [escript:script_name()] ).
