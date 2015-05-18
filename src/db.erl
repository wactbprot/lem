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

-export([init/0]).

init() ->
    mnesia:create_schema([node()]),
    mnesia:start().

gen_tbl(N) ->
    case N of
        1 ->
            mnesia:create_table(bucket_a,
                                [ {disc_copies, [node()] },
                                  {attributes,      
                                   record_info(fields, bucket_a)} ]);
        2 ->
            mnesia:create_table(bucket_b,
                                [ {disc_copies, [node()] },
                                  {attributes,      
                                   record_info(fields, bucket_b)} ]);
        3 ->
            mnesia:create_table(bucket_c,
                                [ {disc_copies, [node()] },
                                  {attributes,      
                                   record_info(fields, bucket_c)} ]);
        4 ->
            mnesia:create_table(bucket_d,
                                [ {disc_copies, [node()] },
                                  {attributes,      
                                   record_info(fields, bucket_d)}]);
        5 ->
            mnesia:create_table(bucket_e,
                                [ {disc_copies, [node()] },
                                  {attributes,      
                                   record_info(fields, bucket_e)} ]);
        _ -> 
            {error, "unvalid chain length"}
                
    end.
        
% insert(Path, Value) ->
%     {Me,Se,Mi} = erlang:now(),
%     F = fun() ->
%                 mnesia:write(
%                   #bucket{ path = Path,
%                            value = Value, 
%                            atime= Me*1000000 + Se*1000 + Mi}
%                  )
%         end,
%     mnesia:transaction(F).
% 
% select(Path) ->
%     F = fun() ->
%                 mnesia:read(bucket, Path)
%         end,
%     {atomic, [Row]}=mnesia:transaction(F),
%     io:format(" ~p ~p ~n ", [Row#bucket.value, Row#bucket.atime] ).
