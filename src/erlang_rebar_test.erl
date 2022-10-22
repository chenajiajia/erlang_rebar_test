%%%-------------------------------------------------------------------
%%% @author chenjinjia
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. 9月 2022 22:34
%%%-------------------------------------------------------------------
-module(erlang_rebar_test).
-author("chenjinjia").

%% API
-export([start/0]).

start() ->
  Handle = bitcask:open("erlang_rebar_test_db", [read_write]),
  N = fetch(Handle),
  store(Handle, N+1),
  io:format("test has been run ~p times~n", [N]),
  bitcask:close(Handle),
  init:stop().

store(Handle, N) ->
  bitcask:put(Handle, <<"test_executions">>, term_to_binary(N)).

fetch(Handle) ->
  case bitcask:get(Handle, <<"test_executions">>) of
    not_found -> 1;
    {ok, Bin} -> binary_to_term(Bin)
  end.