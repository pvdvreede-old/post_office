%% Record for a filter
-record(filter, {name,
                 namespace,
                 value,
                 join}).

%% Record for the message
-record(message, {filters = [],
                  body,
                  content_type = "text/plain"}).