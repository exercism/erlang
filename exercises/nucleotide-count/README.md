# Nucleotide Count

Given a DNA string, compute how many times each nucleotide occurs in the string.

DNA is represented by an alphabet of the following symbols: 'A', 'C',
'G', and 'T'.

Each symbol represents a nucleotide, which is a fancy name for the
particular molecules that happen to make up a large part of DNA.

Shortest intro to biochemistry EVAR:

- twigs are to birds nests as
- nucleotides are to DNA and RNA as
- amino acids are to proteins as
- sugar is to starch as
- oh crap lipids

I'm not going to talk about lipids because they're crazy complex.

So back to nucleotides.

DNA contains four types of them: adenine (`A`), cytosine (`C`), guanine
(`G`), and thymine (`T`).

RNA contains a slightly different set of nucleotides, but we don't care
about that for now.

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

The Calculating DNA Nucleotides_problem at Rosalind [http://rosalind.info/problems/dna/](http://rosalind.info/problems/dna/)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
