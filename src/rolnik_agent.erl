-module(rolnik_agent).

-behaviour(gen_server).

%% API
-export([start_link/1]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-define(SERVER, ?MODULE).
-define(TIMEOUT, 1000).

-record(state, {id, values}).

start_link(ID) ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [ID], []).

init([ID]) ->
    InitValues = #{version => 1,
                   temperature => 0},
    {ok, #state{ id = ID, values = InitValues}, ?TIMEOUT}.

handle_call(poll, From, State) ->
    Values = State#state.values,
    gen_server:reply(From, Values#{ timestamp => erlang:now()}),
    {noreply, State, ?TIMEOUT}.

handle_cast(_Msg, State) ->
    {noreply, State, ?TIMEOUT}.

handle_info(timeout, State) ->
    T = rolnik_device:read_temperature_onewire(State#state.id),
    NewValues = #{ version => 1,
                   temperature => T},
    {noreply, State#state{values = NewValues}, ?TIMEOUT}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
        {ok, State}.

