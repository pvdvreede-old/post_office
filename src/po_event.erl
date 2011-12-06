-module(po_event).

-include("message.hrl").

-export([start_link/0,
         add_handler/2,
         delete_handler/2,
         publish_ow/1,
         publish_tw/1]).
         
-define(SERVER, ?MODULE).

start_link() ->
    error_logger:info_msg("Starting post office event manager."),
    gen_event:start_link({local, ?SERVER}).
    
add_handler(Handler, Args) ->
    error_logger:info_msg("Adding event handler with handler: ~p and arguments: ~p.~n", [Handler, Args]),
    gen_event:add_sup_handler(?SERVER, Handler, Args).
    
delete_handler(Handler, Args) ->
    gen_event:delete_handler(?SERVER, Handler, Args).
    
publish_ow(#message{} = Message) ->
    gen_event:notify(?SERVER, {publish, Message}).
    
publish_tw(#message{} = Message) ->
    gen_event:call(?SERVER, {publish, Message}).