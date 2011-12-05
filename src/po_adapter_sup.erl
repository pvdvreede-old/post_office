-module(po_adapter_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
    
init([]) ->
    HttpAdapter = {po_adapter_http, {po_adapter_http, start_link, []}, permanent, 2000, worker, [po_adapter_http]},
    Children = [HttpAdapter],
    RestartStrategy = {one_for_one, 4, 3600},
    error_logger:info_msg("Starting adapter supervisor.~n"),
    {ok, {RestartStrategy, Children}}.