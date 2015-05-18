%%% @author Wact B. Prot <wact@hiob>
%%% @copyright (C) 2015, Wact B. Prot
%%% @doc
%%%
%%% @end
%%% Created :  1 May 2015 by Wact B. Prot <wact@hiob>

-define(DEBUG(Var), io:format("debug: ~p line:~p var: ~p~n~n ~p~n~n", [?MODULE, ?LINE, ??Var, Var])).
-define(PATHSEP, "/").

-record(bucket_a, { level_a
                  , value
                  }).
-record(bucket_b, { level_a
                  , level_b
                  , value
                  }).
-record(bucket_c, { level_a
                  , level_b
                  , level_c
                  , value
                  }).
-record(bucket_d, { level_a
                  , level_b
                  , level_c
                  , level_d
                  , value
                  }).
-record(bucket_e, { level_a
                  , level_b
                  , level_c
                  , level_d
                  , level_e
                  , value
                  }).
