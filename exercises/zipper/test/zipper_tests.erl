-module(zipper_tests).

-define(TESTED_MODULE, (sut(zipper))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


%% Fixtures and helpers

bt(V, L, R) -> ?TESTED_MODULE:new_tree(V, L, R).
empty() -> ?TESTED_MODULE:empty().
leaf(V) -> ?TESTED_MODULE:new_tree(V, empty(), empty()).


t1() -> bt(1, bt(2, empty(), leaf(3)), leaf(4)).
t2() -> bt(1, bt(5, empty(), leaf(3)), leaf(4)).
t3() -> bt(1, bt(2, leaf(5), leaf(3)), leaf(4)).
t4() -> bt(1, leaf(2),                 leaf(4)).
t5() -> bt(1, bt(2, empty(), leaf(3)), bt(6, leaf(7), leaf(8))).
t6() -> bt(1, bt(2, empty(), leaf(5)), leaf(4)).

data_is_retained_test() ->
    Exp = t1(),
    ?assertMatch(Exp, ?TESTED_MODULE:to_tree(?TESTED_MODULE:from_tree(t1()))).

left_right_and_value_test() ->
    ?assertMatch(3, ?TESTED_MODULE:value(?TESTED_MODULE:right(?TESTED_MODULE:left(?TESTED_MODULE:from_tree(t1()))))).

dead_end_test() ->
    Exp = empty(),
    ?assertMatch(Exp, ?TESTED_MODULE:left(?TESTED_MODULE:left(?TESTED_MODULE:from_tree(t1())))).

tree_from_deep_focus_test() ->
    Exp = t1(),
    Zipper = ?TESTED_MODULE:right(?TESTED_MODULE:left(?TESTED_MODULE:from_tree(t1()))),
    ?assertMatch(Exp, ?TESTED_MODULE:to_tree(Zipper)).

traversing_up_from_top_test() ->
    Exp = empty(),
    ?assertMatch(Exp, ?TESTED_MODULE:up(?TESTED_MODULE:from_tree(t1()))).

left_right_and_up_test() ->
    Act0 = ?TESTED_MODULE:from_tree(t1()),
    Act1 = ?TESTED_MODULE:left(Act0),
    Act2 = ?TESTED_MODULE:up(Act1),
    Act3 = ?TESTED_MODULE:right(Act2),
    Act4 = ?TESTED_MODULE:up(Act3),
    Act5 = ?TESTED_MODULE:left(Act4),
    Act6 = ?TESTED_MODULE:right(Act5),
    ?assertMatch(3, ?TESTED_MODULE:value(Act6)).

set_value_test() ->
    Exp  = t2(),
    Act0 = ?TESTED_MODULE:from_tree(t1()),
    Act1 = ?TESTED_MODULE:left(Act0),
    Act2 = ?TESTED_MODULE:set_value(Act1, 5),
    Act3 = ?TESTED_MODULE:to_tree(Act2),
    ?assertMatch(Exp, Act3).

set_value_after_traversiing_up_test() ->
    Exp  = t2(),
    Act0 = ?TESTED_MODULE:from_tree(t1()),
    Act1 = ?TESTED_MODULE:left(Act0),
    Act2 = ?TESTED_MODULE:right(Act1),
    Act3 = ?TESTED_MODULE:up(Act2),
    Act4 = ?TESTED_MODULE:set_value(Act3, 5),
    Act5 = ?TESTED_MODULE:to_tree(Act4),
    ?assertMatch(Exp, Act5).

set_left_with_leaf_test() ->
    Exp  = t3(),
    Act0 = ?TESTED_MODULE:from_tree(t1()),
    Act1 = ?TESTED_MODULE:left(Act0),
    Act2 = ?TESTED_MODULE:set_left(Act1, leaf(5)),
    Act3 = ?TESTED_MODULE:to_tree(Act2),
    ?assertMatch(Exp, Act3).

set_right_with_empty_test() ->
    Exp  = t4(),
    Act0 = ?TESTED_MODULE:from_tree(t1()),
    Act1 = ?TESTED_MODULE:left(Act0),
    Act2 = ?TESTED_MODULE:set_right(Act1, empty()),
    Act3 = ?TESTED_MODULE:to_tree(Act2),
    ?assertMatch(Exp, Act3).

set_right_with_subtree_test() ->
    Exp  = t5(),
    Act0 = ?TESTED_MODULE:from_tree(t1()),
    Act1 = ?TESTED_MODULE:set_right(Act0, bt(6, leaf(7), leaf(8))),
    Act2 = ?TESTED_MODULE:to_tree(Act1),
    ?assertMatch(Exp, Act2).

set_value_from_deep_focus_test() ->
    Exp  = t6(),
    Act0 = ?TESTED_MODULE:from_tree(t1()),
    Act1 = ?TESTED_MODULE:left(Act0),
    Act2 = ?TESTED_MODULE:right(Act1),
    Act3 = ?TESTED_MODULE:set_value(Act2, 5),
    Act4 = ?TESTED_MODULE:to_tree(Act3),
    ?assertMatch(Exp, Act4).
