-module(space_pirates_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

command_ship_start_test_() ->
    {"Command ship can be started and is a valid process",
     ?_assertMatch(Pid when is_pid(Pid), space_pirates:start_command_ship())}.

spawn_pirate_ship_test_() ->
    {"A pirate ship can be spawned with a name and returns a valid process ID",
     fun() ->
        CommandShip = space_pirates:start_command_ship(),
        PirateShip = space_pirates:spawn_pirate_ship(CommandShip, "Black Pearl"),
        ?assert(is_pid(PirateShip)),
        ?assertEqual(true, space_pirates:ship_exists(CommandShip, "Black Pearl"))
     end}.

create_mission_ref_test_() ->
    {"Mission references are created as unique references",
     fun() ->
        Ref1 = space_pirates:create_mission_ref(),
        Ref2 = space_pirates:create_mission_ref(),
        ?assert(is_reference(Ref1)),
        ?assert(is_reference(Ref2)),
        ?assertNotEqual(Ref1, Ref2)
     end}.

message_sending_test_() ->
    {"Ships can send and receive messages with proper authentication",
     fun() ->
        CommandShip = space_pirates:start_command_ship(),
        ShipA = space_pirates:spawn_pirate_ship(CommandShip, "Stellar Blade"),
        ShipB = space_pirates:spawn_pirate_ship(CommandShip, "Crimson Raider"),
        MissionRef = space_pirates:create_mission_ref(),
        Message = "Coordinates to treasure: Sector 7G",
        ?assertEqual(ok, space_pirates:send_message(ShipA, ShipB, {MissionRef, Message})),
        timer:sleep(50), % Small delay to ensure message delivery
        ?assertEqual(true, space_pirates:message_received(ShipB, MissionRef)),
        ?assertEqual(Message, space_pirates:get_last_message(ShipB, MissionRef))
     end}.

enable_distress_beacon_test_() ->
    {"Command ship can enable distress beacon to trap exit signals",
     fun() ->
        CommandShip = space_pirates:start_command_ship(),
        ?assertEqual(ok, space_pirates:enable_distress_beacon(CommandShip)),
        {status, _, _, StatusInfo} = sys:get_status(CommandShip),
        [_, _, _, _, Lists] = StatusInfo,
        {data, [{"State", StateData}]} = Lists,
        ?assertEqual(true, proplists:get_value(trap_exit, StateData))
     end}.

ship_destruction_test_() ->
    {"When a ship is destroyed, the command ship receives an exit signal",
     fun() ->
        CommandShip = space_pirates:start_command_ship(),
        space_pirates:enable_distress_beacon(CommandShip),
        PirateShip = space_pirates:spawn_pirate_ship(CommandShip, "Doomed Vessel"),
        ?assertEqual(ok, space_pirates:link_ships(CommandShip, PirateShip)),
        ?assertEqual(ok, space_pirates:destroy_ship(PirateShip, "Hit by asteroid")),
        timer:sleep(100), % Give time for exit signal to be processed
        ?assertEqual(
            {ship_lost, "Doomed Vessel", "Hit by asteroid"}, 
            space_pirates:get_last_distress_signal(CommandShip)
        )
     end}.

ship_replacement_test_() ->
    {"Command ship can automatically replace destroyed ships",
     fun() ->
        CommandShip = space_pirates:start_command_ship(),
        space_pirates:enable_distress_beacon(CommandShip),
        space_pirates:enable_auto_replacement(CommandShip, true),
        OriginalShip = space_pirates:spawn_pirate_ship(CommandShip, "Replaceable"),
        space_pirates:link_ships(CommandShip, OriginalShip),
        ?assertEqual(1, space_pirates:count_ships_by_name(CommandShip, "Replaceable")),
        space_pirates:destroy_ship(OriginalShip, "Battle damage"),
        timer:sleep(200), % Give time for replacement to occur
        ?assertEqual(1, space_pirates:count_ships_by_name(CommandShip, "Replaceable")),
        NewShip = space_pirates:get_ship_by_name(CommandShip, "Replaceable"),
        ?assertNotEqual(OriginalShip, NewShip)
     end}.

%% Test distress signal with reference
distress_signal_with_ref_test_() ->
    {"Distress signals include unique references for tracking",
     fun() ->
        CommandShip = space_pirates:start_command_ship(),
        space_pirates:enable_distress_beacon(CommandShip),
        PirateShip = space_pirates:spawn_pirate_ship(CommandShip, "Imperiled"),
        DistressRef = make_ref(),
        ?assertEqual(ok, space_pirates:send_distress_signal(PirateShip, CommandShip, DistressRef, "Under attack")),
        timer:sleep(50), % Allow time for message processing
        ?assertEqual(
            {distress, "Imperiled", "Under attack", DistressRef},
            space_pirates:get_distress_signal_by_ref(CommandShip, DistressRef)
        )
     end}.

message_authentication_test_() ->
    {"Messages between ships must be properly authenticated with references",
     fun() ->
        CommandShip = space_pirates:start_command_ship(),
        ShipA = space_pirates:spawn_pirate_ship(CommandShip, "Sender"),
        ShipB = space_pirates:spawn_pirate_ship(CommandShip, "Receiver"),
        AuthRef = space_pirates:create_auth_ref(ShipA, ShipB),
        Message = "Secret plans",
        ?assertEqual(ok, space_pirates:send_authenticated_message(ShipA, ShipB, AuthRef, Message)),
        timer:sleep(50),
        ?assertEqual(true, space_pirates:authenticate_message(ShipB, AuthRef)),
        FakeRef = make_ref(),
        ?assertEqual(ok, space_pirates:send_authenticated_message(ShipA, ShipB, FakeRef, "Fake message")),
        timer:sleep(50),
        ?assertEqual(false, space_pirates:authenticate_message(ShipB, FakeRef))
     end}.
