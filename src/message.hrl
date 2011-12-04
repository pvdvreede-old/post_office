%% Record for a filter
-record(filter, {name,
                 namespace,
                 value,
                 join = and}).

%% Record for the message
-record(message, {filters = [],
                  body,
                  content-type}).