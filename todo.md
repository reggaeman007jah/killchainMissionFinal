To do...

============================================================================

Add EH to track blue on blue kills
Decide on suitable punishment

http://www.armaholic.com/forums.php?m=posts&q=33056
source: Pierre MGI

\_index = player addMPEventHandler ["MPKilled", { _this execVM "playerKilled.sqf"; }];

Triggered when the unit is killed. EH can be added on any machine and EH code will trigger globally on every connected client and server.
This EH is clever enough to be triggered globally only once even if added on all clients or a single client that is then disconnected, EH
will still trigger globally only once.

MPKilled
unit: Object - Object the event handler is assigned to
killer: Object - Object that killed the unit
Contains the unit itself in case of collisions
instigator: Object - Person who pulled the trigger
useEffects: Boolean - same as useEffects in setDamage alt syntax

This was used before but does not work:

If !(isServer) exitwith {};

{\_x addMPEventHandler ["MPKilled", {
_dead = _this select 0;
_killer = _this select 1;
if ((side _dead == independent) && (side _killer == west)) then {
systemChat "oh noes - blufor killed a friendly"
};
}];
} foreach allUnits;

============================================================================

taken from init.sqf - what were these for?

execVM "VAMP_initParams\vampInitParams.sqf";

execVM "voiceActivatedArty\VAA_Init.sqf";

execVM "autoPatrolSystem\timeStampSystems\timeGen.sqf";

============================================================================

build arty system as before

============================================================================

why did I nit use this? from init.sqf...
execVM "autoPatrolSystem\reinforcementSystems\bluforRF.sqf";

============================================================================

again from init.sqf - what was this for?
// DECIDE = false; // I think this is the only var i need to declare, as the motion.sqf relys on this.

============================================================================

how to do garbage control better ...

having a basic timer cycle can lead to immersion break
so, maybe at a key point you create a new marker, on the position of the old obj marker - "cleanup"
then set a timer to enable players to leave the area, then do cleanup just in that zone ... better chance that noone will
see the function happen ..

// garbage collection - this needs to be mission-based
// while {true} do {
// sleep 600;
// // systemChat "cleanup";
// { deleteVehicle \_x } forEach allDead;
// };

============================================================================

// SF Manager
//player addAction ["Pick up SF", "autoPatrolSystem\callSF.sqf"];
// player setVariable ["isBusy", 111]; // i.e. not busy and needs a task
// execVM "autoPatrolSystem\checkSF.sqf";
// execVM "autoPatrolSystem\checkRF.sqf";
// execVM "autoPatrolSystem\motion.sqf";
// sleep 0.5;

// AI Behaviour Management
// player addAction ["Change Behaviour to Combat", "Modes\combatMode.sqf"];
// player addAction ["Change Behaviour to Safe", "Modes\safeMode.sqf"];
// player addAction ["Change Behaviour to Stealth", "Modes\stealthMode.sqf"];
// player addAction ["Change Behaviour to Aware", "Modes\awareMode.sqf"];

// heli drops
// player addAction ["Drop Smoke", "heliDrops\dropSmoke.sqf"];
// player addAction ["Drop Flare", "heliDrops\dropFlare.sqf"];
// heli2 addAction ["Drop Smoke", "heliDrops\dropSmoke.sqf"];
// heli2 addAction ["Drop Flare", "heliDrops\dropFlare.sqf"];

// Land Check Test Output
// player addAction ["Test findSafeSpot output", "landCheck\landCheck.sqf"];

# above all taken from initServer.sqf ..?

might be useful:

this addEventHandler ["GetIn", {
params ["_vehicle", "_role", "_unit", "_turret"]; {
\_object = \_unit;
[\_object, ["Greetings!", {hint "Hello!"}]] remoteExec ["addAction"]; systemChat str \_unit;
};
}];

============================================================================

more stuff taken from initServer.sqf:

// initialise Heli Systems
// execVM "autoPatrolSystem\heliSystems\heliSystemsInit.sqf";
// // systemchat "debug --- Heli Systems ACTIVATED";
// sleep 0.5;

// initialise debug UAV
// execVM "autoPatrolSystem\UAV\uav.sqf";
// systemchat "debug --- UAV Systems ACTIVATED";
// sleep 0.5;

// test addAction
// // heliAttack4
// // if (isServer) then
// {
// \_object = heliAttack4;
// [\_object, ["Greetings!", {hint "Hello!"}]] remoteExec ["addAction"];
// };
// sleep 60;

============================================================================

while {true} do {
{ deleteVehicle \_x } forEach allDead;
systemChat "cleanup";
sleep 30;
};

The above is currently in initSever - we need a much better system of cleanup
Maybe based on patrol point progression..? Or maybe an EH on dead, to wait x seconds
before deleting..?

============================================================================

Add ambient bombing runs

============================================================================

sort out sapper system - I took this:

// track created units  
spawnedIndiUnit = 0;
spawnedOpforUnit = 0;
publicVariable "spawnedIndiUnit";
publicVariable "spawnedOpforUnit";

// track sapper units
spawnedSapperUnit = 0;

// track whether opfor sapper ops are happening
SAPPERS = false;
publicVariable "SAPPERS";

// sapper stats
sapperWin = 0;
baseDefend = 0;
publicVariable "sapperWin";
publicVariable "baseDefend";

============================================================================

// broken links
RGG_brokenLinks = [];
// maybe make it so if any link is broken, you lose your respawn position?

============================================================================

// you could maybe also track mission time on each 'take' to track time for each mission point?

============================================================================

// bool to track if a patrol has been lost
LOSTPATROL = false;

// base-counter var for tracking how many patrols have been totally wiped out while in-field
lostPatrols = 0;

============================================================================

// base-counter var for tracking how many times RF have been called in
reinforcementsCalled = 0;
publicVariable "reinforcementsCalled";

============================================================================

============================================================================

============================================================================

============================================================================

============================================================================

============================================================================

============================================================================

============================================================================

============================================================================

============================================================================

v

v
