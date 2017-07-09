# Exercism Erlang Track

[![Join the chat at https://gitter.im/exercism/erlang](https://badges.gitter.im/exercism/erlang.svg)](https://gitter.im/exercism/erlang?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Exercism exercises in Erlang

## Contributing guide

For general information about how exercism works, please see the
[contributing guide](https://github.com/exercism/x-api/blob/master/CONTRIBUTING.md#the-exercise-data).

### Setting up your system for local development on the track

Please make sure you have installed erlang/OTP and `rebar3` as
described on [Installing Erlang](http://exercism.io/languages/erlang/installation)
or `docs/INSTALLATION.md` in this repository. Also run
`bin/fetch-configlet` to download the JSON-checker.

Please make sure you use one of the releases of erlang/OTP as
specified in `.travis.yml`, as these are the ones officially tested
and supported by this track.

Feel free to use any feature that was introduced in the oldest version
of the range, while also avoiding everything that has been removed or
deprecated in the newest one.

### Implementing an exercise

When there is a mention of “slug-name” it refers to the slug as used
on exercism URLs, “erlangified_slug_name” does mean, that you have to
replace dashes (`-`) in the slug by underscores (`_`) to make them
compatible with erlang syntax.

1. Create a folder `exercises/<slug-name>`
2. Set up folder structure (`include`, `src`, and `test`).
3. Copy `rebar.conf`, `src/*.app.src`, and `include/exercism.hrl` from
   another exercise.
   3.1. Find the line `{eunit_tests, [{application, <erlangified_slug_name>}]}`
        in `rebar.conf` and alter it to match the current exercise.
   3.2. Rename `src/*.app.src` to `src/<erlangified_slug_name>`.
   3.3. Change the old erlangified_slug_name on the first line to the new one.
   3.4. Change the old slug-name on the second line to the new one.
   3.5. Leave `include/exercism.hrl` untouched.
4. Create a testfile/-module in `test`-folder. It is preferred to name
   it after the erlangified_slug_name and insert the boilerplate code
   shown below.
5. Implement your example in `src/example.erl` and use `example` as
   the name for the module.
6. Add tests. Make sure you are using the macro `?TESTED_MODULE` when
   referencing the students module.
7. Run tests using `rebar3 eunit`.

Repeat steps 5., 6., and 7. until all tests are implemented and your
solution passes all tests.

If there is a `exercises/<slug-name>/canonical-data.json`
in [problem-specifications](https://github.com/exercism/problem-specifications), make sure to
implement your tests and examples in a way that the canonical data is
integrated and not violated.

You may add further tests, as long as they do not violate canonical
data and add value to the exercise or are necessary for erlang
specific things.

Also please make sure to add a `HINTS.md` with some hints for the
students if the exercise becomes tricky or might not be obvious.

```erl
-module(<test module name>).

-define(TESTED_MODULE, (sut(<erlangified_slug_name>))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").
```

### Before pushing

Please make sure, that all tests pass by running
`_test/check-exercises.escript`. On windows you might need to call
`escript _test/check-exercises.escript`. Also a run of `bin/configlet`
should pass without error message.

Both programs will be run on Travis and a merge is unlikely when
tests fail.

