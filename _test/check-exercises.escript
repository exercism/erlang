#! /usr/bin/env escript

main( [] ) -> 
	Examples = filelib:wildcard( "*/example.erl" ),
	Modules = [{X, compile_example(X)} || X <- Examples],
	[compile_tests(X) || X <- Modules],
	[eunit:test(Module) || {_Example, {Module, _Binary}} <- Modules];
main( _ ) -> usage().



compile_example( Example ) ->
	{compile, Example, {ok, Module, Binary}} = {compile, Example, compile:file( Example, [binary, return_errors] )},
	{load, Module, {module, Module}} = {load, Module, code:load_binary( Module, Example, Binary )},
	{Module, Binary}.


compile_tests( {Example, {Example_module, _Binary}} ) ->
	Tests_file = erlang:atom_to_list(Example_module) ++ "_tests.erl",
	{compile, Tests_file, {ok, Module, Binary}}
	= {compile, Tests_file, compile:file( filename:join( [filename:dirname(Example), Tests_file] ),[binary, return_errors] )},
	{load, Module, {module, Module}} = {load, Module, code:load_binary( Module, Tests_file, Binary )}.


usage() ->
	io:fwrite( "Usage: ~s~n", [escript:script_name()] ),
	io:fwrite( "~s will compile and run Erlang examples and test cases in sub directories of where it is started.~n", [escript:script_name()] ).
