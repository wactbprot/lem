%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created :  2 May 2015 by Wact B. Prot <wact@hiob>

-module(disp).
-include_lib("../include/lem.hrl").
-export([dispatch/1]).

dispatch(Pack) ->
    {ok, Hhead, Rest} = erlang:decode_packet(http, Pack, []),
    {http_request, Methode, {abs_path, Path},_} = Hhead,
    
    {ok, Htail} = resolve_rest(Rest, [{methode, Methode}
                                     ,{path, Path}
                                     ]).

resolve_rest(Rest, Acc) ->
    case erlang:decode_packet(httph, Rest, []) of
        {ok, http_eoh, Body} ->
            {ok,[{body,Body}|Acc]};
        
        {ok, {http_header, _, Key, _, Value}, R} -> 
            resolve_rest(R, [{head_kv, Key, Value} | Acc])
    end.
