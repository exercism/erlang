-module(hello_world).
-export([greet/0, greet/1]).

greet() -> "Hello, World!".
greet(Name) -> "Hello, " ++ Name ++ "!".
