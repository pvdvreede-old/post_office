%% Sender record
-record(sender, {name,
                 address,
                 type,
                 options = []}).