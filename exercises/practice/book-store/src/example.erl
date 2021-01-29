-module(example).

-export([total/1]).

group_total(1) -> 800;
group_total(2) -> 2*760;
group_total(3) -> 3*720;
group_total(4) -> 4*640;
group_total(5) -> 5*600.

total([]) ->
	0;
total(Basket) ->
	calculate(Basket).

calculate(Items) ->
	calculate(reorder(Items), 0).

calculate([], Total) ->
	Total;
calculate(Items, Total) ->
	Group=dedup(Items),
	lists:foldl(
		fun (N, Acc) ->
			RemoveItems=lists:sublist(Group, N),
			RemainingItems=Items--RemoveItems,
			CurTotal=calculate(RemainingItems, Total+group_total(N)),
			min(Acc, CurTotal)
		end,
		infinity,
		lists:seq(length(Group), 1, -1)
	).

reorder(Items) ->
	Grouped=group(Items),
	Sorted=lists:reverse(lists:keysort(2, maps:to_list(Grouped))),
	expand(Sorted).

group([]) ->
	#{};
group([Item|Items]) ->
	R=group(Items),
	maps:update_with(Item, fun (Old) -> Old+1 end, 1, R).

expand([]) ->
	[];
expand([{_, 0}|Groups]) ->
	expand(Groups);
expand([{Item, Count}|Groups]) ->
	R=expand([{Item, Count-1}|Groups]),
	[Item|R].

dedup([]) ->
	[];
dedup([Item|Items]) ->
	case dedup(Items) of
		R=[Item|_] -> R;
		R -> [Item|R]
	end.
