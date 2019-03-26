% @doc rolnik top level supervisor.
% @end
-module(rolnik_sup).

-behavior(supervisor).

-import(rolnik_device, [device_id_onewire/0]).

% API
-export([start_link/0]).

% Callbacks
-export([init/1]).

%--- API -----------------------------------------------------------------------

start_link() -> supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%--- Callbacks -----------------------------------------------------------------

init([]) ->
    timer:sleep(10000),
    IdList = device_id_onewire(),
    Children = [ worker(Id) || Id <- IdList ],
    {ok, { {one_for_all, 0, 1}, Children }}.

worker(Id) ->
    #{id => Id,
      start => {rolnik_agent, start_link, [Id]},
      module => rolnik_agent,
      restart => permanent}.
