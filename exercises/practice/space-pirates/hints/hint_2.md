# hint_2

Monitoring Your Fleet

To build a robust fleet communication system, you'll need to use these key Erlang concepts:

link/1 - Creates a bidirectional connection between processes
process_flag(trap_exit, true) - Makes a process receive notifications when linked processes die
spawn_link/1 - Creates a new process that's automatically linked to its parent

When setting up your command ship, make sure it can "trap exits" so it receives notifications when ships are destroyed.

Your message pattern matching should look for {'EXIT', Pid, Reason} messages that indicate a ship has gone down.

For secure communications, remember that make_ref/0 creates a unique reference that can't be guessed - perfect for authenticating messages between ships!
