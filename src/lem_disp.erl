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
    {ok, Header, Remain} = erlang:decode_packet(http,Pack, []),
    ?DEBUG(Header),
    ?DEBUG(Remain).

