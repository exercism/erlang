-module(example).

-export([new_tree/3, empty/0, test_version/0]).

-export([from_tree/1, to_tree/1, up/1, left/1, right/1, value/1, set_value/2, set_left/2, set_right/2]).

-export_type([tree/0, zipper/0]).

-record(tree, {value       :: any(),
               left  = nil :: tree(),
               right = nil :: tree()}).

-record(zipper, {value       :: any(),
                 left  = nil :: tree(),
                 right = nil :: tree(),
                 trail = []  :: list({left | right, any(), tree()})}).

-opaque tree()   :: nil | #tree{}.
-opaque zipper() :: #zipper{}.

%% Tree API
%% ========

new_tree(Value, Left, Right) ->
    #tree{value = Value,
          left  = Left,
          right = Right}.

empty() -> nil.

test_version() ->
    1.

%% Zipper API
%% ==========

from_tree(BTree) ->
    #zipper{value = BTree#tree.value,
            left  = BTree#tree.left,
            right = BTree#tree.right}.

to_tree(Z = #zipper{trail = [_|_]}) -> to_tree(up(Z));
to_tree(Z = #zipper{trail = []}) ->
    new_tree(Z#zipper.value, Z#zipper.left, Z#zipper.right).

up(#zipper{trail = []}) -> empty();
up(Z = #zipper{trail = [{left, V, R}|T]}) ->
    #zipper{value = V,
            left  = new_tree(Z#zipper.value, Z#zipper.left, Z#zipper.right),
            right = R,
            trail = T};
up(Z = #zipper{trail = [{right, V, L}|T]}) ->
    #zipper{value = V,
            left  = L,
            right = new_tree(Z#zipper.value, Z#zipper.left, Z#zipper.right),
            trail = T}.

left(#zipper{left = nil}) -> nil;
left(Z = #zipper{}) ->
    Next = Z#zipper.left,
    #zipper{value = Next#tree.value,
            left  = Next#tree.left,
            right = Next#tree.right,
            trail = [{left, Z#zipper.value, Z#zipper.right}|Z#zipper.trail]}.

right(#zipper{right = nil}) -> nil;
right(Z = #zipper{}) ->
    Next = Z#zipper.right,
    #zipper{value = Next#tree.value,
            left  = Next#tree.left,
            right = Next#tree.right,
            trail = [{right, Z#zipper.value, Z#zipper.left}|Z#zipper.trail]}.

value(#zipper{value = V}) -> V.

set_value(Z = #zipper{}, V) ->
    Z#zipper{value = V}.

set_left(Z = #zipper{}, L) ->
    Z#zipper{left = L}.

set_right(Z = #zipper{}, R) ->
    Z#zipper{right = R}.
