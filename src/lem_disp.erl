%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created :  2 May 2015 by Wact B. Prot <wact@hiob>

-module(lem_disp).
-include_lib("../include/lem.hrl").
-export([dispatch/1]).

dispatch(Pack) ->
    {ok, Hhead, Rest} = erlang:decode_packet(http, Pack, []),
    {ok, Htail} = resolve_rest(Rest, [Hhead]), 
    ?DEBUG(Htail).

resolve_rest(Rest, Acc) ->
    Res = erlang:decode_packet(httph, Rest, []),
    ?DEBUG(Res),
    case Res of
        {ok,http_eoh,Body} ->
            ?DEBUG(Body),
            {ok, Acc};
        {ok,{http_header,N,Key,_,Value}, R} -> 
            ?DEBUG(N),
            ?DEBUG(Key),
            ?DEBUG(Value),
            resolve_rest(R,Acc)
    end.
