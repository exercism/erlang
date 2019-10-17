-module(phone_number).

-export([number/1, areacode/1, pretty_print/1]).

-spec number(unicode:chardata()) -> unicode:chardata().

number(_String) ->
  undefined.

-spec areacode(unicode:chardata()) -> unicode:chardata().

areacode(_String) ->
  undefined.

-spec pretty_print(unicode:chardata()) -> unicode:chardata().

pretty_print(_String) ->
  undefined.
