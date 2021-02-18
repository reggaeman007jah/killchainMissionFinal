
_initStartPos = _this select 0; // starting point for any new mission
_objPos = _this select 1; // objective point for any new mission 

systemChat format ["Patrol Points Taken: %1", patrolPointsTaken];

// OBJ - patrol stage objective 
deleteMarker "Redzone"; 
_objective1 = createMarker ["Redzone", _objPos];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerColor "ColorRed";
_objective1 setMarkerSize [100, 100];
_objective1 setMarkerAlpha 0.2;
sleep 0.1;
_objective1 setMarkerSize [120, 120];
_objective1 setMarkerAlpha 0.3;
sleep 0.1;
_objective1 setMarkerSize [130, 130];
_objective1 setMarkerAlpha 0.4;
sleep 0.1;
_objective1 setMarkerSize [140, 140];
_objective1 setMarkerAlpha 0.5;
sleep 0.1;
_objective1 setMarkerSize [150, 150];
_objective1 setMarkerAlpha 0.6;
sleep 0.1;
_objective1 setMarkerSize [250, 250];
sleep 0.1;
_objective1 setMarkerSize [450, 450];
sleep 3;

// Patrol Stage Core 
deleteMarker "missionCore";  
_base = createMarker ["missionCore", _objPos];
_base setMarkerShape "ELLIPSE";
_base setMarkerColor "ColorRed";
_base setMarkerSize [10, 10];
_base setMarkerAlpha 0.3;
sleep 0.1;
_base setMarkerSize [15, 15];
_base setMarkerAlpha 0.4;
sleep 0.1;
_base setMarkerSize [20, 20];
_base setMarkerAlpha 0.5;
sleep 0.1;
_base setMarkerSize [30, 30];
_base setMarkerAlpha 0.6;
sleep 0.1;
_base setMarkerSize [40, 40];
_base setMarkerAlpha 0.7;
sleep 1;

// add icon 
deleteMarker "attackPoint";  
_tempMarker = createMarker ["attackPoint", _objPos];
_tempMarker setMarkerType "hd_objective";
_tempMarker setMarkerColor "ColorRed";

sleep 3;

// generate path marker/lines between marker points 
// generate random number and make into string 
_float = diag_tickTime;
_float2 = random 10000;
_uniqueStamp = [_float, _float2];
_stampToString = str _uniqueStamp;
// calculate line data 
_reldirX = _initStartPos getDir _objPos;
_relDir = floor _relDirX;
_distX = _initStartPos distance _objPos;
_dist = floor _distX;
_dist2 = _dist / 2;
_testPos = _initStartPos getPos [_dist2, _relDirX];

// create line map element 
_lineTest = createMarker [_stampToString, _testPos];
_lineTest setMarkerShape "RECTANGLE";
_lineTest setMarkerColor "ColorBlack";
_lineTest setMarkerDir _reldirX;
_lineTest setMarkerSize [2, _dist2];
// to enable a colour change when the chain breaks, these lines need to be pushed back into an array 

// new camp location and items 
_randomCampLocation = _objPos findEmptyPosition [10,50,"B_Heli_Light_01_dynamicLoadout_F"];

_random5 = random 5;
_random3 = random 3;

// tents 
for "_i" from 1 to 3 do {
	_randomDir = random 359;
	_random30 = random 30;
	_spawnPos = _randomCampLocation getPos [_random30, _randomDir];
	_campItem = createVehicle ["Land_TentDome_F", _spawnPos];
	_campItem setDir _randomDir;
	RGG_CampItems pushback _campItem;
};

// barrels and other camp stuff 
for "_i" from 1 to 3 do {
	_randomDir = random 359;
	_random25 = random 25;
	_spawnPos = _randomCampLocation getPos [_random3, _randomDir];
	_campItem = selectRandom [
		"Land_BarrelSand_F",
		"Land_BarrelSand_F",
		"Land_BarrelSand_grey_F",
		"Land_BarrelWater_grey_F",
		"Land_TransferSwitch_01_F",
		"Land_TentDome_F",
		"Land_RotorCoversBag_01_F",
		"Land_MetalBarrel_F",
		"Land_WaterTank_F"
	];
	// _spawnPos = _randomCampLocation getPos [_random25, _randomDir];
	_campItem2 = createVehicle [_campItem, _spawnPos];
	_campItem2 setDir _randomDir;
	RGG_CampItems pushback _campItem2;
};

// crates 
for "_i" from 1 to _random5 do {
	_randomDir = random 359;
	_random5 = random 5;
	_random25 = random 25;
	_spawnPos = _randomCampLocation getPos [_random5, _randomDir];
	_campItem = selectRandom [
		"Land_WoodenCrate_01_stack_x3_F",
		"Weapon_launch_O_Vorona_brown_F",
		"Box_T_East_Wps_F",
		"Box_East_AmmoOrd_F",
		"Box_East_WpsLaunch_F",
		"Land_CratesWooden_F",
		"Land_Pallet_MilBoxes_F",
		"Land_MetalBarrel_F",
		"Land_WaterTank_F"
	];
	// _spawnPos = _randomCampLocation getPos [_random25, _randomDir];
	_campItem2 = createVehicle [_campItem, _spawnPos];
	_campItem2 setDir _randomDir;
	RGG_CampItems pushback _campItem2;
};

sleep 2;

// _initStartPos = _this select 0; // starting point for any new mission
// _objPos = _this select 1; // objective point for any new mission 

// generate defending opfor 
_diffLevel = 2; // diff modifier i.e. number of iterations 

for "_i" from 1 to _diffLevel do {
	_grp = createGroup east;
	_rndOp1 = selectRandom [0, 3, 4, 5, 6];
	systemchat format ["1st wave: %1", _rndOp1];

	for "_i" from 1 to _rndOp1 do {
		_rndtype = selectRandom [
			"O_G_Soldier_A_F",
			"O_G_Soldier_AR_F",
			"O_G_medic_F",
			"O_G_engineer_F",
			"O_G_Soldier_exp_F",
			"O_G_Soldier_GL_F",
			"O_G_Soldier_M_F",
			"O_G_officer_F",
			"O_G_Soldier_F",
			// "O_G_Soldier_LAT_F",
			// "O_G_Soldier_LAT2_F",
			"O_G_Soldier_lite_F",
			"O_G_Sharpshooter_F",
			"O_G_Soldier_SL_F",
			"O_G_Soldier_TL_F"
			// "O_G_Offroad_01_armed_F"
		];
		_pos = [_objPos, 0, 30] call BIS_fnc_findSafePos; // was 30, now 80, now 150 hopefully for better dispertion // now back to 30
		_unit = _grp createUnit [_rndtype, _pos, [], 1, "none"]; 
		_unit setBehaviour "COMBAT";
		_unit doMove _initStartPos; 
		// spawnedOpforUnit = spawnedOpforUnit + 1;
		sleep 2;						
	};
};

sleep 1;

_opforClass = [
	// "o_soldieru_lat_f",
	"O_G_Soldier_A_F",
	"O_G_Soldier_AR_F",
	"O_G_medic_F",
	"O_G_engineer_F",
	"O_G_Soldier_exp_F",
	"O_G_Soldier_GL_F",
	"O_G_Soldier_M_F",
	"O_G_officer_F",
	"O_G_Soldier_F",
	"O_G_Soldier_LAT_F",
	"O_G_Soldier_LAT2_F",
	"O_G_Soldier_lite_F",
	"O_G_Sharpshooter_F",
	"O_G_Soldier_SL_F",
	"O_G_Soldier_TL_F"
];

_rndOp1 = selectRandom [8, 10, 12, 24];
_grp = createGroup east;

systemchat format ["opfor camp defence: %1", _rndOp1]; // debug 

for "_i" from 1 to _rndOp1 do {
	// systemchat "check perf while safePos does its work";
	_rndtype = selectRandom _opforClass;
	_pos = [_objPos, 0, 40] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
	_randomDir = selectRandom [270, 290, 01, 30, 90];
	_randomDist = random [5, 25, 50]; 
	_endPoint = _objPos getPos [_randomDist, _randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint;
	// spawnedOpforUnit = spawnedOpforUnit +1;
 	sleep 1;									
};

// createGuardedPoint [east, RGG_patrol_obj, -1, objNull];
// systemChat "guard wp set";

sleep 2;

// // calculate static defences 
// switch (patrolPointsTaken) do {
// 	case 0: {
// 		systemChat "no statics this time around";
// 		_rndOp1 = random [8, 12, 16];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// 	case 1: {
// 		for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_HMG_01_high_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_static_AT_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		// O_static_AT_F
// 		_rndOp1 = random [8, 14, 18];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// 	case 2: {
// 		for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_G_Mortar_01_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning mortar opfor";
// 			sleep 1;						
// 		};
// 		for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_static_AT_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		_rndOp1 = random [8, 16, 20];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// 	case 3: {
// 		for "_i" from 1 to 2 do {
// 			_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_HMG_01_high_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_static_AT_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		_rndOp1 = random [8, 12, 18];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 		_rndOp1 = random [4, 8, 10];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [25, 50, 75]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// 	case 4: {
// 		for "_i" from 1 to 2 do {
// 			_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_G_Mortar_01_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning mortar opfor";
// 			sleep 1;						
// 		};
// 		for "_i" from 1 to 2 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_static_AT_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		_rndOp1 = random [8, 12, 18];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 		_rndOp1 = random [8, 10, 14];
// 		_grp = createGroup east;
// 		systemchat format ["op defencee: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [25, 50, 75]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// 	case 5: {
// 		for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_HMG_01_high_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 			for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_G_Mortar_01_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning mortar opfor";
// 			sleep 1;						
// 		};
// 		for "_i" from 1 to 1 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_static_AT_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		_rndOp1 = random [10, 14, 20];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 		_rndOp1 = random [6, 10, 12];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [25, 50, 75]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// 	case 6: {
// 		for "_i" from 1 to 2 do {
// 			_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_HMG_01_high_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 			for "_i" from 1 to 2 do {
// 			_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_G_Mortar_01_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning mortar opfor";
// 			sleep 1;						
// 		};
// 		for "_i" from 1 to 2 do {
// 			_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_static_AT_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 		_rndOp1 = random [10, 14, 20];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 		_rndOp1 = random [6, 10, 12];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [25, 50, 75]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 		_rndOp1 = random [6, 10, 12];
// 		_grp = createGroup east;
// 		systemchat format ["op defence: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [50, 75, 90]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// 	// case 6: {
// 	// 	for "_i" from 1 to 3 do {
// 	// 		_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos; 
// 	// 		_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 	// 		_static = "O_HMG_01_high_F" createVehicle _pos;
// 	// 		_unit moveInGunner _static; 
// 	// 		_unit setBehaviour "COMBAT";
// 	// 		spawnedOpforUnit = spawnedOpforUnit + 1;
// 	// 		systemChat "spawning static opfor";
// 	// 		sleep 1;						
// 	// 	};
// 	// 		for "_i" from 1 to 3 do {
// 	// 		_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos; 
// 	// 		_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 	// 		_static = "O_G_Mortar_01_F" createVehicle _pos;
// 	// 		_unit moveInGunner _static; 
// 	// 		_unit setBehaviour "COMBAT";
// 	// 		spawnedOpforUnit = spawnedOpforUnit + 1;
// 	// 		systemChat "spawning mortar opfor";
// 	// 		sleep 1;						
// 	// 	};
// 	// };
// 	default {
// 		_randomStatic = selectRandom [0,1,2,3,4];
// 		_randomMortar = selectRandom [0,1,2,3,4];

// 		for "_i" from 1 to _randomStatic do {
// 			_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_HMG_01_high_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning static opfor";
// 			sleep 1;						
// 		};
// 			for "_i" from 1 to _randomMortar do {
// 			_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos; 
// 			_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"]; 
// 			_static = "O_G_Mortar_01_F" createVehicle _pos;
// 			_unit moveInGunner _static; 
// 			_unit setBehaviour "COMBAT";
// 			spawnedOpforUnit = spawnedOpforUnit + 1;
// 			systemChat "spawning mortar opfor";
// 			sleep 1;						
// 		};
// 		_rndOp1 = random [2, 8, 20];
// 		_grp = createGroup east;
// 		systemchat format ["op defencee: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [5, 25, 50]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 		_rndOp1 = random [2, 8, 20];
// 		_grp = createGroup east;
// 		systemchat format ["op defencee: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [25, 50, 75]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 		_rndOp1 = random [2, 8, 20];
// 		_grp = createGroup east;
// 		systemchat format ["op defencee: %1", _rndOp1];
// 		for "_i" from 1 to _rndOp1 do {
// 			_rndtype = selectRandom _opforClass;
// 			_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// 			_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
// 			_randomDir = selectRandom [270, 290, 01, 30, 90];
// 			_randomDist = random [50, 75, 90]; 
// 			_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// 			_unit setBehaviour "COMBAT";
// 			_unit doMove _endPoint;
// 			spawnedOpforUnit = spawnedOpforUnit +1;
// 			sleep 1;									
// 		};
// 	};
// };

// systemChat "op defenders spawn complete .....................";

sleep 20; // changes from 5 to 20, in case this was the reasons for the logic glitching out 

// HERE WE CHECK IF BLUFOR NEED RF 
// execVM "autoPatrolSystem\reinforcementSystems\bluforRF.sqf";
// systemchat "debug --- checking for blufor RF";
// "MP debug --- checking for blufor RF" remoteExec ["systemChat", 0, true];
// this is one of two points where patrol reinforcements are considered - previously this was every 90 seconds, now it is more lean and cheap

// redirects any indifor units incorrectly sent to the old point as part of an RF action 
// [_objPos] execVM "killChain\systems\insuranceSystems\indiforMovement.sqf";
// check if this ^^ is actually still needed ??

// check to see when indifor have taken patrol point, and when to trigger opfor rf 
RFCHECK = true; 

while {RFCHECK} do {

	// flybys 
	[_objPos] execVM "killchain\systems\ambientSystems\randomFlybys.sqf";

	_unitsRedzone = allUnits inAreaArray "redzone";
	_redzoneIndi = 0;
	_redzoneOpfor = 0;
	
	_unitsCore = allUnits inAreaArray "missionCore";
	_coreIndi = 0;
	_coreOpfor = 0;

	// Redzone stats 
	{
		switch ((side _x)) do
		{
			case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
			case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
		};
	} forEach _unitsRedzone;

	// Core stats 
	{
		switch ((side _x)) do
		{
			case INDEPENDENT: {_coreIndi = _coreIndi + 1};
			case EAST: {_coreOpfor = _coreOpfor + 1};
		};
	} forEach _unitsCore;

	// debug stats 
	systemChat "RFCHECK1";
	systemChat format ["REDZONE INDI: %1", _redzoneIndi];
	systemChat format ["REDZONE OPFR: %1", _redzoneOpfor];
	systemChat ".....";
	systemChat format ["CORE INDI:    %1", _coreIndi];
	systemChat format ["CORE OPFR:    %1", _coreOpfor];

	// rf check 
	if (_redzoneIndi <= 5) then {
		systemChat "note _redzoneIndi <= 5";
		// ORDER RF HERE
		[_initStartPos, _objPos] execVM "killChain\systems\spawnerSystems\createIndiforRFUnits.sqf";
		_smoke = createVehicle ["G_40mm_smokeYELLOW", _initStartPos, [], 0, "none"]; // drop this from up high 

		// voice broadcasts
		execVM "sounds\welcome\thisIsCommand.sqf";
		sleep 3;
		execVM "sounds\welcome\rfInbound.sqf";
	};

	// check if won point and if so, move to defend 
	if ((_coreOpfor <= 3) && (_coreIndi >=3)) then {
		// move indi units to a rough defensive position around the center point - note will also attrack any opfor strags 
		{
			_dir = random 360;
			_dist = selectRandom [14, 16, 18, 20, 22, 24, 30]; 
			_defendPoint = _objPos getPos [_dist, _dir]; // moves units into a rough 360 defensive circle
			_x setBehaviour "COMBAT";
			_x doMove _defendPoint;
			sleep 1;
		} forEach _unitsCore;
		RFCHECK = false;
	};

	sleep 90;
};

// at what stage should these initial defenders retreat?

// pop phase-change smoke 
_smoke = createVehicle ["G_40mm_smokeYELLOW", _objPos, [], 0, "none"]; // drop this from up high 

if (!BESILENT) then {
	// voice broadcast - prepare for retalliation 
	execVM "media\sounds\thisIsCommand.sqf";
	sleep 2;
	execVM "media\sounds\prepare.sqf";
};

deleteMarker "attackPoint";
_tempMarker = createMarker ["attackPoint", _objPos];
_tempMarker setMarkerType "hd_objective";
_tempMarker setMarkerColor "ColorGreen";

sleep 3;

// point 1 rules 
// only one direction of attack 
// medium numbers, two waves 
// set a timer for progrssion regardless _objPos

// _mainAnchor = RGG_PatrolPoints select 1;
// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos; 

private ["_mainAnchor"];

switch (patrolPointsTaken) do {
	case (0): {
		_mainAnchor = RGG_PatrolPoints select 1;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (1): {
		_mainAnchor = RGG_PatrolPoints select 2;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (2): {
		_mainAnchor = RGG_PatrolPoints select 3;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (3): {
		_mainAnchor = RGG_PatrolPoints select 4;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (4): {
		_mainAnchor = RGG_PatrolPoints select 5;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (5): {
		_mainAnchor = RGG_PatrolPoints select 6;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	default {
		systemChat "error Patrol Point switch";
	};
};

_anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;


//---------------------------------------------------------------------------------------------------------
deleteMarker "Point 1"; 
_objective1 = createMarker ["Point 1", _anchor1];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerColor "ColorRed";
_objective1 setMarkerSize [50, 50];
_objective1 setMarkerAlpha 0.2;

// unit creation 
for "_i" from 1 to 2 do {
	for "_i" from 1 to 6 do {
		_opforGroup = createGroup east;
		_anchor1a = [_anchor1, 1, 50, 3, 0] call BIS_fnc_findSafePos;
		_opforTeam = [];

		for "_i" from 1 to 2 do {
			_unit = selectRandom _opforClass;
			_unit1 = _opforGroup createUnit [_unit, _anchor1a, [], 0.1, "none"];
			_opforTeam pushBack _unit1;
		};

		sleep 0.7;

		// move orders 
		_ranDist = random 30;
		_ranDir = random 359;
		_unitDest = _objPos getPos [_ranDist, _ranDir];
		_opforTeam doMove _unitDest;
	};
	sleep 180;
};

// sleep 120; // too much?

RFCHECK2 = true; 
_cycles = 0;

while {RFCHECK2} do {

	// flybys 
	[_objPos] execVM "killchain\systems\ambientSystems\randomFlybys.sqf";

	// THIS MIGHT BE A PROBLEM AT SOME POINT - IE PUSHING A NEW POINT WITH NO ONE ON THE WON POINT 
	// if ((_cycles >= 5) && (_coreIndi >=3)) then {
	if (_cycles >= 5) then {
		// progress regardless 
		RFCHECK2 = false;
		systemChat "(_cycles >= 5) && (_coreIndi >=3) / cyclepush here";
	} else {
		_cycles = _cycles + 1;
		systemChat format ["Cycles: %1", _cycles];

		// get overall numbers of troops in redzone 
		_unitsRedzone = allUnits inAreaArray "redzone";
		_redzoneIndi = 0;
		_redzoneOpfor = 0;

		// get overall numbers of troops in obj core area 
		_unitsCore = allUnits inAreaArray "missionCore";
		_coreIndi = 0;
		_coreOpfor = 0;

		// check indi and opfor numbers in redzone  
		{
			switch ((side _x)) do
			{
				case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
				case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
			};
		} forEach _unitsRedzone;

		// check indi and opfpr numbers in core  
		{
			switch ((side _x)) do
			{
				case EAST: {_coreOpfor = _coreOpfor + 1};
				case INDEPENDENT: {_coreIndi = _coreIndi + 1};
			};
		} forEach _unitsCore;

		// debug stats 
		systemChat "RFCHECK2";
		systemChat format ["REDZONE INDI: %1", _redzoneIndi];
		systemChat format ["REDZONE OPFR: %1", _redzoneOpfor];
		systemChat ".....";
		systemChat format ["CORE INDI:    %1", _coreIndi];
		systemChat format ["CORE OPFR:    %1", _coreOpfor];

		if (_redzoneIndi <= 5) then {
			systemChat "note _redzoneIndi <= 5";
			// ORDER RF HERE
			[_initStartPos, _objPos] execVM "killChain\systems\spawnerSystems\createIndiforRFUnits.sqf";
			_smoke = createVehicle ["G_40mm_smokeYELLOW", _initStartPos, [], 0, "none"]; // drop this from up high 

			// voice broadcasts
			execVM "sounds\welcome\thisIsCommand.sqf";
			sleep 3;
			execVM "sounds\welcome\rfInbound.sqf";
		};

		// check if won point and if so, move to next point  
		// {
		// 	switch ((side _x)) do
		// 	{
		// 		case EAST: {_coreOpfor = _coreOpfor + 1};
		// 		case INDEPENDENT: {_coreIndi = _coreIndi + 1};
		// 	};
		// } forEach _unitsCore;

		if ((_coreOpfor <= 2) && (_coreIndi >=3)) then {
			systemChat "(_coreOpfor <= 2) && (_coreIndi >=3)";
			// regroup, healup and get prizes
			RFCHECK2 = false;
		};
	};

	sleep 90;
};

// time for prizes and healing --------------------------------------------------------------------------------- 

// voice broadcast to formalise success
if (!BESILENT) then { 
	execVM "killchain\media\sounds\thisIsCommand.sqf";
	sleep 2;
	execVM "killchain\media\sounds\success.sqf";		
};

// delete existing camp 
{ deleteVehicle _x } forEach RGG_CampItems;
RGG_CampItems = [];

// cleanup
[_objPos] execVM "killchain\systems\cleanUpSystems\cleanUp.sqf";
systemChat "CLEANUP - delete when tested";

// BASE REWARD :)
_buildLocation = _objPos findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"];
_fobPos = _buildLocation getPos [20,180];
_repairPos = _fobPos findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"];

hint "FLARES ...........";
_flrObj = "F_20mm_Red" createvehicle _buildLocation;
sleep 2;
_flrObj = "F_20mm_Red" createvehicle _fobPos;
sleep 2;
_flrObj = "F_20mm_Red" createvehicle _repairPos;
sleep 15;
_baseBuilding1 = createVehicle ["Land_MedicalTent_01_tropic_closed_F", _buildLocation, [], 30, "none"]; 
sleep 0.6;
_ammoSup = createVehicle ["Box_NATO_Support_F", _fobPos]; //ammmo 
[ "AmmoboxInit", [_ammoSup, true, {true}] ] call BIS_fnc_arsenal;
sleep 0.6;
_quaddy = createVehicle ["I_G_Quadbike_01_F", _fobPos]; // quad
_ammoSup = createVehicle ["B_Slingload_01_Repair_F", _repairPos]; //vehicle repair 
_vicLocation = _objPos findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"];
_vic = selectRandom [
	"I_G_Offroad_01_armed_F", 
	"I_C_Offroad_02_LMG_F", 
	"I_C_Offroad_02_LMG_F", 
	"B_LSV_01_armed_F"
	];
_rewardSpawn = createVehicle [_vic, _vicLocation]; // reward vic 

// win marker 
_float = diag_tickTime;
_stampToString = str _float;

_tempBase = createMarker [_stampToString, _objPos];
_tempBase setMarkerShape "ELLIPSE";
_tempBase setMarkerSize [30, 30];
_tempBase setMarkerAlpha 0.8;
_tempBase setMarkerColor "colorBlue";

// create respawn points 
_bluforSpawn = _objPos getPos [40,90];
_indiSpawn = _objPos getPos [40,270];
RGG_respawnStore pushBack [_bluforSpawn, _indiSpawn]; // sending to global array to enable deleting of older respawns 
[west, _bluforSpawn, "POINT 1-BRAVO"] call BIS_fnc_addRespawnPosition; // create blu resapwn
[independent, _indiSpawn, "POINT 1-INDIGO"] call BIS_fnc_addRespawnPosition; // create ind resapwn

// _cnt = count RGG_respawnStore; // check if more than one, i.e. don't process this is we only have one (1st) point 
// if (_cnt >1) then {
// 	_removeSpawns = RGG_respawnStore select 0;
// 	_removeBluSpawn = _removeSpawns select 0;
// 	_removeIndSpawn = _removeSpawns select 1;
// 	[west, _removeBluSpawn] callBIS_fnc_removeRespawnPosition
// 	[independent, _removeIndSpawn] callBIS_fnc_removeRespawnPosition
// 	RGG_respawnStore deleteAt 0;
// };

patrolPointsTaken = patrolPointsTaken +1;

// set up next obj 
_anchor = _objPos; // switcheroo 
// private ["_mainAnchor"]; // may not need this..?

// this switch repurposes the _objPos value with the next obj position 
switch (patrolPointsTaken) do {
	case 1: {
		_objPos = RGG_PatrolPoints select 1;
		systemChat "RUNNING PHASE 2";	
	};
	case 2: {
		_objPos = RGG_PatrolPoints select 2;
		systemChat "RUNNING PHASE 3";	
	};
	case 3: {
		_objPos = RGG_PatrolPoints select 1;
		systemChat "RUNNING PHASE 4";	
	};
	case 4: {
		_objPos = RGG_PatrolPoints select 2;
		systemChat "RUNNING PHASE 5";	
	};
	case 5: {
		_objPos = RGG_PatrolPoints select 1;
		systemChat "RUNNING PHASE 6";	
	};
	case 6: {
		_objPos = RGG_PatrolPoints select 2;
		systemChat "RUNNING ENDGAME";	
	};
	default {
		systemChat "error: Patrol Point switch";
	};
};

if (patrolPointsTaken <= 5) then {
	[_anchor, _objPos] execVM "killChain\mission\patrolCycle.sqf";	
} else {
	[_anchor, _objPos] execVM "killChain\mission\patrolFinal.sqf";	
};

_units = allUnits inAreaArray "redzone";
_indi = [];

{
	if ((side _x) == INDEPENDENT) then {_indi pushBack _x}
} forEach _units;

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_endPoint1 = _objPos getPos [_randomDist,_randomDir];
	sleep 1;
	_x setBehaviour "COMBAT";
	_x doMove _endPoint1;
} forEach _indi;

// cleanup
{ deleteVehicle _x } forEach allDead;
systemChat "RUNNING CLEANUP";


// switch (patrolPointsTaken) do {
// 	case 1: {
// 		_objPos = RGG_PatrolPoints select 1;
// 		[_anchor, _objPos] execVM "killChain\mission\patrolCycle.sqf";
// 		_indi = [];
// 		_units = allUnits inAreaArray "redzone";
// 		{if ((side _x) == INDEPENDENT) then {_indi pushBack _x}} forEach _units;
// 		{
// 			_randomDir = selectRandom [270, 310, 00, 50, 90];
// 			_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 			_endPoint1 = _objPos getPos [_randomDist,_randomDir];
// 			sleep 1;
// 			_x setBehaviour "COMBAT";
// 			_x doMove _endPoint1;
// 		} forEach _indi;
// 		systemChat "RUNNING PHASE 2";
// 	};
// 	case 2: {
// 		_objPos = RGG_PatrolPoints select 2;
// 		[_anchor, _objPos] execVM "killChain\mission\objPoint1.sqf";
// 		_indi = [];
// 		_units = allUnits inAreaArray "redzone";
// 		{if ((side _x) == INDEPENDENT) then {_indi pushBack _x}} forEach _units;
// 		{
// 			_randomDir = selectRandom [270, 310, 00, 50, 90];
// 			_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 			_endPoint1 = _objPos getPos [_randomDist,_randomDir];
// 			sleep 1;
// 			_x setBehaviour "COMBAT";
// 			_x doMove _endPoint1;
// 		} forEach _indi;
// 		systemChat "RUNNING PHASE 3";
// 	};
// 	case 3: {
// 		_objPos = RGG_PatrolPoints select 3;
// 		[_anchor, _objPos] execVM "killChain\mission\objPoint1.sqf";
// 		_indi = [];
// 		_units = allUnits inAreaArray "redzone";
// 		{if ((side _x) == INDEPENDENT) then {_indi pushBack _x}} forEach _units;
// 		{
// 			_randomDir = selectRandom [270, 310, 00, 50, 90];
// 			_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 			_endPoint1 = _objPos getPos [_randomDist,_randomDir];
// 			sleep 1;
// 			_x setBehaviour "COMBAT";
// 			_x doMove _endPoint1;
// 		} forEach _indi;
// 		systemChat "RUNNING PHASE 4";
// 	};
// 	case 4: {
// 		_objPos = RGG_PatrolPoints select 4;
// 		[_anchor, _objPos] execVM "killChain\mission\objPoint1.sqf";
// 		_indi = [];
// 		_units = allUnits inAreaArray "redzone";
// 		{if ((side _x) == INDEPENDENT) then {_indi pushBack _x}} forEach _units;
// 		{
// 			_randomDir = selectRandom [270, 310, 00, 50, 90];
// 			_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 			_endPoint1 = _objPos getPos [_randomDist,_randomDir];
// 			sleep 1;
// 			_x setBehaviour "COMBAT";
// 			_x doMove _endPoint1;
// 		} forEach _indi;
// 		systemChat "RUNNING PHASE 5";
// 	};
// 	case 5: {
// 		_objPos = RGG_PatrolPoints select 5;
// 		[_anchor, _objPos] execVM "killChain\mission\objPoint1.sqf";
// 		_indi = [];
// 		_units = allUnits inAreaArray "redzone";
// 		{if ((side _x) == INDEPENDENT) then {_indi pushBack _x}} forEach _units;
// 		{
// 			_randomDir = selectRandom [270, 310, 00, 50, 90];
// 			_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 			_endPoint1 = _objPos getPos [_randomDist,_randomDir];
// 			sleep 1;
// 			_x setBehaviour "COMBAT";
// 			_x doMove _endPoint1;
// 		} forEach _indi;
// 		systemChat "RUNNING PHASE 6";
// 	};
// 	case 6: {
// 		_objPos = RGG_PatrolPoints select 6;
// 		[_anchor, _objPos] execVM "killChain\mission\patrolCycle.sqf";
// 		_indi = [];
// 		_units = allUnits inAreaArray "redzone";
// 		{if ((side _x) == INDEPENDENT) then {_indi pushBack _x}} forEach _units;
// 		{
// 			_randomDir = selectRandom [270, 310, 00, 50, 90];
// 			_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 			_endPoint1 = _objPos getPos [_randomDist,_randomDir];
// 			sleep 1;
// 			_x setBehaviour "COMBAT";
// 			_x doMove _endPoint1;
// 		} forEach _indi;
// 		systemChat "RUNNING ENDGAME";
// 	};
// 	default {
// 		systemChat "error Patrol Point switch";
// 	};
// };






// get second objective 
// _anchor = _objPos;
// _objPos = RGG_PatrolPoints select 1;



// init Point 1 Obj  














// OLD BELOW 

/*
From: autoPatrolSystem\phase3_createOpforDefenders.sqf

Purpose:
TBC

Flow:
	player info - publicVariable "MISSIONTASK";
	yellow smoke as indicator of phase change 
	create "attackPoint" marker icon 
	put all indi units into a local array 
	move indi units to a rough defensive position around the center point 
	switch check based on patrolPointsTaken, in order to define number of attack vectors and force size   

Receives:
TBC

Informs:
	calls the monitoring phase 
	[_rndOp1] execVM "autoPatrolSystem\phase5_monitorBluforDefence.sqf"; 

Notes:
	_defendStartTime = time - Maybe use this as a timer system?
	systemChat format ["patrol defence started at %1 seconds into mission", _defendStartTime];
	I capture mission minutes - this is an easy way to set a timer on any one point 

Actions:
	Investigate setting timers on point phases 
	Add voice to assist players on phase 
	remove old comments 
	improve class selection for opfor QRF elements 

Questions:
	6 enemy groups ar created before the main switch, but groups are also created within the swith block...
	Are these first 6 groups needed or can they be deleted?

Data:

*/
/*
// defensive positions (blufor) 

// player info 
MISSIONTASK = "Secure the patrol point and prepare for opfor retaliation";
publicVariable "MISSIONTASK";

// pop phase-change smoke 
_smoke = createVehicle ["G_40mm_smokeYELLOW", RGG_patrol_obj, [], 0, "none"]; // drop this from up high 

if (!BESILENT) then {
	// voice broadcast - prepare for retalliation 
	execVM "sounds\welcome\thisIsCommand.sqf";
	sleep 2;
	execVM "sounds\welcome\prepare.sqf";
};


// systemChat "debug --- blufor moving into defensive positions at the patrol point"; 	
// "MP debug --- blufor moving into defensive positions at the patrol point" remoteExec ["systemChat", 0, true];

// create "attackPoint" marker icon
deleteMarker "attackPoint";
_tempMarker = createMarker ["attackPoint", RGG_patrol_obj];
_tempMarker setMarkerType "hd_objective";
_tempMarker setMarkerColor "ColorGreen";
sleep 3;

// put all indi units into a local array 
// {if ((side _x) == INDEPENDENT) then {_indi pushBack _x}} forEach allUnits inAreaArray "Objective 1";
_indi = [];
{
	if ((side _x) == INDEPENDENT) then {
		_indi pushBack _x
	}
} forEach allUnits;

// move indi units to a rough defensive position around the center point 
{
	// systemChat "debug - BLUEDEFEND STATE - Blue Unit Counted";
	// "MP debug - BLUEDEFEND STATE - Blue Unit Counted" remoteExec ["systemChat", 0, true];
	_dir = random 360;
	_dist = selectRandom [14, 16, 18, 20, 22, 24]; 
	_defendPoint = RGG_patrol_obj getPos [_dist, _dir]; // moves units into a rough 360 defensive circle
	_x setBehaviour "COMBAT";
	_x doMove _defendPoint;
	sleep 1;
} forEach _indi;	

// then create and move enemy into attack 

// _enemyWaves = selectRandom [1,2,3]; // do this once

// systemChat format ["MSG there are %1 waves incoming", _enemyWaves];
// "MP MSG there are %1 waves incoming" remoteExec ["systemChat format", 0, true];	// this won't work!

// work out waves later - for now keep things alternating attack / defend 

// systemChat "op retaliatory attackers being created";

// _outcome = selectRandom [1,2,3]; 
// _outcome = 1; // for testing 

// if (_outcome == 1) then {
// 	ONEPOINT = true;
// };
// if (_outcome == 2) then {
// 	TWOPOINT = true;
// };
// if (_outcome == 3) then {
// 	THREEPOINT = true;
// };

// _rndOp1 = selectRandom [24, 30, 36, 42, 48, 54]; // RF force size 
// stage RF based on patrol points taken and maybe also dist from home base 

// switch check based on patrolPointsTaken, in order to define number of attack vectors and force size  
private ["_rndOp1"];
switch (patrolPointsTaken) do {
	case (0): { _rndOp1 = 24; ONEPOINT = true; };
	case (1): { _rndOp1 = 30; ONEPOINT = true; };
	case (2): { _rndOp1 = 36; TWOPOINT = true; };
	case (3): { _rndOp1 = 42; TWOPOINT = true; };
	case (4): { _rndOp1 = 48; THREEPOINT = true; };
	case (5): { _rndOp1 = 54; THREEPOINT = true; };
	default { _rndOp1 = selectRandom [24, 30, 36, 42, 48, 54]; THREEPOINT = true; };
};

// create 6 groups each time (in order to send to one two or three points)
_grp1 = createGroup east;
_grp2 = createGroup east;
_grp3 = createGroup east;
_grp4 = createGroup east;
_grp5 = createGroup east;
_grp6 = createGroup east;
_groupSize = _rndOp1 / 12; // 12 is a reduction factor - needs to be tested 

// switch to generate attack points (and markers), create enemy forces and send towards the base 
switch (true) do {	

	case (ONEPOINT): {
		// anchor 
		_anchor1 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; 
		// marker mgmt 
		deleteMarker "Point 1";
		deleteMarker "Point 2";
		deleteMarker "Point 3"; 
		_objective1 = createMarker ["Point 1", _anchor1];
		_objective1 setMarkerShape "ELLIPSE";
		_objective1 setMarkerColor "ColorRed";
		_objective1 setMarkerSize [50, 50];
		_objective1 setMarkerAlpha 0.2;
		// unit creation 
		for "_i" from 1 to 6 do {
			_indiGroup = createGroup east;
			_anchor1a = [_anchor1, 50, 200, 3, 0] call BIS_fnc_findSafePos;
			_opforTeam = [];
			_opClasses = ["o_g_soldier_ar_f","o_g_soldier_gl_f","o_g_sharpshooter_f"];
			for "_i" from 1 to _groupSize do {
				_unit = selectRandom _opClasses;
				_unit1 = _indiGroup createUnit [_unit, _anchor1a, [], 0.1, "none"];
				_opforTeam pushBack _unit1;
			};
			systemChat "opfor team:";
			systemChat str _opforTeam;
			sleep 0.3;
			// move orders 
			_ranDist = random 30;
			_ranDir = random 359;
			_unitDest = RGG_patrol_obj getPos [_ranDist, _ranDir];
			_opforTeam doMove _unitDest;
			spawnedIndiUnit = spawnedIndiUnit + _groupSize;
		};
		// createGuardedPoint [east, RGG_patrol_obj, -1, objNull];
		ONEPOINT = false;
	};

	case (TWOPOINT): {
		// anchors
		_anchor1 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
		_anchor2 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
		// marker mgmt 
		deleteMarker "Point 1";
		deleteMarker "Point 2";
		deleteMarker "Point 3"; 
		_objective1 = createMarker ["Point 1", _anchor1];
		_objective1 setMarkerShape "ELLIPSE";
		_objective1 setMarkerColor "ColorRed";
		_objective1 setMarkerSize [50, 50];
		_objective1 setMarkerAlpha 0.2;
		_objective2 = createMarker ["Point 2", _anchor2];
		_objective2 setMarkerShape "ELLIPSE";
		_objective2 setMarkerColor "ColorRed";
		_objective2 setMarkerSize [50, 50];
		_objective2 setMarkerAlpha 0.2;
		// unit creation 
		for "_i" from 1 to 3 do {
			_indiGroup = createGroup east;
			_anchor1a = [_anchor1, 50, 150, 3, 0] call BIS_fnc_findSafePos;
			_opforTeam = [];
			_opClasses = ["o_g_soldier_ar_f","o_g_soldier_gl_f","o_g_sharpshooter_f","o_soldieru_lat_f"];
			for "_i" from 1 to _groupSize do {
				_unit = selectRandom _opClasses;
				_unit1 = _indiGroup createUnit [_unit, _anchor1a, [], 0.1, "none"];
				_opforTeam pushBack _unit1;
			};
			systemChat "opfor team:";
			systemChat str _opforTeam;
			sleep 0.3;
			// move orders 
			_ranDist = random 30;
			_ranDir = random 359;
			_unitDest = RGG_patrol_obj getPos [_ranDist, _ranDir];
			_opforTeam doMove _unitDest;
			spawnedIndiUnit = spawnedIndiUnit + _groupSize;
		};
		for "_i" from 1 to 3 do {
			_indiGroup = createGroup east;
			_anchor2a = [_anchor2, 50, 150, 3, 0] call BIS_fnc_findSafePos;
			_opforTeam = [];
			_opClasses = ["o_g_soldier_ar_f","o_g_soldier_gl_f","o_g_sharpshooter_f","o_soldieru_lat_f"];
			for "_i" from 1 to _groupSize do {
				_unit = selectRandom _opClasses;
				_unit1 = _indiGroup createUnit [_unit, _anchor2a, [], 0.1, "none"];
				_opforTeam pushBack _unit1;
			};
			systemChat "opfor team:";
			systemChat str _opforTeam;
			sleep 0.3;
			// move orders 
			_ranDist = random 30;
			_ranDir = random 359;
			_unitDest = RGG_patrol_obj getPos [_ranDist, _ranDir];
			_opforTeam doMove _unitDest;
			spawnedIndiUnit = spawnedIndiUnit + _groupSize;
		};
		TWOPOINT = false;
	};
	case (THREEPOINT): {	
		// anchors
		_anchor1 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
		_anchor2 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
		_anchor3 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
		// marker mgmt 
		deleteMarker "Point 1";
		deleteMarker "Point 2";
		deleteMarker "Point 3"; 
		_objective1 = createMarker ["Point 1", _anchor1];
		_objective1 setMarkerShape "ELLIPSE";
		_objective1 setMarkerColor "ColorRed";
		_objective1 setMarkerSize [50, 50];
		_objective1 setMarkerAlpha 0.2;
		_objective2 = createMarker ["Point 2", _anchor2];
		_objective2 setMarkerShape "ELLIPSE";
		_objective2 setMarkerColor "ColorRed";
		_objective2 setMarkerSize [50, 50];
		_objective2 setMarkerAlpha 0.2;
		_objective3 = createMarker ["Point 3", _anchor3];
		_objective3 setMarkerShape "ELLIPSE";
		_objective3 setMarkerColor "ColorRed";
		_objective3 setMarkerSize [50, 50];
		_objective3 setMarkerAlpha 0.2;
		// unit creation 
		for "_i" from 1 to 2 do {
			_indiGroup = createGroup east;
			_anchor1a = [_anchor1, 50, 150, 3, 0] call BIS_fnc_findSafePos;
			_opforTeam = [];
			_opClasses = ["o_g_soldier_ar_f","o_g_soldier_gl_f","o_g_sharpshooter_f","o_soldieru_lat_f"];
			for "_i" from 1 to _groupSize do {
				_unit = selectRandom _opClasses;
				_unit1 = _indiGroup createUnit [_unit, _anchor1a, [], 0.1, "none"];
				_opforTeam pushBack _unit1;
			};
			systemChat "opfor team:";
			systemChat str _opforTeam;
			sleep 0.3;
			// move orders 
			_ranDist = random 30;
			_ranDir = random 359;
			_unitDest = RGG_patrol_obj getPos [_ranDist, _ranDir];
			_opforTeam doMove _unitDest;
			spawnedIndiUnit = spawnedIndiUnit + _groupSize;
		};
		for "_i" from 1 to 2 do {
			_indiGroup = createGroup east;
			_anchor2a = [_anchor2, 50, 150, 3, 0] call BIS_fnc_findSafePos;
			_opforTeam = [];
			_opClasses = ["o_g_soldier_ar_f","o_g_soldier_gl_f","o_g_sharpshooter_f","o_soldieru_lat_f"];
			for "_i" from 1 to _groupSize do {
				_unit = selectRandom _opClasses;
				_unit1 = _indiGroup createUnit [_unit, _anchor2a, [], 0.1, "none"];
				_opforTeam pushBack _unit1;
			};
			systemChat "opfor team:";
			systemChat str _opforTeam;
			sleep 0.3;
			// move orders 
			_ranDist = random 30;
			_ranDir = random 359;
			_unitDest = RGG_patrol_obj getPos [_ranDist, _ranDir];
			_opforTeam doMove _unitDest;
			spawnedIndiUnit = spawnedIndiUnit + _groupSize;
		};
		for "_i" from 1 to 2 do {
			_indiGroup = createGroup east;
			_anchor3a = [_anchor3, 50, 150, 3, 0] call BIS_fnc_findSafePos;
			_opforTeam = [];
			_opClasses = ["o_g_soldier_ar_f","o_g_soldier_gl_f","o_g_sharpshooter_f","o_soldieru_lat_f"];
			for "_i" from 1 to _groupSize do {
				_unit = selectRandom _opClasses;
				_unit1 = _indiGroup createUnit [_unit, _anchor3a, [], 0.1, "none"];
				_opforTeam pushBack _unit1;
			};
			systemChat "opfor team:";
			systemChat str _opforTeam;
			sleep 0.3;
			// move orders 
			_ranDist = random 30;
			_ranDir = random 359;
			_unitDest = RGG_patrol_obj getPos [_ranDist, _ranDir];
			_opforTeam doMove _unitDest;
			spawnedIndiUnit = spawnedIndiUnit + _groupSize;
		};
		THREEPOINT = false;
	};
	// below works...
	// case (TWOPOINT): {
	// 	// systemChat "switch test ok 2";
	// 	_pos1 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
	// 	_pos2 = [RGG_patrol_obj, 400, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
	// 	deleteMarker "Point 3";
	// 	deleteMarker "Point 1";
	// 	_objective1 = createMarker ["Point 1", _pos1];
	// 	_objective1 setMarkerShape "ELLIPSE";
	// 	_objective1 setMarkerColor "ColorRed";
	// 	_objective1 setMarkerSize [50, 50];
	// 	deleteMarker "Point 2";
	// 	_objective1 = createMarker ["Point 2", _pos2];
	// 	_objective1 setMarkerShape "ELLIPSE";
	// 	_objective1 setMarkerColor "ColorRed";
	// 	_objective1 setMarkerSize [50, 50];

	// 	for "_i" from 1 to _rndOp1 do 
	// 	{						
	// 		sleep 3;
	// 		_grp = createGroup east;
	// 		_randomDir = selectRandom [0, 45, 90, 135, 180, 225, 270, 315]; 
	// 		_posRandom = selectRandom [_pos1, _pos2];
	// 		_pos = _posRandom getPos [50, _randomDir];
	// 		_rndtype = selectRandom ["o_g_soldier_ar_f", "o_g_soldier_gl_f", "o_g_sharpshooter_f", "o_soldieru_lat_f"];			
	// 		_unit = _grp createUnit [_rndtype, _pos, [], 1, "none"]; 
	// 		sleep 0.3;
	// 		_moveTo = RGG_patrol_obj getPos [5, _randomDir]; 
	// 		_unit doMove _moveTo;
	// 		spawnedOpforUnit = spawnedOpforUnit + 1;

	// 	}; 
	// 	TWOPOINT = false;
	// };
	// case (THREEPOINT): {	
	// 	// systemChat "switch test ok 3";
	// 	_pos1 = [RGG_patrol_obj, 300, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
	// 	_pos2 = [RGG_patrol_obj, 300, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
	// 	_pos3 = [RGG_patrol_obj, 300, 700] call BIS_fnc_findSafePos; // single point spawn 400-700m away from Dest
	// 	deleteMarker "Point 1";
	// 	_objective1 = createMarker ["Point 1", _pos1];
	// 	_objective1 setMarkerShape "ELLIPSE";
	// 	_objective1 setMarkerColor "ColorRed";
	// 	_objective1 setMarkerSize [50, 50];
	// 	deleteMarker "Point 2";
	// 	_objective1 = createMarker ["Point 2", _pos2];
	// 	_objective1 setMarkerShape "ELLIPSE";
	// 	_objective1 setMarkerColor "ColorRed";
	// 	_objective1 setMarkerSize [50, 50];
	// 	deleteMarker "Point 3";
	// 	_objective1 = createMarker ["Point 3", _pos3];
	// 	_objective1 setMarkerShape "ELLIPSE";
	// 	_objective1 setMarkerColor "ColorRed";
	// 	_objective1 setMarkerSize [50, 50];

	// 	_grp = createGroup east; // moving this 'out' of the loop, so it is only triggered once - will this resolve the noSpawn issue?

	// 	for "_i" from 1 to _rndOp1 do 
	// 	{						
	// 		sleep 3;
	// 		// _grp = createGroup east;
	// 		_randomDir = selectRandom [0, 45, 90, 135, 180, 225, 270, 315]; 
	// 		_moveDist = selectRandom [5, 10, 15, 20, 25, 30]; 
	// 		_posRandom = selectRandom [_pos1, _pos2, _pos3];
	// 		_pos = _posRandom getPos [50, _randomDir];
	// 		_rndtype = selectRandom ["o_g_soldier_ar_f", "o_g_soldier_gl_f", "o_g_sharpshooter_f", "o_soldieru_lat_f"];			
	// 		_unit = _grp createUnit [_rndtype, _pos, [], 1, "none"]; 
	// 		sleep 0.3;
	// 		_moveTo = RGG_patrol_obj getPos [_moveDist, _randomDir]; // _moveDist is an attempt to better space out opfor attackers after they have taken back a point 
	// 		_unit doMove _moveTo;
	// 		spawnedOpforUnit = spawnedOpforUnit + 1;

	// 	}; 
	// 	THREEPOINT = false;
	// };
};

sleep 5;
// pass in no. of enemy units / no. of origin points / vars to inform intel message
[_rndOp1] execVM "autoPatrolSystem\phase5_monitorBluforDefence.sqf"; 