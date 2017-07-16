# Sum Of Multiples

Given a number, find the sum of all the multiples of particular numbers up to
but not including that number.

If we list all the natural numbers up to but not including 20 that are
multiples of either 3 or 5, we get 3, 5, 6 and 9, 10, 12, 15, and 18.

The sum of these multiples is 78.

Given a number, find the sum of the multiples of a given set of numbers,
up to but not including that number.

## Running tests

In order to run the tests, issue the following command from the exercise
directory:

For running the tests provided, `rebar3` is used as it is the official build and
dependency management tool for erlang now. Please refer to [the tracks installation
instructions](http://exercism.io/languages/erlang/installation) on how to do that.

In order to run the tests, you can issue the following command from the exercise
directory.

```bash
$ rebar3 eunit
```

### Test versioning

Each problem defines a macro `TEST_VERSION` in the test file and
verifies that the solution defines and exports a function `test_version`
returning that same value.

To make tests pass, add the following to your solution:

```erlang
-export([test_version/0]).

test_version() ->
  1.
```

The benefit of this is that reviewers can see against which test version
an iteration was written if, for example, a previously posted solution
does not solve the current problem or passes current tests.

## Questions?

For detailed information about the Erlang track, please refer to the
[help page](http://exercism.io/languages/erlang) on the Exercism site.
This covers the basic information on setting up the development
environment expected by the exercises.

## Source

A variation on Problem 1 at Project Euler [http://projecteuler.net/problem=1](http://projecteuler.net/problem=1)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
