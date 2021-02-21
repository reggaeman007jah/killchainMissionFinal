
// Voice Activation Global Declaration - is this needed for jtac and voice markers?
VAA_Activate = true;

sleep 10;

// this manages the start of the mission
KILLCHAINMISSIONSTART = false;

// initialise APS
execVM "killchain\mission\missionInit.sqf"; 
sleep 0.5;

// slingload EH 
execVM "eventHandlers\slingLoadMonitor.sqf";

// smoke EH 
execVM "eventHandlers\getInMonitor.sqf";

// // initialise counter system 
// execVM "killchain\systems\countingSystems\counter.sqf";
// dont need this any more I dont think 

// // initialise flybys 
// execVM "killchain\systems\ambientSystems\randomFlybys.sqf";
// done on cycle phases 

// // initialise pickup scripts 
execVM "killchain\systems\pickupSystems\pickupSystems1\pickupInit.sqf";
execVM "killchain\systems\pickupSystems\pickupSystems2\pickupInit.sqf";
execVM "killchain\systems\pickupSystems\pickupSystems3\pickupInit.sqf";

// initialise para spawner script 
execVM "killchain\systems\spawnerSystems\spawnParas.sqf";

// enables HK Team as default 
HUNTERKILLER = true;

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
REARMONSPAWN = true; 

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
