-record(tgen, {
    module :: atom(),
    name   :: string() | binary(),
    path   :: file:filename(),
    dest   :: file:filename()
}).