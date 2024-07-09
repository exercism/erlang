-module(example).

-export([maximum_value/2, item/2]).


-record(item, {weight, value}).

item(Weight, Value) -> #item{weight=Weight, value=Value}.

maximum_value([], _Capacity) -> 0;
maximum_value(Items, Capacity) ->
    Initial_values = lists:map(fun (_Cap) -> 0 end, lists:seq(0, Capacity)),
    find_max_value(Items, Initial_values, Capacity).

find_max_value([], Last_values, _Capacity) -> lists:last(Last_values);
find_max_value([Next_item | Remaining_items], Last_values, Capacity) ->
    Next_values = calculate_values(Next_item, Last_values, Capacity, []),
    find_max_value(Remaining_items, Next_values, Capacity).

calculate_values(_Item, _Last_values, 0, Acc) -> [0 | Acc];
calculate_values(Item=#item{weight=W}, Last_values, Capacity, Acc) when Capacity < W ->
    Value = lists:nth(Capacity + 1, Last_values),
    calculate_values(Item, Last_values, Capacity - 1, [Value | Acc]);
calculate_values(Item, Last_values, Capacity, Acc) ->
    Value_without = lists:nth(Capacity + 1, Last_values),
    Value_with = lists:nth(Capacity - Item#item.weight + 1, Last_values) + Item#item.value,
    Value = lists:max([Value_without, Value_with]),
    calculate_values(Item, Last_values, Capacity - 1, [Value | Acc]).

