-module(bob).

-export([response/1, test_version/0]).


response(_String) -> undefined.

test_version() -> 3.
