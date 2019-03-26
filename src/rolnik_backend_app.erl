%%%-------------------------------------------------------------------
%% @doc rolnik_backend public API
%% @end
%%%-------------------------------------------------------------------

-module(rolnik_backend_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile(routes()),
    {ok, _} = cowboy:start_clear(rolnik_backend_http,
                                 [{port, 8080}],
                                 #{env => #{dispatch => Dispatch}}
                                ),
    rolnik_backend_sup:start_link().

routes() ->
    [
     {'_', [
            {"/device", rolnik_backend_api_device, []},
            {"/stats", rolnik_backend_api_stats, []}
           ]}
    ].

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
