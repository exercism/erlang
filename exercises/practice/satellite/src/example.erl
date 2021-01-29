-module(example).

-export([tree_from_traversals/2]).


tree_from_traversals(PreOrder, InOrder) ->
	true=is_valid(PreOrder, InOrder),
	build(PreOrder, InOrder).

is_valid(PreOrder, InOrder) ->
	lists:sort(PreOrder)=:=lists:sort(InOrder) andalso
	length(lists:usort(PreOrder))=:=length(PreOrder) andalso
	length(lists:usort(InOrder))=:=length(InOrder).

build(PreOrder, InOrder) ->
	PreOrder1=lists:zip(lists:seq(1, length(PreOrder)), PreOrder),
	InOrder1=lists:zip(lists:seq(1, length(InOrder)), InOrder),
	build1(PreOrder1, InOrder1).

build1([], _) ->
	#{};
build1([{PreIdx, Value}|PreOrder], InOrder) ->
	{LeftInOrder, RightInOrder}=lists:partition(
		fun ({Idx, _}) -> Idx=<PreIdx end,
		InOrder
	),
	{LeftPreOrder, RightPreOrder}=lists:partition(
		fun ({_, Item}) -> false=/=lists:keyfind(Item, 2, LeftInOrder) end,
		PreOrder
	),
	Left=build1(LeftPreOrder, LeftInOrder),
	Right=build1(RightPreOrder, RightInOrder),
	#{v => Value, l => Left, r => Right}.
