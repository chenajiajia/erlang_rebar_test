%% prototype_server.erl
-module(prototype_server).

-behaviour(gen_server).

%% API
-export([start/1, clone/1]).
-export([get/1, set/2]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

%% Server 启动
start(InitValue) ->
  gen_server:start(?MODULE, InitValue, []).

%% 克隆方法
clone(OtherServer) when is_pid(OtherServer) ->
  gen_server:start(?MODULE, OtherServer, []);
clone(_OtherServer) ->
  {error, <<"It's not a prototype">>}.

%% 方便检验做的辅助接口
get(ServerPid) when is_pid(ServerPid) ->
  gen_server:call(ServerPid, {get}).
set(ServerPid, Value) when is_pid(ServerPid) andalso is_integer(Value) ->
  gen_server:call(ServerPid, {set, Value }).


init(OtherServer) when is_pid(OtherServer) ->
  %% 克隆核心数据，这里应根据需要实现全部克隆或部分克隆
  CloneValue = gen_server:call(OtherServer, {get}),
  {ok, #{test_value => CloneValue}};
init(InitValue) ->
  {ok, #{test_value => InitValue}}.

handle_call({get}, _From, State) ->
  {reply, maps:get(test_value, State), State};
handle_call({set, Value}, _From, State) ->
  {reply, ok, State#{test_value => Value}};
handle_call(_Request, _From, State) ->
  {reply, ok, State}.
x

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.