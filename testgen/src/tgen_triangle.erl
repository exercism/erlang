-module('tgen_triangle').

-behaviour(tgen).

%% The Erlang track implementation is quite different from what the canonical data suggests, but does not actually run contrary to it.
%% While the canonical data suggests three functions `equilateral`, `isosceles`, and `scalene` that return a boolean value, the Erlang
%% track implementation consists of a single function `kind` that returns either one of the atoms `equilateral`, `isosceles`, or `scalene`,
%% or an error tuple in case of invalid input.
%%
%% This means that the test cases have to be transformed to invariably replace the property with `kind`, and the expected return to the
%% atom representation of the property.
%%
%% Also, as the canonical data does not define any error cases but expects the called function to just return `false`, these tests need to
%% be transformed to expect the appropriate error tuples instead.
%%
%% Apart from the previous case, we can only consider the positive cases, those that expect `true`.
%% 
%% Further, the canonical data at the time of this writing contains a test that passes three equal sides to the `isosceles` function and
%% expects it to return true, as equilateral triangles are a subset of isosceles traingles (and isosceles triangles are in turn a subset
%% of scalene triangles), whereas the Erlang track implementation of `kind` will invariably return the smallest subset (`equilateral` in
%% this case). Tests like this are skipped by this test generator.

-define(REPLACEMENT_PROPERTY, <<"kind">>).

-export([
    available/0,
    prepare_tests/1,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

prepare_tests(Cases) ->
    lists:filtermap(
        fun
            %% transform invalid input to expect error tuples
            (Case=#{description := Desc, property := Prop, input := #{sides := [A, B, C]}}) when A=<0; B=<0; C=<0 ->
                {true, Case#{description => augment_desc(Prop, Desc), property => ?REPLACEMENT_PROPERTY, expected => {error, "all side lengths must be positive"}}};
            (Case=#{description := Desc, property := Prop, input := #{sides := [A, B, C]}}) when A+B=<C; A+C=<B; B+C=<A ->
                {true, Case#{description => augment_desc(Prop, Desc), property => ?REPLACEMENT_PROPERTY, expected => {error, "side lengths violate triangle inequality"}}};

            %% only consider positive cases further down
	    (#{expected := false}) ->
                false;

            %% transform equilateral cases
            (Case=#{description := Desc, property := Prop = <<"equilateral">>}) ->
                {true, Case#{description => augment_desc(Prop, Desc), property => ?REPLACEMENT_PROPERTY, expected => prop2exp(Prop)}};

            %% transform isosceles cases, skip tests whose input would actually be equilateral
            (#{property := <<"isosceles">>, input := #{sides := [S, S, S]}}) ->
		false;
            (Case=#{description := Desc, property := Prop = <<"isosceles">>}) ->
                {true, Case#{description => augment_desc(Prop, Desc), property => ?REPLACEMENT_PROPERTY, expected => prop2exp(Prop)}};

            %% transform scalene cases, skip tests whose input would actually be isosceles or equilateral
            (#{property := <<"scalene">>, input := #{sides := [S, S, _]}}) ->
		false;
            (#{property := <<"scalene">>, input := #{sides := [S, _, S]}}) ->
		false;
            (#{property := <<"scalene">>, input := #{sides := [_, S, S]}}) ->
		false;
            (Case=#{description := Desc, property := Prop = <<"scalene">>}) ->
                {true, Case#{description => augment_desc(Prop, Desc), property => ?REPLACEMENT_PROPERTY, expected => prop2exp(Prop)}};

            %% skip anything we didn't provide for
            (_) ->
                false
        end,
        Cases
    ).

generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{sides := [A, B, C]}}) ->
    TestName=tgen:to_test_name(N, Desc),
    Property=tgen:to_property_name(Prop),

    Fn=
    tgs:simple_fun(
        TestName,
        [
            tgs:call_macro("assertMatch",
                [
                    tgs:value(Exp),
                    tgs:call_fun(
                        "triangle:" ++ Property,
                        [
                            tgs:value(A),
                            tgs:value(B),
                            tgs:value(C)
                        ]
                    )
                ]
            )
        ]
    ),

    {ok, Fn, [{Property, ["A", "B", "C"]}]}.


augment_desc(Prop, Desc) ->
    <<Prop/binary, $_, Desc/binary>>.

prop2exp(Prop) ->
    binary_to_atom(Prop, latin1).
