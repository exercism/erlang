-module(example).

-export([proteins/1]).

proteins(Strand) ->
	case proteins(Strand, []) of
		{ok, Proteins} -> {ok, lists:reverse(Proteins)};
	    {error, Error} -> {error, Error}
	end.

proteins([], Acc) ->
	{ok, Acc};

proteins([$U, $A, $A|_], Acc) ->
	{ok, Acc};

proteins([$U, $A, $G|_], Acc) ->
	{ok, Acc};

proteins([$U, $G, $A|_], Acc) ->
	{ok, Acc};

proteins([$A, $U, $G|More], Acc) ->
	proteins(More, [methionine|Acc]);

proteins([$U, $U, $U|More], Acc) ->
	proteins(More, [phenylalanine|Acc]);

proteins([$U, $U, $C|More], Acc) ->
	proteins(More, [phenylalanine|Acc]);

proteins([$U, $U, $A|More], Acc) ->
	proteins(More, [leucine|Acc]);

proteins([$U, $U, $G|More], Acc) ->
	proteins(More, [leucine|Acc]);

proteins([$U, $C, $U|More], Acc) ->
	proteins(More, [serine|Acc]);

proteins([$U, $C, $C|More], Acc) ->
	proteins(More, [serine|Acc]);

proteins([$U, $C, $A|More], Acc) ->
	proteins(More, [serine|Acc]);

proteins([$U, $C, $G|More], Acc) ->
	proteins(More, [serine|Acc]);

proteins([$U, $A, $U|More], Acc) ->
	proteins(More, [tyrosine|Acc]);

proteins([$U, $A, $C|More], Acc) ->
	proteins(More, [tyrosine|Acc]);

proteins([$U, $G, $U|More], Acc) ->
	proteins(More, [cysteine|Acc]);

proteins([$U, $G, $C|More], Acc) ->
	proteins(More, [cysteine|Acc]);

proteins([$U, $G, $G|More], Acc) ->
	proteins(More, [tryptophan|Acc]);

proteins(_, _) ->
	{error, badarg}.