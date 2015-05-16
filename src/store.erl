%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created : 16 May 2015 by Wact B. Prot <wact@hiob>

-module(store).
-include_lib("../include/lem.hrl").
-export([generate/2]).

generate(Path, Value) ->
    ?DEBUG(Path),
    ?DEBUG(Value).
