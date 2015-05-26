%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 16 May 2015 by Wact B. Prot <wact@hiob>

-module(store).
-include_lib("../include/lem.hrl").
-export([ini/1, insert/2, get/1]).

ini(Path) ->
    [H|_] = Path,
    Name = list_to_atom(H),
    register(Name, spawn(fun() ->
                               Table =  ets:new(Name, [bag, public, named_table]),
                                loop(Table)
                        end)).

insert(Path, Value) ->
    [H|T]   = Path,
    Name    = list_to_atom(H),    
    Atm     = gen_lvl_atm(length(T) - 1),
    Chain   = gen_chain(Atm, T),
    Name ! {insert,{row,list_to_tuple([{value,Value}|Chain])}}.

get(Path) ->
    [H|_]   = Path,
    Name    = list_to_atom(H),    
    Name ! {lookup,{tag, level_a}}.



loop(Table) ->
    receive
        {insert, {row, Row}} -> 
            ets:insert(Table, Row),
            loop(Table);
        {lookup, {tag, Tag}} ->
            ?DEBUG( ets:tab2list(Table)),
            loop(Table)
    end.

%ctrl(Path, Value) ->

%   
%     ?DEBUG(ets:insert(Name,list_to_tuple([{value,Value}|Chain]))).
%%    ?DEBUG(ets:insert(Name,list_to_tuple(Chain))).
%    ?DEBUG(ets:info(mpid)).
%

gen_lvl_atm(N) ->
    [list_to_atom("level_" ++ [I]) || I <- lists:seq(97, 97 + N)]. 

gen_chain(L,T) -> 
    lists:zip(L,T).
