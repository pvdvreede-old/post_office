-module(po_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Callbacks
-export([init/0]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
    
init([]) ->
    PostOffice = {po_event, {po_event, start_link, []}, permanent, 2000, worker, [po_event]},
    Children=[PostOffice],
    RestartStrategy = {one_for_one, 4, 3600},
    {ok, {RestartStrategy, Children}}.