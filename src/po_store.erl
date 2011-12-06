-module(po_store).

-export([init/0,
         create_sender/3,
         toggle_sender/2,
         get_active_senders/0]).

-include("management.hrl").
-include("message.hrl").

-include_lib("stdlib/include/qlc.hrl").

init() ->
    mnesia:stop(),
    mnesia:start(),
    create_tables().
    
create_sender(Name, Filters, Address) ->
    mnesia:dirty_write(#sender{name = Name, address = Address, filters = Filters, enabled = true}).
    
toggle_sender(Name, Toggle) ->
    ok.
    
get_active_senders() ->
    mnesia:transaction(
        fun() ->
            Table = mnesia:table(sender),
            QueryHandle = qlc:q([S || S <- Table, S#sender.enabled =:= true]),
            qlc:eval(QueryHandle)
         end
         ).

%% private functions
create_tables() ->
    mnesia:create_schema([node()]),
    mnesia:create_table(sender, [
        %{index, [name]},
        {attributes, record_info(fields, sender)}
    ]).
    