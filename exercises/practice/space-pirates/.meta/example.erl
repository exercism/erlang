-module(example).

-export([start_command_ship/0, spawn_pirate_ship/2, ship_exists/2, create_mission_ref/0,
         send_message/3, message_received/2, get_last_message/2, enable_distress_beacon/1,
         link_ships/2, destroy_ship/2, get_last_distress_signal/1, enable_auto_replacement/2,
         count_ships_by_name/2, get_ship_by_name/2, send_distress_signal/4,
         get_distress_signal_by_ref/2, create_auth_ref/2, send_authenticated_message/4,
         authenticate_message/2]).

%% Internal ship state record
-record(ship_state,
        {name,
         messages = [],
         received_refs = [],
         auth_refs = [],
         trap_exit = false,
         distress_signals = [],
         ships_registry = [],
         auto_replace = false,
         last_distress = undefined}).

%% Start a command ship process that can act as a supervisor
start_command_ship() ->
  spawn_link(fun() -> command_ship_loop(#ship_state{name = "Command"}) end).

%% Spawn a new pirate ship process with the given name
spawn_pirate_ship(CommandShip, Name) ->
  PirateShip = spawn(fun() -> pirate_ship_loop(#ship_state{name = Name}) end),
  CommandShip ! {register_ship, Name, PirateShip},
  PirateShip.

%% Check if a ship with the given name exists in the command ship's registry
ship_exists(CommandShip, Name) ->
  CommandShip ! {ship_exists, Name, self()},
  receive
    {ship_exists_response, Result} ->
      Result
  after 1000 ->
    false
  end.

%% Create a unique mission reference
create_mission_ref() ->
  make_ref().

%% Send a message from one ship to another
send_message(FromShip, ToShip, Message) ->
  ToShip ! {message, FromShip, Message},
  ok.

%% Check if a message with the given reference was received
message_received(Ship, Ref) ->
  Ship ! {check_received, Ref, self()},
  receive
    {received_check, Result} ->
      Result
  after 1000 ->
    false
  end.

%% Retrieve the last message with the given reference
get_last_message(Ship, Ref) ->
  Ship ! {get_message, Ref, self()},
  receive
    {message_response, Message} ->
      Message
  after 1000 ->
    undefined
  end.

%% Enable the command ship to trap exit signals from linked ships
enable_distress_beacon(CommandShip) ->
  CommandShip ! {enable_distress_beacon, self()},
  receive
    {distress_beacon_enabled, true} ->
      ok
  after 1000 ->
    {error, timeout}
  end.

%% Link two ship processes
link_ships(ShipA, ShipB) ->
  ShipA ! {link_to, ShipB},
  ShipB ! {link_to, ShipA},
  timer:sleep(10), % Small delay to ensure linking
  ok.

%% Destroy a ship with a reason
destroy_ship(Ship, Reason) ->
  exit(Ship, {ship_destroyed, Reason}),
  ok.

%% Get the last distress signal received by the command ship
get_last_distress_signal(CommandShip) ->
  CommandShip ! {get_last_distress, self()},
  receive
    {last_distress, Signal} ->
      Signal
  after 1000 ->
    undefined
  end.

%% Enable or disable automatic replacement of destroyed ships
enable_auto_replacement(CommandShip, Enable) ->
  CommandShip ! {auto_replace, Enable},
  ok.

%% Count the number of ships with a specific name
count_ships_by_name(CommandShip, Name) ->
  CommandShip ! {count_ships, Name, self()},
  receive
    {ship_count, Count} ->
      Count
  after 1000 ->
    0
  end.

%% Get the process ID of a ship by its name
get_ship_by_name(CommandShip, Name) ->
  CommandShip ! {get_ship, Name, self()},
  receive
    {ship_pid, Pid} ->
      Pid
  after 1000 ->
    undefined
  end.

%% Send a distress signal with a reference from a ship to the command ship
send_distress_signal(Ship, CommandShip, Ref, Message) ->
  CommandShip ! {distress_signal, Ship, Ref, Message},
  ok.

%% Get a specific distress signal by its reference
get_distress_signal_by_ref(CommandShip, Ref) ->
  CommandShip ! {get_distress_ref, Ref, self()},
  receive
    {distress_ref_response, Signal} ->
      Signal
  after 1000 ->
    undefined
  end.

%% Create an authentication reference for secure communication between ships
create_auth_ref(FromShip, ToShip) ->
  Ref = make_ref(),
  FromShip ! {register_auth_ref, Ref},
  ToShip ! {register_auth_ref, Ref},
  Ref.

%% Send an authenticated message between ships
send_authenticated_message(FromShip, ToShip, AuthRef, Message) ->
  ToShip ! {auth_message, FromShip, AuthRef, Message},
  ok.

%% Verify if a message has a valid authentication reference
authenticate_message(Ship, AuthRef) ->
  Ship ! {auth_check, AuthRef, self()},
  receive
    {auth_result, Result} ->
      Result
  after 1000 ->
    false
  end.

%% Main loop for the command ship process
command_ship_loop(State) ->
  receive
    {enable_distress_beacon, From} ->
      process_flag(trap_exit, true),
      From ! {distress_beacon_enabled, true},
      command_ship_loop(State#ship_state{trap_exit = true});
    {register_ship, Name, Pid} ->
      NewRegistry = [{Name, Pid} | State#ship_state.ships_registry],
      command_ship_loop(State#ship_state{ships_registry = NewRegistry});
    {ship_exists, Name, From} ->
      Exists = lists:keymember(Name, 1, State#ship_state.ships_registry),
      From ! {ship_exists_response, Exists},
      command_ship_loop(State);
    {link_to, Ship} ->
      link(Ship),
      command_ship_loop(State);
    {auto_replace, Enable} ->
      command_ship_loop(State#ship_state{auto_replace = Enable});
    {get_last_distress, From} ->
      From ! {last_distress, State#ship_state.last_distress},
      command_ship_loop(State);
    {count_ships, Name, From} ->
      Count = length([X || {N, _} = X <- State#ship_state.ships_registry, N =:= Name]),
      From ! {ship_count, Count},
      command_ship_loop(State);
    {get_ship, Name, From} ->
      case lists:keyfind(Name, 1, State#ship_state.ships_registry) of
        {Name, Pid} ->
          From ! {ship_pid, Pid};
        false ->
          From ! {ship_pid, undefined}
      end,
      command_ship_loop(State);
    {distress_signal, Ship, Ref, Message} ->
      case lists:keyfind(Ship, 2, State#ship_state.ships_registry) of
        {Name, Ship} ->
          DistressSignals = [{distress, Name, Message, Ref} | State#ship_state.distress_signals],
          command_ship_loop(State#ship_state{distress_signals = DistressSignals,
                                             last_distress = {distress, Name, Message, Ref}});
        false ->
          command_ship_loop(State)
      end;
    {get_distress_ref, Ref, From} ->
      Signal = lists:keyfind(Ref, 4, State#ship_state.distress_signals),
      From ! {distress_ref_response, Signal},
      command_ship_loop(State);
    {'EXIT', Pid, {ship_destroyed, Reason}} ->
      case lists:keyfind(Pid, 2, State#ship_state.ships_registry) of
        {Name, Pid} ->
          NewState =
            State#ship_state{last_distress = {ship_lost, Name, Reason},
                             ships_registry =
                               lists:keydelete(Pid, 2, State#ship_state.ships_registry)},

          % Auto-replace if enabled
          FinalState =
            case NewState#ship_state.auto_replace of
              true ->
                NewShip = spawn(fun() -> pirate_ship_loop(#ship_state{name = Name}) end),
                NewRegistry = [{Name, NewShip} | NewState#ship_state.ships_registry],
                link(NewShip),
                NewState#ship_state{ships_registry = NewRegistry};
              false ->
                NewState
            end,

          command_ship_loop(FinalState);
        false ->
          command_ship_loop(State)
      end;
    {register_auth_ref, Ref} ->
      AuthRefs = [Ref | State#ship_state.auth_refs],
      command_ship_loop(State#ship_state{auth_refs = AuthRefs});
    {auth_check, Ref, From} ->
      Result = lists:member(Ref, State#ship_state.auth_refs),
      From ! {auth_result, Result},
      command_ship_loop(State);
    _Other ->
      command_ship_loop(State)
  end.

%% Main loop for pirate ship processes
pirate_ship_loop(State) ->
  receive
    {message, _FromShip, {Ref, Content}} ->
      NewRefs = [Ref | State#ship_state.received_refs],
      NewMessages = [{Ref, Content} | State#ship_state.messages],
      pirate_ship_loop(State#ship_state{received_refs = NewRefs, messages = NewMessages});
    {check_received, Ref, From} ->
      Result = lists:member(Ref, State#ship_state.received_refs),
      From ! {received_check, Result},
      pirate_ship_loop(State);
    {get_message, Ref, From} ->
      Message =
        case lists:keyfind(Ref, 1, State#ship_state.messages) of
          {Ref, Content} ->
            Content;
          false ->
            undefined
        end,
      From ! {message_response, Message},
      pirate_ship_loop(State);
    {link_to, Ship} ->
      link(Ship),
      pirate_ship_loop(State);
    {register_auth_ref, Ref} ->
      AuthRefs = [Ref | State#ship_state.auth_refs],
      pirate_ship_loop(State#ship_state{auth_refs = AuthRefs});
    {auth_message, _FromShip, AuthRef, Message} ->
      % Store the auth message if we have the ref registered
      case lists:member(AuthRef, State#ship_state.auth_refs) of
        true ->
          NewMessages = [{AuthRef, Message} | State#ship_state.messages],
          pirate_ship_loop(State#ship_state{messages = NewMessages});
        false ->
          pirate_ship_loop(State)
      end;
    {auth_check, Ref, From} ->
      Result = lists:member(Ref, State#ship_state.auth_refs),
      From ! {auth_result, Result},
      pirate_ship_loop(State);
    _Other ->
      pirate_ship_loop(State)
  end.
