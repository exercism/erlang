-module(example).

-export([annotate/1]).

%% no rows
annotate([]) ->
	[];

%% no columns
annotate(Minefield=[""|_]) ->
	Minefield;

%% proper minefield
annotate(Minefield) ->
	process_minefield(extend(Minefield)).


%% surround the actual minefield with non-mines
%% the rows and columns of the extended minefield will be implicitly reversed
extend(Minefield=[R|_]) ->
	EdgeRow=[16#20 || _ <- lists:seq(1, length(R)+2)],
	[EdgeRow|extend(Minefield, [EdgeRow])].

extend([], Acc) ->
	Acc;

extend([Row|More], Acc) ->
	ExtendedRow=[16#20|lists:reverse([16#20|Row])],
	extend(More, [ExtendedRow|Acc]).


%% process the (extended) minefield
%% the rows and columns of the processed minefield will be implicitly reversed,
%% thereby restoring the original ordering
%% three rows need to be considered: the previous, the current, and the next
process_minefield(Minefield) ->
	process_minefield(Minefield, []).

%% only two rows left, at end of minefield
process_minefield([_, _], Acc) ->
	Acc;

%% at least 3 rows left, process them
process_minefield([PrevRow|More=[CurRow, NextRow|_]], Acc) ->
	process_minefield(More, [process_row(PrevRow, CurRow, NextRow)|Acc]).


%% process a row of the minefield
%% three columns of the previous and next rows and two of the current row need to be considered
process_row(PrevRow, CurRow, NextRow) ->
	process_row(PrevRow, CurRow, NextRow, []).

%% only two columns left, at end of row
process_row([_, _], [_, _], [_, _], Acc) ->
	Acc;

%% current element is a mine, don't change it
process_row([_|MorePrev], [_|MoreCur=[$*|_]], [_|MoreNext], Acc) ->
	process_row(MorePrev, MoreCur, MoreNext, [$*|Acc]);

%% current element is not a mine, count surrounding mines, translate to character
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
