* * * *

For installation and learning resources, refer to the
[exercism help page](http://exercism.io/languages/erlang).

For running the tests provided, only libraries delivered with recent
versions of erlang are used, so there is no need to install anything.

In order to run the tests, you can issue the following commands from
the exercise directory. Please substitute `$EXERCISE` with the
exercises name.

```sh
erl -make
erl -noshell -eval "eunit:test($EXERCISE, [verbose])" -s init stop
```
