# Instructions append

This exercise does require some kind of global state for your
robot. In erlang this can be done in various ways (starting with most
idiomatic one):

1. Use some `gen_*` from OTP
2. Roll your own process and receive messages in a loop and pass the
   state as parameter around.
3. Roll your own process and use the process dictionary.

