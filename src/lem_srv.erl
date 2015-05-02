%%%-------------------------------------------------------------------
%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 26 Apr 2015 by Wact B. Prot <wact@hiob>
%%%-------------------------------------------------------------------
-module(lem_srv).
-include_lib("../include/lem.hrl").
-export([start/1]).

start(Port) ->
    spawn(fun () -> {ok, Sock} = gen_tcp:listen(Port, [binary,{active, false}]), 
                    loop(Sock) end).

loop(Sock) ->
    {ok, Conn} = gen_tcp:accept(Sock),
    Handler = spawn(fun () -> handle(Conn) end),
    gen_tcp:controlling_process(Conn, Handler),
    loop(Sock).

handle(Conn) ->
    {ok, Pack} = gen_tcp:recv(Conn, 0),
    lem_disp:dispatch(Pack),
    gen_tcp:send(Conn, response("{\"ok\":true}\n")),
    gen_tcp:close(Conn).

response(Str) ->
    B = iolist_to_binary(Str),
    iolist_to_binary(
      io_lib:fwrite(
         "HTTP/1.0 200 OK\nContent-Type: text/html\nContent-Length: ~p\n\n~s",
         [size(B), B])).

