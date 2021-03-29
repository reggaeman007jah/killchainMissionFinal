
["Initialize", [true]] call BIS_fnc_dynamicGroups;

// load images 
dontForget setObjectTextureGlobal [0, "media\images\reloadImage.jpg"];
fobPathfinder setObjectTextureGlobal [0, "media\images\pathfinderImage.jpg"];
customFlag setObjectTextureGlobal [0, "media\images\flag1.jpg"];
customFlag2 setObjectTextureGlobal [0, "media\images\flag1.jpg"];
whiteBoard setObjectTextureGlobal [0, "media\images\whiteBoard2.jpg"];
customFlag setObjectTexture [0,"media\images\flag1.jpg"]; // BROKEN
customFlag2 setObjectTexture [0,"media\images\flag1.jpg"];

// blufor marker system 
// execVM "killchain\systems\markerSystems\bluforMarkers.sqf"; // will run even if Killchain does not run 

// Voice Activation Global Declaration - is this needed for jtac and voice markers?
VAA_Activate = true;

// this manages the start of the mission
KILLCHAINMISSIONSTART = false;
SIDEMISSIONSTART = false;

ROPEBREAK = false;

// initialise killchain 
execVM "killchain\mission\missionInit.sqf"; 
execVM "killchain\sideMissions\sideMissionInit.sqf"; 
sleep 0.5;



// slingload EH 
execVM "eventHandlers\slingLoadMonitor.sqf";

// event handlers 
execVM "eventHandlers\getInMonitor.sqf";

// // initialise counter system 
// execVM "killchain\systems\countingSystems\counter.sqf";
// dont need this any more I dont think 

// // initialise flybys 
// execVM "killchain\systems\ambientSystems\randomFlybys.sqf";
// done on cycle phases 

// // initialise pickup scripts 
// execVM "killchain\systems\pickupSystems\pickupSystems1\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\pickupSystems2\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\pickupSystems3\pickupInit.sqf";

// initiate pickup systems for blackhawks and littlebirds
[RAIDER_1] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
[RAIDER_2] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
[RAIDER_3] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
[RAIDER_4] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
[RAIDER_5] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
[BIGBIRD_1] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";

// initialise para spawner script 
execVM "killchain\systems\spawnerSystems\spawnParas.sqf";
execVM "killchain\systems\spawnerSystems\spawnParas2.sqf";
execVM "killchain\systems\spawnerSystems\spawnMrap.sqf";
/*
To-do - make the spawner system better 
make sure the renewal system works 
add a playerNear system 
also add a check when doing pickups NOT to change state if you lift off without passengers...
*/

// enables HK Team as default 
HUNTERKILLER = true;
CPD = false;
publicVariable "HUNTERKILLER";
publicVariable "CPD";
// theory here is that a mod can also change this 

/*
This system needs improvement
*/
// while {true} do {
// 	{ deleteVehicle _x } forEach allDead;
// 	systemChat "cleanup";
// 	sleep 30;
// };
// check that other system works ok 

/*
this bool is used to clear out ammo from helis on respawn - this should be with the other param settings 
*/
// to avoid errors 
REARMONSPAWN = true; // switch this to false to turn off the 'no-ammo on respawn' system 

// ----- this holds any sentry units waiting to spawn in (but can't due to lack of base food) -----
RGG_sentryQueue = []; // holds sentry respawn data 
RGG_supplyQueue = []; // holds supply respawn data 
RESPAWNQUEUE = false; // this tracks whether the sentry respawn system is active 
// this holds all relevant enemy camps, by holding their position 
RGG_potentialEnemyCamps = [];
// this holds enemy camp positions = when 9, job is done 
RGG_destroyedEnemyCamps = [];
// Barracks
RGG_Barracks_Food = 0;
RGG_Barracks_Ammo = 0;
RGG_Barracks_Fuel = 0;
RGG_Barracks_Sentries = 0;
publicVariable "RGG_Barracks_Food";
publicVariable "RGG_Barracks_Ammo";
publicVariable "RGG_Barracks_Fuel";
publicVariable "RGG_Barracks_Sentries";

// TEST

_pack = "B_RadioBag_01_sage_F" createVehicle [12813.7,16690.2,0];
private "_pack";

_pack addAction ["Set up Sat-Dish from backpack", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_pos = _caller getRelPos [4,0];
	_dish = "SatelliteAntenna_01_Small_Sand_F" createVehicle _pos;
	
	systemChat "Finding signal ...";
	sleep 1;
	systemChat "Synchronising cryptographic hashes ...";
	sleep 1;
	systemChat "System ready";
	sleep 1;
	
	[_caller, _dish] execVM "activateRadar.sqf";
	_target removeAction _actionId;
}];

