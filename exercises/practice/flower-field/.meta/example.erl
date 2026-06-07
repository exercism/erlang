-module(example).

-export([annotate/1]).

%% no rows
annotate([]) ->
	[];

%% no columns
annotate(Garden=[""|_]) ->
	Garden;

%% proper garden
annotate(Garden) ->
	process_garden(extend(Garden)).


%% surround the actual garden with non-flowers
%% the rows and columns of the extended garden will be implicitly reversed
extend(Garden=[R|_]) ->
	EdgeRow=[16#20 || _ <- lists:seq(1, length(R)+2)],
	[EdgeRow|extend(Garden, [EdgeRow])].

extend([], Acc) ->
	Acc;

extend([Row|More], Acc) ->
	ExtendedRow=[16#20|lists:reverse([16#20|Row])],
	extend(More, [ExtendedRow|Acc]).


%% process the (extended) garden
%% the rows and columns of the processed garden will be implicitly reversed,
%% thereby restoring the original ordering
%% three rows need to be considered: the previous, the current, and the next
process_garden(Garden) ->
	process_garden(Garden, []).

%% only two rows left, at end of garden
process_garden([_, _], Acc) ->
	Acc;

%% at least 3 rows left, process them
process_garden([PrevRow|More=[CurRow, NextRow|_]], Acc) ->
	process_garden(More, [process_row(PrevRow, CurRow, NextRow)|Acc]).


%% process a row of the garden
%% three columns of the previous and next rows and two of the current row need to be considered
process_row(PrevRow, CurRow, NextRow) ->
	process_row(PrevRow, CurRow, NextRow, []).

%% only two columns left, at end of row
process_row([_, _], [_, _], [_, _], Acc) ->
	Acc;

%% current element is a flower, don't change it
process_row([_|MorePrev], [_|MoreCur=[$*|_]], [_|MoreNext], Acc) ->
	process_row(MorePrev, MoreCur, MoreNext, [$*|Acc]);

%% current element is not a flower, count surrounding flowers, translate to character
process_row([PrevPrev|MorePrev=[PrevCur, PrevNext|_]], [CurPrev|MoreCur=[_, CurNext|_]], [NextPrev|MoreNext=[NextCur, NextNext|_]],  Acc) ->
	N=lists:foldl(
		fun ($*, Count) -> Count+1; (16#20, Count) -> Count end,
		0,
		[PrevPrev, PrevCur, PrevNext, CurPrev, CurNext, NextPrev, NextCur, NextNext]
	),
	process_row(MorePrev, MoreCur, MoreNext, [count_to_char(N)|Acc]).


%% translate a count into a character
count_to_char(0) -> 16#20;
count_to_char(N) -> $0+N.
