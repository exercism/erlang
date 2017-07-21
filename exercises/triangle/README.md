# Triangle

Determine if a triangle is equilateral, isosceles, or scalene.

An _equilateral_ triangle has all three sides the same length.<br/>
An _isosceles_ triangle has at least two sides the same length. (It is sometimes
specified as having exactly two sides the same length, but for the purposes of
this exercise we'll say at least two.)<br/>
A _scalene_ triangle has all sides of different lengths.

## Note

For a shape to be a triangle at all, all sides have to be of length > 0, and 
the sum of the lengths of any two sides must be greater than or equal to the 
length of the third side. See [Triangle Inequality](https://en.wikipedia.org/wiki/Triangle_inequality).

## Dig Deeper

The case where the sum of the lengths of two sides _equals_ that of the 
third is known as a _degenerate_ triangle - it has zero area and looks like 
a single line. Feel free to add your own code/tests to check for degenerate triangles.
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

The Ruby Koans triangle project, parts 1 & 2 [http://rubykoans.com](http://rubykoans.com)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
