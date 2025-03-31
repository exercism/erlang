# hint_3

Implementation Blueprint

Here's a detailed structure for your solution:

```erlang

%% Command ship state management
-record(command_state, {
  ships = #{},         % Map of ship name to Pid
  trap_exit = false,   % Is the ship currently trapping exits?
  distress_log = [],   % List of received distress signals
  auth_refs = sets:new() % Set of valid authentication references
}).

%% Pirate ship state management
-record(ship_state, {
  name,
  messages = #{},      % Map of Ref to message content
  auth_refs = sets:new() % Set of valid authentication refs
}).

%% Handle the 'EXIT' signal in your command ship loop
command_loop(State) ->
  receive
    {'EXIT', Pid, {ship_destroyed, Reason}} ->
      %% 1. Find the ship's name from its Pid
      ShipName = maps:fold(fun(Name, P, Acc) ->
                            if P =:= Pid -> Name; true -> Acc end
                          end, undefined, State#command_state.ships),

      %% 2. Remove the ship from the registry
      NewShips = maps:remove(ShipName, State#command_state.ships),
      
      %% 3. Log the distress
      NewLog = [{ShipName, Reason, erlang:timestamp()} | State#command_state.distress_log],
      
      %% 4. Spawn replacement if auto-replace is enabled
      FinalShips = case State#command_state.auto_replace of
                     true -> 
                       NewShip = spawn_link(fun() -> ship_loop(#ship_state{name=ShipName}) end),
                       maps:put(ShipName, NewShip, NewShips);
                     false -> 
                       NewShips
                   end,
                   
      command_loop(State#command_state{ships=FinalShips, distress_log=NewLog});
    
    %% Handle other messages...
  end.

```

For secure message authentication:

Create references with make_ref()
Register them with both sender and receiver
Verify that incoming messages contain a registered reference
Remember that pirates can't be trusted - always verify before accepting a message!

The command ship should maintain the fleet registry and be the central point for monitoring ship status.
