
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

// remove stamina 
player enableStamina FALSE;
player addEventHandler ['Respawn',{ player enableStamina FALSE }];

// welcome message 
// execVM "media\sounds\welcome.sqf";

// initial smoke inits for helis 
[RGG_heli1a] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
[RGG_heli2a] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
[RGG_heli3] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
[RGG_heli4] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";

// training event handler 
execVM "eventHandlers\trainingGetInMonitor.sqf";

// voiceMarkerSystem 
// execVM "voiceMarkerSystem\1_vmsInit.sqf";

// JTAC
// systemChat "JTAC Systems spinning up";
// execVM "autoPatrolSystem\JTAC_Systems\JTACinit.sqf";

/*
To do: reinstall JTAC and Voice Marker System here 
*/

// test - remove if does not work 
// [player, ["<t color='#FF0000'>DROP RED SMOKE</t>", {_smoke = "SmokeShellRed" createVehicle position player;},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
// player addAction ["<t color='#FF0000'>DROP RED SMOKE</t>", {_smoke = "SmokeShellRed" createVehicle position player;}];

// for future 
// execVM "voiceActivatedCoordFinder\VACF_init.sqf";
// execVM "voiceActivatedDataStore\VADS_init.sqf";
// execVM "voiceActivatedDataManager\VADM_init.sqf";
// execVM "voiceActivatedSyncShot\VASS_init.sqf";

// test keyDown EH 
// execVM "eventHandlers\keyDown.sqf";




