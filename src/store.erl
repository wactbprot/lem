%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 16 May 2015 by Wact B. Prot <wact@hiob>

-module(store).
-include_lib("../include/lem.hrl").
-export([ini/1, insert/2]).

%-module(ets_ex).
%-export([run/0]).
%
%run() ->
%    Parent = self(),
%    spawn(fun() ->
%                  TblName = my_table,
%                  Tbl = ets:new(TblName, [public, named_table]),
%                  Parent ! {ready, self(), TblName},
%                  receive
%                      stop ->
%                          ets:delete(Tbl)
%                  end
%          end),
%    receive
%        {ready, Loop, TblNm} ->
%            ets:insert(TblNm, {"key", "value"}),
%            Lookup = ets:lookup(TblNm, "key"),
%            io:format("lookup returned ~p~n", [Lookup]),
%            Loop ! stop
%    end. 



ini(Path) ->
    [H|T] = Path,
    Name = list_to_atom(H),
    ets:new(Name, [public, named_table]),
    ?DEBUG(ets:info(Name)).

insert(Path, Value) ->
    [H|T] = Path,
    Name = list_to_atom(H),
    Atm     = gen_lvl_atm(length(T) - 1),
    Chain   = gen_chain(Atm, T),
%    ?DEBUG(ets:insert(Name,list_to_tuple([{value,Value}|Chain]))).
%    ?DEBUG(ets:insert(Name,list_to_tuple(Chain))).
    ?DEBUG(ets:info(Name)).

gen_lvl_atm(N) ->
    [list_to_atom("level_" ++ [I]) || I <- lists:seq(97, 97 + N)]. 

gen_chain(L,T) -> 
    lists:zip(L,T).
