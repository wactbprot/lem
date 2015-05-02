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
    case erlang:decode_packet(httph, Rest, []) of
        {ok, H, R} -> 
            ?DEBUG(H),
            ?DEBUG(R),
            resolve_rest(R,Acc)
    end.
