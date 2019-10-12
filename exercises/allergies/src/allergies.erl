-module(allergies).

-export([allergies/1, is_allergic_to/2]).

-type substance() :: eggs | peanuts | shellfish |strawberries |tomatoes | chocolate | pollen | cats.

-spec allergies(integer()) -> list(substance()) .

allergies(_Score) -> undefined.

-spec is_allergic_to(substance(), integer()) -> boolean().

is_allergic_to(_Substance, _Score) -> undefined.
