# Robot Simulator

Write a robot simulator.

A robot factory's test facility needs a program to verify robot movements.

The robots have three possible movements:

- turn right
- turn left
- advance

Robots are placed on a hypothetical infinite grid, facing a particular
direction (north, east, south, or west) at a set of {x,y} coordinates,
e.g., {3,8}, with coordinates increasing to the north and east.

The robot then receives a number of instructions, at which point the
testing facility verifies the robot's new position, and in which
direction it is pointing.

- The letter-string "RAALAL" means:
  - Turn right
  - Advance twice
  - Turn left
  - Advance once
  - Turn left yet again
- Say a robot starts at {7, 3} facing north. Then running this stream
  of instructions should leave it at {9, 4} facing west.

This exercise does require some kind of global state for your
robot. In erlang this can be done in various ways (starting with most
idiomatic one):

1. Use some `gen_*` from OTP
2. Roll your own process and receive messages in a loop and pass the
   state as parameter around.
3. Roll your own process and use the process dictionary.



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

Inspired by an interview question at a famous company.

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
