# Instructions

Your task is to implement a reliable communication system for Captain Nova's pirate fleet using Erlang's process model. The system needs to handle ship-to-ship communication, distress signals, authentication, and automatic ship replacement when one is destroyed.
Core Requirements

Command Ship - Implement a central command ship process that acts as a supervisor for the fleet
Pirate Ships - Create ship processes that can send and receive authenticated messages
Distress Beacon - Enable command ships to trap exit signals when pirate ships are destroyed
Message Authentication - Use Erlang references to create secure communications between ships
Ship Registry - Maintain a registry of active ships in the fleet
Auto-Replacement - When a ship is destroyed, automatically spawn a replacement

Concepts You'll Be Using

Process Creation: Using spawn/1 and spawn_link/1 to create processes
Message Passing: Sending messages between processes using the ! operator
Process Linking: Using link/1 to connect processes
Exit Signal Handling: Using process_flag(trap_exit, true) to catch process termination
References: Using make_ref/0 to create unique identifiers for messages
Process Registration: Maintaining a registry of processes

## Your Task

Implement the functions in the space_pirates.erl module to create a robust, fault-tolerant messaging system that can:

Start a command ship that can monitor other ships
Spawn pirate ships that can communicate with each other
Enable the distress beacon to trap exit signals
Create unique references for mission authentication
Send authenticated messages between ships
Handle ship destruction and automatic replacement

Remember, in deep space, there's no room for failure. Ships get destroyed, communications get intercepted, and the Empire is always watching. Your system needs to be reliable, secure, and resilient.
Good luck, Communication Officer. The fleet's success depends on you.
