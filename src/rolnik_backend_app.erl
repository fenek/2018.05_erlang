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
    rolnik_backend_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================