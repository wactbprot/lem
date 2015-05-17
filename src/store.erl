%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 16 May 2015 by Wact B. Prot <wact@hiob>

-module(store).
-include_lib("../include/lem.hrl").
-export([generate/2]).

generate(Path, Value) ->
    [H|T] = Path,
    TableId = list_to_atom(H),
    Atm     = gen_lvl_atm(length(T) - 1),
    Chain   = gen_chain(Atm, T),
    ?DEBUG(T),
    ?DEBUG(Atm),
    ?DEBUG(Chain),
    ?DEBUG(TableId),
    ?DEBUG(Value).


gen_lvl_atm(N) ->
    [list_to_atom("level_" ++ [I]) || I <- lists:seq(97, 97 + N)]. 

gen_chain(L,T) -> 
    lists:zip(L,T).
