-module(example).
-export([greet/0, greet/1, test_version/0]).

greet() -> "Hello, World!".
greet(Name) -> "Hello, " ++ Name ++ "!".

test_version() ->
    1.
