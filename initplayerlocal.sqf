
/*
To do: reinstall JTAC and Voice Marker System here 
*/

sleep 1;

// flag and image tests - remove if does not work 
customFlag setFlagTexture "media\images\flag1.jpg";
customFlag2 setObjectTexture [0,"media\images\flag1.jpg"];

// remove stamina 
player enableStamina FALSE;
player addEventHandler ['Respawn',{ player enableStamina FALSE }];

// voiceMarkerSystem 
// execVM "voiceMarkerSystem\1_vmsInit.sqf";

// JTAC
// systemChat "JTAC Systems spinning up";
// execVM "autoPatrolSystem\JTAC_Systems\JTACinit.sqf";

// welcome message 
execVM "media\sounds\welcome.sqf";

// test - remove if does not work 
// [player, ["<t color='#FF0000'>DROP RED SMOKE</t>", {_smoke = "SmokeShellRed" createVehicle position player;},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
player addAction ["<t color='#FF0000'>DROP RED SMOKE</t>", {_smoke = "SmokeShellRed" createVehicle position player;}];

// for future 
// execVM "voiceActivatedCoordFinder\VACF_init.sqf";
// execVM "voiceActivatedDataStore\VADS_init.sqf";
// execVM "voiceActivatedDataManager\VADM_init.sqf";
// execVM "voiceActivatedSyncShot\VASS_init.sqf";
