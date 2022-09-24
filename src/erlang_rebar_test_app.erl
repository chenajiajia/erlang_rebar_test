%%%-------------------------------------------------------------------
%% @doc erlang_rebar_test public API
%% @end
%%%-------------------------------------------------------------------

-module(erlang_rebar_test_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    erlang_rebar_test_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
