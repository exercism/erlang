-module(tgs).

-export([
    module/1,
    export/1,
    include/1,
    define/2,
    parens/1,
    call_fun/2,
    atom/1,
    simple_fun/2,
    raw/1
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

export(Exports) when is_list(Exports) ->
    erl_syntax:attribute(
        erl_syntax:text("export"), [
            erl_syntax:list(lists:map(fun fun_tuple_to_text/1, Exports))]).

fun_tuple_to_text({Name, Args}) when (is_list(Name) orelse is_binary(Name)) andalso is_list(Args) ->
    Text = io_lib:format("~s/~B", [Name, length(Args)]),
    erl_syntax:text(Text).

include(File) when is_list(File) ->
    erl_syntax:attribute(
        erl_syntax:text("include"), [
            erl_syntax:abstract(File)]).

define(Name, Substitution) when is_list(Name) ->
    erl_syntax:attribute(
        erl_syntax:text("define"), [
            erl_syntax:text(Name),
            Substitution]).

parens(Tree) ->
    erl_syntax:parentheses(Tree).

call_fun(Name, Args) when is_list(Name) ->
    erl_syntax:application(
        erl_syntax:text(Name), Args).

atom(Name) when is_list(Name); is_atom(Name) ->
    erl_syntax:atom(Name);
atom(Name) when is_binary(Name) ->
    atom(binary_to_list(Name)).

simple_fun(Name, Body) ->
    erl_syntax:function(
        atom(Name), [erl_syntax:clause(none, Body)]).

raw(Value) ->
    erl_syntax:text(Value).
