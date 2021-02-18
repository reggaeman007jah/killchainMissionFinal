
// Voice Activation Global Declaration - is this needed for jtac and voice markers?
VAA_Activate = true;

sleep 10;

// this manages the start of the mission
KILLCHAINMISSIONSTART = false;

// initialise APS
execVM "killchain\mission\missionInit.sqf"; 
sleep 0.5;


// // initialise counter system 
// execVM "killchain\systems\countingSystems\counter.sqf";

// // initialise flybys 
// execVM "killchain\systems\ambientSystems\randomFlybys.sqf";

// // initialise pickup scripts 
// execVM "killchain\systems\pickupSystems\1\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\2\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\3\pickupInit.sqf";

// // initialise para spawner script 
// execVM "killchain\systems\spawnerSystems\spawnParas.sqf";

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












