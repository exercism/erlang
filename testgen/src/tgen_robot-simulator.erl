-module('tgen_robot-simulator').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := #{position := #{x := ExpX, y := ExpY}, direction := ExpD}, property := <<"create">>, input := #{position := #{x := X, y := Y}, direction := D}}) ->
    TestName = tgen:to_test_name(N, Desc),

    Create=tgs:assign(tgs:var("Robot"), tgs:call_fun("robot_simulator:create", [])),
    Placement=tgs:call_fun("robot_simulator:place", [tgs:var("Robot"), tgs:value(direction_b2a(D)), tgs:value({X, Y})]),
    AssertDirection=tgs:call_macro("assertEqual", [tgs:value(direction_b2a(ExpD)), tgs:call_fun("robot_simulator:direction", [tgs:var("Robot")])]),
    AssertPosition=tgs:call_macro("assertEqual", [tgs:value({ExpX, ExpY}), tgs:call_fun("robot_simulator:position", [tgs:var("Robot")])]),

    Fn = tgs:simple_fun(TestName, [
            Create,
            Placement,
            AssertDirection,
            AssertPosition
        ]),

    {
        ok,
        Fn,
        [
            {"create", []},
            {"place", ["Robot", "Direction", "Position"]},
            {"direction", ["Robot"]},
            {"position", ["Robot"]}
        ]
    };
generate_test(N, #{description := Desc, expected := #{position := #{x := ExpX, y := ExpY}, direction := ExpD}, property := <<"move">>, input := #{position := #{x := X, y := Y}, direction := D, instructions := I}}) ->
    TestName = tgen:to_test_name(N, Desc),

    Create=tgs:assign(tgs:var("Robot"), tgs:call_fun("robot_simulator:create", [])),
    Placement=tgs:call_fun("robot_simulator:place", [tgs:var("Robot"), tgs:value(direction_b2a(D)), tgs:value({X, Y})]),
    Instructions=[tgs:call_fun("robot_simulator:"++instruction_c2l(Instr), [tgs:var("Robot")]) || <<Instr>> <= I],
    AssertDirection=tgs:call_macro("assertEqual", [tgs:value(direction_b2a(ExpD)), tgs:call_fun("robot_simulator:direction", [tgs:var("Robot")])]),
    AssertPosition=tgs:call_macro("assertEqual", [tgs:value({ExpX, ExpY}), tgs:call_fun("robot_simulator:position", [tgs:var("Robot")])]),

    FnBody=[
        Create,
        Placement
    ]
    ++Instructions
    ++[
        AssertDirection,
        AssertPosition
    ],

    Fn = tgs:simple_fun(TestName, FnBody),

    {
        ok,
        Fn,
        [
            {"create", []},
            {"place", ["Robot", "Direction", "Position"]},
            {"left", ["Robot"]},
            {"right", ["Robot"]},
            {"advance", ["Robot"]},
            {"direction", ["Robot"]},
            {"position", ["Robot"]}
        ]
    };
generate_test(_, _) ->
    ignore.

direction_b2a(<<"north">>) -> north;
direction_b2a(<<"east">>) -> east;
direction_b2a(<<"south">>) -> south;
direction_b2a(<<"west">>) -> west.

instruction_c2l($L) -> "left";
instruction_c2l($R) -> "right";
instruction_c2l($A) -> "advance".
