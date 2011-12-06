-module(po_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
    
init([]) ->
    PostOffice = {po_event, {po_event, start_link, []}, permanent, 2000, worker, [po_event]},
    Tracking = {po_event_tracking, {po_event_tracking, start_link, []}, permanent, 2000, worker, [po_event_tracking]},
    AdapterSup = {po_adapter_sup, {po_adapter_sup, start_link, []}, permanent, 2000, supervisor, [po_adapter_sup]},
    
    Children = [PostOffice, AdapterSup, Tracking],
    RestartStrategy = {one_for_one, 4, 3600},
    error_logger:info_msg("Starting head supervisor.~n"),
    {ok, {RestartStrategy, Children}}.