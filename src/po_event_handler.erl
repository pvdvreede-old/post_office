-module(po_event_handler).

-include("management.hrl").
-include("message.hrl").

-behaviour(gen_event).

%% API
-exports([start_link/1,
          init/1,
          handle_event/2,
          handle_call/2,
          handle_info/2,
          code_change/3,
          terminate/2]).
          
%% Inbuilt functions
-export([add_handler/0,
         delete_handler/0]).

start_link($sender{} = Sender) ->
    gen_event:start_link([Sender]).
         
init([#sender{} = State]) ->
    add_handler(),
    {ok, State}.
    
add_handler() ->
    po_event:add_handler(?MODULE, []).
    
delete_handler() ->
    po_event:delete_handler(?MODULE, []).
    
handle_event({publish, #message{} = Message}, Sender) ->
    case match_filter(Message#message.filters, Sender#sender.filters) of
        match -> gone_through;
        nomatch -> nomatch
    end.
    
handle_call({publish, #message{} = Message}, {Sender, Filter}) ->
    ok.
    
handle_info(Msg, State) ->
    {noreply, State}.
    
code_change(_OldVersion, State, _Extra) ->
    {ok, State}.
    
terminate(Reason, State) ->
    ok.

%% Non static API calls
create_sender([]) ->
    ok.

create_sender([Sender | T]) ->
    po_event_handler_sup:start_child(Sender),
    create_sender(T).

%% Interal functions
match_filter(MessageFilters, Filters) ->
    match.
    
send_message(Sender) ->
    ok.