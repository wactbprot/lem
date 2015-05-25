%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 16 May 2015 by Wact B. Prot <wact@hiob>

-module(store).
-include_lib("../include/lem.hrl").
-export([ini/1, insert/2]).
ini(Path) ->
    [H|T] = Path,
    Name = list_to_atom(H),
    register(tbl, spawn(fun() ->
                                ets:new(mpid, [set, public, named_table]),
                                ctrl(mpid)
                        end)).

insert(Path, Value) ->
    tbl ! {insert, {Path, Value}}.

ctrl(TblName) ->
    receive
        {insert, _} -> 
            ?DEBUG(ets:info(TblName))
        end.

%ctrl(Path, Value) ->
%    [H|T] = Path,
%    Name = list_to_atom(H),
%    Atm     = gen_lvl_atm(length(T) - 1),
%    Chain   = gen_chain(Atm, T),
%%    ?DEBUG(ets:insert(Name,list_to_tuple([{value,Value}|Chain]))).
%%    ?DEBUG(ets:insert(Name,list_to_tuple(Chain))).
%    ?DEBUG(ets:info(mpid)).
%
%gen_lvl_atm(N) ->
%    [list_to_atom("level_" ++ [I]) || I <- lists:seq(97, 97 + N)]. 
%
%gen_chain(L,T) -> 
%    lists:zip(L,T).
