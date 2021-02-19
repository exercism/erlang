-module(example).

-export([can_chain/1]).

can_chain([]) ->
	true;

can_chain([First|Dominoes]) ->
	can_chain(First, First, Dominoes, []).



can_chain({FL, _}, {_, LR}, [], []) ->
	FL=:=LR;

can_chain(_, _, [], _) ->
	false;

can_chain(First, Current={_, R}, [MaybeMatch={R, _}|NotVisited], Visited) ->
	can_chain(First, MaybeMatch, NotVisited++Visited, []) 
	orelse
	can_chain(First, Current, NotVisited, [MaybeMatch|Visited]);

can_chain(First, Current={_, R}, [MaybeMatch={L, R}|NotVisited], Visited) ->
	can_chain(First, {R, L}, NotVisited++Visited, [])
	orelse
	can_chain(First, Current, NotVisited, [MaybeMatch|Visited]);

can_chain(First, Current, [NonMatch|NotVisited], Visited) ->
	can_chain(First, Current, NotVisited, [NonMatch|Visited]).
