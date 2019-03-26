-module(rolnik_backend_api_stats).

%% cowboy callbacks
-export([init/2]).

%%
%% cowboy callbacks
%%
init(Req0, State) ->
    Headers = #{<<"content-type">> => <<"text/json">>,
                <<"access-control-allow-origin">> => <<"*">>},
    Req = cowboy_req:reply(200, Headers,
                           hardcoded_development_stub(),
                           Req0),
    {ok, Req, State}.

%%
%% Internal
%%

hardcoded_development_stub() ->
    <<"{"
      "  \"temp\": [", (device_temp())/bytes, "],"
      "  \"humidity\": [", (device_humidity())/bytes, "]"
      "}">>.

device_temp() -> <<"{ \"devname\": \"device1\","
                   "  \"data\": [ {\"tstamp\": \"2014-04-07T13:58:10.104Z\","
                   "           \"value\": 36.6}] }">>.

device_humidity() -> <<"{ \"devname\": \"device1\","
                       "  \"data\": [ {\"tstamp\": \"2014-04-07T13:58:10.104Z\","
                       "           \"value\": 40}] }">>.

%% Parsing ISO 8601 dates in JavaScript:
%%   var d = new Date("2014-04-07T13:58:10.104Z");
%%   console.log(d.toString());
