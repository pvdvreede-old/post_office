-module(po_event).

-export([start_link/0,
         add_handler/2,
         delete_handler/2,
         publish_ow/1,
         publish_tw/1]).
         
-define(SERVER, ?MODULE).

start_link() ->
    gen_event:start_link({local, ?SERVER}).
    
add_handler(Handler, Args) ->
    gen_event:add_handler(?SERVER, Handler, Args).
    
delete_handler(Handler, Args) ->
    gen_event:delete_handler(?SERVER, Handler, Args).
    
publish_ow(Message) ->
    gen_event:notify(?SERVER, {publish, Message}).
    
publish_two(Message) ->
    gen_event:call(?SERVER, {publish, Message}).