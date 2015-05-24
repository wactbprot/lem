%%%-------------------------------------------------------------------
%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 26 Apr 2015 by Wact B. Prot <wact@hiob>
%%%-------------------------------------------------------------------
-module(srv).
-include_lib("../include/lem.hrl").
-export([start/1]).

start(Port) ->
    {ok, Sock} = gen_tcp:listen(Port, [binary,{active, false}]),
    spawn(fun () -> accept(Sock) end).

accept(Sock) ->
    case gen_tcp:accept(Sock) of
        {ok, Conn} ->
            Handler = spawn(fun () -> request(Conn) end),
            gen_tcp:controlling_process(Conn, Handler),
            accept(Sock);
        {error, Reason} ->
            io:fwrite("Error reason: ~p~n", [Reason])
    end.

request(Conn) ->
    case gen_tcp:recv(Conn, 0) of
        {ok, Pack} -> 
            case dispatch:resolve(Pack) of
                {ok, _Response} ->
                    gen_tcp:send(Conn, response("{\"ok\":true}\n"));
                {error, _Reason} ->
                    gen_tcp:send(Conn, response("{\"error\":true}\n"))
            end
    end,
    gen_tcp:close(Conn).               

response(Str) ->
    B = iolist_to_binary(Str),
    iolist_to_binary(
      io_lib:fwrite(
         "HTTP/1.0 200 OK\nContent-Type: application/json\nContent-Length: ~p\n\n~s",
         [size(B), B])).

