# hint_1

The Basics of Process Communication

In Erlang, every communication between processes happens through message passing. Think of your ships not as objects with methods, but as independent beings that can only talk to each other by sending messages.

When a ship goes down, it doesn't call a function - it simply stops receiving messages. How would other ships know it's gone? You'll need to establish connections between your processes that can detect when one disappears.

Remember: in space, no one can hear you scream - unless you've set up the right message handling!
