{application, post_office,[
    {description, "Publish subscribe messaging engine."},
    {vsn, "0.1.0"},
    {modules, [
        po_app,
        po_sup,
        po_store,
        po_event,
        po_event_handler,
        po_event_tracking,
        po_adapter_sup,
        po_adapter_http
    ]},
    {registered, [po_sup]},
    {applications, [kernel, stdlib, mnesia]},
    {mod, {po_app, []}}
]}.