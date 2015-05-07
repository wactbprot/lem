%%%-------------------------------------------------------------------
%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 24 Apr 2015 by Wact B. Prot <wact@hiob>
%%%-------------------------------------------------------------------
-module(db).
-compile(export_all).
-include_lib("../include/lem.hrl").

-record(bucket,{path, value, atime}).

init() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(bucket,
                        [ {disc_copies, [node()] },
                          {attributes,      
                           record_info(fields,bucket)} ]).

insert(Path, Value) ->
    {Me,Se,Mi} = erlang:now(),
    F = fun() ->
                mnesia:write(
                  #bucket{ path = Path,
                           value = Value, 
                           atime= Me*1000000 + Se*1000 + Mi}
                 )
        end,
    mnesia:transaction(F).

select(Path) ->
    F = fun() ->
                mnesia:read(bucket, Path)
        end,
    {atomic, [Row]}=mnesia:transaction(F),
    io:format(" ~p ~p ~n ", [Row#bucket.value, Row#bucket.atime] ).
