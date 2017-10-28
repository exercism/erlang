-module(tgs).

-export([
    module/1
]).

module(Name) when is_atom(Name) ->
    do_module(erl_syntax:abstract(Name));
module(Name) when is_binary(Name) ->
    module(binary_to_list(Name));
module(Name) when is_list(Name) ->
    do_module(erl_syntax:atom(Name)).

do_module(NameAbstract) ->
    erl_syntax:attribute(
        erl_syntax:text("module"), [
            NameAbstract]).
