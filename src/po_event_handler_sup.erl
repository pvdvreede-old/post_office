-module(po_event_handler_sup).

-behaviour(supervisor).

-export([start_link/1, init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
    
init([]) ->
    {ok, {{simple_one_for_one, 0,1}, [
        {po_event_handler, {po_event_handler, start_link, []}},
        permanent,
        2000,
        worker,
        [po_event_handler]
    ]}}
    
start_child(#sender{} = Sender) ->
    supervisor:start_child(?SERVER, [Sender]).