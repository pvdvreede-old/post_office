-module(po_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    error_logger:info_msg("Starting Post Office application.~n"),
    case po_sup:start_link() of
        {ok, Pid} -> 
            {ok, Pid};
        Other -> 
            error_logger:error_msg("Could not start application because of ~p.~n", [Other]),
            {error, Other}
    end.
    
stop(_State) ->
    error_logger:info_msg("Stopping Post Office application.~n"),
    ok.