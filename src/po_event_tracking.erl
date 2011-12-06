-module(po_event_tracking).

-include("message.hrl").

-export([start_link/0,
         add_handler/2,
         delete_handler/2]).
         
-define(SERVER, ?MODULE).

start_link() ->
    error_logger:info_msg("Starting tracking event manager."),
    gen_event:start_link({local, ?SERVER}).
    
add_handler(Handler, Args) ->
    error_logger:info_msg("Adding tracking handler with handler: ~p and arguments: ~p.~n", [Handler, Args]),
    gen_event:add_sup_handler(?SERVER, Handler, Args).
    
delete_handler(Handler, Args) ->
    gen_event:delete_handler(?SERVER, Handler, Args).
    