-module('tgen_grade-school').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := Exp, property := <<"grade">>, input := #{students := Students, desiredGrade := DesiredGrade}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(<<"get">>),

    {LastIdx, Assigns}=setup(Students),
    Exp1=lists:sort([binary_to_list(E) || E <- Exp]),

    Fn = tgs:simple_fun(TestName, Assigns++[
        tgs:call_macro("assertEqual", [
            tgs:value(Exp1),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("grade_school:" ++ Property, [
                    tgs:value(DesiredGrade),
                    tgs:var("S"++integer_to_list(LastIdx))])])])]),

    {ok, Fn, [{"new", []}, {"add", ["Name", "Grade", "School"]}, {Property, ["Grade", "School"]}]};

generate_test(N, #{description := Desc, expected := Exp, property := <<"roster">>, input := #{students := Students}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(<<"get">>),

    {LastIdx, Assigns}=setup(Students),
    Exp1=lists:sort([binary_to_list(E) || E <- Exp]),

    Fn = tgs:simple_fun(TestName, Assigns++[
        tgs:call_macro("assertEqual", [
            tgs:value(Exp1),
            tgs:call_fun("lists:sort", [
                tgs:call_fun("grade_school:" ++ Property, [
                    tgs:var("S"++integer_to_list(LastIdx))])])])]),

    {ok, Fn, [{"new", []}, {"add", ["Name", "Grade", "School"]}, {Property, ["School"]}]};

generate_test(_, _) ->
    ignore.

setup(Students) ->
    {LastIdx, Assigns0} = lists:foldl(
        fun
            ([Name, Grade], {Idx, Acc}) ->
                {
                    Idx+1,
                    [tgs:assign(
                        tgs:var("S"++integer_to_list(Idx+1)),
                        tgs:call_fun("grade_school:add", [tgs:value(binary_to_list(Name)), tgs:value(Grade), tgs:var("S"++integer_to_list(Idx))])
                    )|Acc]
                }
        end,
        {0, []},
        Students
    ),
    Assigns1 = lists:reverse(Assigns0),
    {LastIdx, [tgs:assign(tgs:var("S0"), tgs:call_fun("grade_school:new", []))|Assigns1]}.
