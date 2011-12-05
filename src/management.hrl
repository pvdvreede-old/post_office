%% Sender record
-record(sender, {name,
                 address,
                 type,
                 filters = [],
                 options = []}).