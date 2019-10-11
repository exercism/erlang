# Exercism Erlang Track

[![Join the chat at https://gitter.im/exercism/erlang](https://badges.gitter.im/exercism/erlang.svg)](https://gitter.im/exercism/erlang?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Exercism exercises in Erlang

## Contributing guide

For general information about how exercism works, please see the
[contributing guide](https://github.com/exercism/x-api/blob/master/CONTRIBUTING.md#the-exercise-data).

If you create “claiming” PRs with obviously unfinished code, please provide an estimate in the PR description when you will continue to work on the PR or you think it will be finished.

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

When there is a mention of "slug-name", it refers to the slug as used
on exercism URLs.  In contrast, "erlangified_slug_name" is the slug-name
with all dashes (`-`) replaced by underscores (`_`) to make the name
compatible with Erlang syntax.

  1. Create a folder `exercises/<slug-name>`.
  2. Set up folder structure (`src`, and `test`).
  3. Copy `rebar.config` and `src/*.app.src` from another exercise.
    1. Leave `rebar.config` unchanged.
    1. Rename `src/*.app.src` to `src/<erlangified_slug_name>.app.src`.
    1. On the first line of this file change the old erlangified_slug_name to the new one.
    1. On the second line change the old slug-name to the new one.
  4. In the `src`-folder, create two files: `example.erl` and `<erlangified_slug_name>.erl`.
   The first is for your example solution, the second is the 'empty' solution to give
   students a place to start.
   You might take the files from another exercise as your starting point.
   Ensure their module names match their (new) file names.
  5. In the `test`-folder, create one file: `<erlangified_slug_name>_tests.erl`
   and insert the boilerplate code shown below.
   This file is for the test cases.
  6. Implement/correct your solution in `src/example.erl`.
  7. Add tests to `<erlangified_slug_name>_tests.erl`.
  8. Run tests using `rebar3 eunit`.

Repeat steps 6, 7, and 8 until all tests are implemented and your
example solution passes them all.

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

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").
```

You will need to add entry for the exercise in the track's `config.json` file,
which you will find in the respository's root directory (two levels up).
For details see [Exercise configuration](https://github.com/exercism/docs/blob/master/language-tracks/configuration/exercises.md).

### Before pushing

Please make sure, that all tests pass by running
`_test/check-exercises.escript`. On windows you might need to call
`escript _test/check-exercises.escript`. Also a run of `bin/configlet lint`
should pass without error message.

Both programs will be run on Travis and a merge is unlikely if
tests fail.
