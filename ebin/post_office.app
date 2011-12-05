{application, post_office,[
    {description, "Publish subscribe messaging engine."},
    {vsn, "0.1.0"},
    {modules, [
        po_app,
        po_sup,
        po_event,
        po_event_handler
    ]},
    {registered, [po_sup]},
    {applications, [kernel, stdlib]},
    {mod, {po_app, []}}
]}.