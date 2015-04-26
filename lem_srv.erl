%%%-------------------------------------------------------------------
%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 26 Apr 2015 by Wact B. Prot <wact@hiob>
%%%-------------------------------------------------------------------
-module(lem_srv).

-export([start/1]).

-ifndef(PRINT).
-define(PRINT(Var), io:format("debug: ~p line:~p var: ~p~n~n ~p~n~n", [?MODULE, ?LINE, ??Var, Var])).
-endif.

start(Port) ->
    spawn(fun () -> {ok, Sock} = gen_tcp:listen(Port, [{active, false}]), 
                    loop(Sock) end).

loop(Sock) ->
    {ok, Conn} = gen_tcp:accept(Sock),
    Handler = spawn(fun () -> handle(Conn, Sock) end),
    gen_tcp:controlling_process(Conn, Handler),
    loop(Sock).

handle(Conn, Sock) ->
    {ok, Port} = inet:port(Sock),
    ?PRINT(Port),
    gen_tcp:send(Conn, response("Yo!\n")),
    gen_tcp:close(Conn).

response(Str) ->
    B = iolist_to_binary(Str),
    iolist_to_binary(
      io_lib:fwrite(
         "HTTP/1.0 200 OK\nContent-Type: text/html\nContent-Length: ~p\n\n~s",
         [size(B), B])).

