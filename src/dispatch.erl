%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created :  2 May 2015 by Wact B. Prot <wact@hiob>

-module(dispatch).
-include_lib("../include/lem.hrl").
-export([resolve/1]).

resolve(Pack) ->
    {ok, Hhead, Rest} = erlang:decode_packet(http, Pack, []),
    {http_request, Method, {abs_path, Path},_} = Hhead,
    case Method of
        'GET' ->
            ?DEBUG(Method),
            {ok, "something from ets"};
        'POST' ->
            Result = resolve_rest(Rest, []),
            case Result of
                {ok, List} ->
                    PathL  = get_path(Path),
                    ValueL = get_value(List),
                    store:generate(PathL, ValueL);
                {error, Reason} ->
                    {error, Reason}
            end,
            {ok, "something from ets"};
        'PUT' ->
            ?DEBUG(Method),
            resolve_rest(Rest, []);
        'DELETE' ->
            ?DEBUG(Method),
            {ok, "something from ets"};
        _Any ->
            {error, 'Method not implemented'}
    end.

resolve_rest(Rest, Acc) ->
    case erlang:decode_packet(httph, Rest, []) of
        {ok, http_eoh, Body} ->
            {ok,[{body, Body}  |Acc]};
        {ok, {http_header, _, Key, _, Value}, R} -> 
            resolve_rest(R, [{head_kv, Key, Value} | Acc]);
        {error, Reason} ->
            {error, Reason}
    end.

get_path(Path) ->
    string:tokens(Path, ?PATHSEP).


get_value(ResultL) ->
    [Body || {body, Body} <- ResultL].
