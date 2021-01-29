-module(zipper_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

%% Fixtures and helpers

bt(V, L, R) -> zipper:new_tree(V, L, R).
empty() -> nil.
leaf(V) -> zipper:new_tree(V, empty(), empty()).


t1() -> bt(1, bt(2, empty(), leaf(3)), leaf(4)).
t2() -> bt(1, bt(5, empty(), leaf(3)), leaf(4)).
t3() -> bt(1, bt(2, leaf(5), leaf(3)), leaf(4)).
t4() -> bt(1, leaf(2),                 leaf(4)).
t5() -> bt(1, bt(2, empty(), leaf(3)), bt(6, leaf(7), leaf(8))).
t6() -> bt(1, bt(2, empty(), leaf(5)), leaf(4)).

data_is_retained_test() ->
    Exp = t1(),
    ?assertMatch(Exp, zipper:to_tree(zipper:from_tree(t1()))).

left_right_and_value_test() ->
    ?assertMatch(3, zipper:value(zipper:right(zipper:left(zipper:from_tree(t1()))))).

dead_end_test() ->
    Exp = empty(),
    ?assertMatch(Exp, zipper:left(zipper:left(zipper:from_tree(t1())))).

tree_from_deep_focus_test() ->
    Exp = t1(),
    Zipper = zipper:right(zipper:left(zipper:from_tree(t1()))),
    ?assertMatch(Exp, zipper:to_tree(Zipper)).

traversing_up_from_top_test() ->
    Exp = empty(),
    ?assertMatch(Exp, zipper:up(zipper:from_tree(t1()))).

left_right_and_up_test() ->
    Act0 = zipper:from_tree(t1()),
    Act1 = zipper:left(Act0),
    Act2 = zipper:up(Act1),
    Act3 = zipper:right(Act2),
    Act4 = zipper:up(Act3),
    Act5 = zipper:left(Act4),
    Act6 = zipper:right(Act5),
    ?assertMatch(3, zipper:value(Act6)).

set_value_test() ->
    Exp  = t2(),
    Act0 = zipper:from_tree(t1()),
    Act1 = zipper:left(Act0),
    Act2 = zipper:set_value(Act1, 5),
    Act3 = zipper:to_tree(Act2),
    ?assertMatch(Exp, Act3).

set_value_after_traversiing_up_test() ->
    Exp  = t2(),
    Act0 = zipper:from_tree(t1()),
    Act1 = zipper:left(Act0),
    Act2 = zipper:right(Act1),
    Act3 = zipper:up(Act2),
    Act4 = zipper:set_value(Act3, 5),
    Act5 = zipper:to_tree(Act4),
    ?assertMatch(Exp, Act5).

set_left_with_leaf_test() ->
    Exp  = t3(),
    Act0 = zipper:from_tree(t1()),
    Act1 = zipper:left(Act0),
    Act2 = zipper:set_left(Act1, leaf(5)),
    Act3 = zipper:to_tree(Act2),
    ?assertMatch(Exp, Act3).

set_right_with_empty_test() ->
    Exp  = t4(),
    Act0 = zipper:from_tree(t1()),
    Act1 = zipper:left(Act0),
    Act2 = zipper:set_right(Act1, empty()),
    Act3 = zipper:to_tree(Act2),
    ?assertMatch(Exp, Act3).

set_right_with_subtree_test() ->
    Exp  = t5(),
    Act0 = zipper:from_tree(t1()),
    Act1 = zipper:set_right(Act0, bt(6, leaf(7), leaf(8))),
    Act2 = zipper:to_tree(Act1),
    ?assertMatch(Exp, Act2).

set_value_from_deep_focus_test() ->
    Exp  = t6(),
    Act0 = zipper:from_tree(t1()),
    Act1 = zipper:left(Act0),
    Act2 = zipper:right(Act1),
    Act3 = zipper:set_value(Act2, 5),
    Act4 = zipper:to_tree(Act3),
    ?assertMatch(Exp, Act4).
