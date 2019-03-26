-module(rolnik_backend_api_stats).

-compile([export_all]).

%% Cowboy callbacks
-export([init/2]).

%%
%% Cowboy callbacks
%%

init(Req0, State) ->
    Headers = #{<<"content-type">> => <<"text/json">>,
                <<"access-control-allow-origin">> => <<"*">>},
    Req = cowboy_req:reply(200, Headers,
                           %hardcoded_development_stub(),
                           jsone_stub(),
                           Req0),
    {ok, Req, State}.

%%
%% Internal
%%

%hardcoded_development_stub() ->
%    <<"{"
%      "  \"temp\": [", (device_temp())/bytes, "],"
%      "  \"humidity\": [", (device_humidity())/bytes, "]"
%      "}">>.

jsone_stub() ->
    jsone:encode(#{temp => [device_temp(<<"device1">>)],
                   humidity => [device_humidity(<<"device1">>)]}).

device_temp(DeviceName) ->
    #{devname => DeviceName,
      data => [
               #{tstamp => <<"2014-04-07T13:58:11.104Z">>,
                 value => 10},
               #{tstamp => <<"2014-04-07T13:58:16.104Z">>,
                 value => 20},
               #{tstamp => <<"2014-04-07T13:58:21.104Z">>,
                 value => 15}
              ]}.

device_humidity(DeviceName) ->
    #{devname => DeviceName,
      data => [
               #{tstamp => <<"2014-04-07T13:58:11.104Z">>,
                 value => 61},
               #{tstamp => <<"2014-04-07T13:58:16.104Z">>,
                 value => 59},
               #{tstamp => <<"2014-04-07T13:58:21.104Z">>,
                 value => 57}
              ]}.

%% Parsing ISO 8601 dates in JavaScript:
%%   var d = new Date("2014-04-07T13:58:10.104Z");
%%   console.log(d.toString());
