/*
This will gen a one-off opfor group, to enable players to seek and destroy 
can vary in size - players should prepare for large forces, so arrive prepared.
*/

/*
To do:
gen position 
gen opfor 
gen marker 
trigger activate and closedown 

*/

systemChat "DEBUG - RUNNING: missions_seekAndDestroy";

_areaCenter = _this select 0; // currently FOB Pathfinder, but could also be a patrol point, or any thing else 
// _welcomeParty = selectRandom [1,2,3]; // decides what is happening on approach to area and how players are welcomed 

// the welcome party switch will determine how serious the enemy is  
// private "_actDist";
// switch (_welcomeParty) do {
// 	case 1: { _actDist = 20 }; // medium camp, mainly infi  
// 	case 2: { _actDist = 80 }; // camp plus mraps 
// 	case 3: { _actDist = 120 }; // large force plus tanks 
// 	default { systemChat "Switch Error _actDist" };
// };

// 
_assetsCamp = [
	"Land_BagBunker_01_large_green_F",
	"CamoNet_ghex_big_F",
	"Land_Cargo_HQ_V4_F",
	"Land_MedicalTent_01_CSAT_greenhex_generic_outer_F",
	"Land_PillboxBunker_01_hex_F"
];

// opfor infi 
_assetsInfi = [
	"O_R_Soldier_SL_ard_F",
	"O_R_RadioOperator_ard_F",
	"O_R_Soldier_LAT_ard_F",
	"O_R_soldier_M_ard_F",
	"O_R_Soldier_TL_ard_F",
	"O_R_soldier_AR_ard_F",
	"O_R_Soldier_A_ard_F",
	"O_R_medic_ard_F",
	"O_R_Soldier_SL_ard_F",
	"O_R_soldier_AR_ard_F",
	"O_R_Soldier_GL_ard_F",
	"O_R_soldier_M_ard_F",
	"O_R_soldier_AT_ard_F",
	"O_R_Soldier_AAT_ard_F",
	"O_R_Soldier_A_ard_F",
	"O_R_medic_ard_F"
];

// light armour - not used here 
_assetsMRAP = [
	"O_R_APC_Wheeled_02_rcws_v2_ard_F",
	"O_R_APC_Tracked_02_medical_ard_F",
	"O_R_APC_Tracked_02_cannon_ard_F",
	"O_R_Truck_03_fuel_ard_F",
	"O_R_Truck_02_fuel_ard_F",
	"O_R_Truck_02_ard_F",
	"O_R_Truck_02_MRL_ard_F"
];

// tanks
_assetsArmour = [
	"O_R_MBT_04_command_ard_F",
	"O_R_MBT_04_cannon_ard_F",
	"O_R_MBT_02_cannon_ard_F"
];

// mission pos 
_missionPos = [_areaCenter, 6000, 6500, 10, 0, 1, 0] call BIS_fnc_findSafePos;

deleteMarker "KILLZONE";
_pos1 = createMarker ["KILLZONE", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerSize [250, 250];
// replace this with voice markers  

// add marker icon here 
KILLZONE = true; // for marker system 
[_missionPos, "hd_objective", "KILLZONE_Marker", "colorRed"] spawn RGGe_fnc_effects_markersSAD;

// hold - check for player near 
// deleteAll checks here - ensure no players near 
_anchorPos = getMarkerPos 'KILLZONE';
_activateCheck = true;
while {_activateCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 1500) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt >= 1) then {
		systemChat "players are near - SAD mission activated";
		_activateCheck = false;
	} else {
		_activateCheck = true;
		systemChat "players are not near - do not delete";
	};

	sleep 20; // cycle frequency 
};

// create items 
systemChat "debug - creating items";
{
	_dist = random 100;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];
	_thing = _x createVehicle _thingPos;
	_thing setDir _dir;
	sleep 0.5;
} forEach _assetsCamp;

sleep 2;
// create units 
systemChat "debug - creating units";
_opGroup = createGroup [east, true];
{
	_dist = random 100;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];

	_unit = _opGroup createUnit [_x, _thingPos, [], 0.1, "none"]; 
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	_unit setDir _dir;

	sleep 0.1;
} forEach _assetsInfi;
// to-do manage positions and ambient walking etc 

// add diff levels based on near players 
_dataStore = [];
{
	_playerPos = getPos _x;
	_dist = _anchorPos distance _playerPos;

	if (_dist < 1500) then {
		_dataStore pushback _x;
	};
} forEach allPlayers;

_nearPlayers = count _dataStore;

_medDiff = false;
_hardDiff = false;
if (_nearPlayers < 4) then {
	// medium diff 
	_medDiff = true;
} else {
	// hard diff 
	_hardDiff = true;
};

if (_medDiff) then {
	// 4 mraps 
	for "_i" from 1 to 4 do {
		_rndtype = selectRandom [
			"O_R_APC_Wheeled_02_rcws_v2_ard_F",
			"O_R_APC_Tracked_02_medical_ard_F",
			"O_R_APC_Tracked_02_cannon_ard_F",
			"O_R_Truck_03_fuel_ard_F",
			"O_R_Truck_02_fuel_ard_F",
			"O_R_Truck_02_ard_F",
			"O_R_Truck_02_MRL_ard_F"
		];

		_pos = [_missionPos, 0, 100] call BIS_fnc_findSafePos;
		_opforVic = [_pos, 180, _rndtype, east] call BIS_fnc_spawnVehicle;
		// _dir = random 359;
		// _opforVic setDir _dir;
		sleep 0.5;						
	};
};

if (_hardDiff) then {
	// 2 mraps and 2 tanks 
	for "_i" from 1 to 2 do {
		_rndtype = selectRandom [
			"O_R_APC_Wheeled_02_rcws_v2_ard_F",
			"O_R_APC_Tracked_02_medical_ard_F",
			"O_R_APC_Tracked_02_cannon_ard_F",
			"O_R_Truck_03_fuel_ard_F",
			"O_R_Truck_02_fuel_ard_F",
			"O_R_Truck_02_ard_F",
			"O_R_Truck_02_MRL_ard_F"
		];
		_pos = [_missionPos, 0, 100] call BIS_fnc_findSafePos;
		_opforVic = [_pos, 180, _rndtype, east] call BIS_fnc_spawnVehicle;
		// _dir = random 359;
		// _opforVic setDir _dir;
		sleep 0.5;						
	};
	for "_i" from 1 to 2 do {
		_rndtype = selectRandom [
			"O_R_MBT_04_command_ard_F",
			"O_R_MBT_04_cannon_ard_F",
			"O_R_MBT_02_cannon_ard_F"
		];
		_pos = [_missionPos, 0, 100] call BIS_fnc_findSafePos;
		_opforVic = [_pos, 180, _rndtype, east] call BIS_fnc_spawnVehicle;
		// _dir = random 359;
		// _opforVic setDir _dir;
		sleep 0.5;						
	};
};

// to-do check for fired weapon and move opfor towards pos 

// check for opfor alive 
_SADMISSION = true; 

while {_SADMISSION} do {
		
	// get overall numbers of troops in redzone 
	_unitsRedzone = allUnits inAreaArray "KILLZONE";

	// check indi and opfor numbers in redzone 
	_redzoneBlufor = 0;
	_redzoneOpfor = 0; 
	{
		switch ((side _x)) do
		{
			case WEST: {_redzoneBlufor = _redzoneBlufor + 1};
			case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
		};
	} forEach _unitsRedzone;

	// debug stats 
	systemChat format ["REDZONE WEST: %1", _redzoneBlufor];
	systemChat format ["REDZONE EAST: %1", _redzoneOpfor];

	// STAGE WIN LOGIC 
	if ((_redzoneOpfor < 3) && (_redzoneBlufor > 1)) then {
		hint "mission won";
		// regroup, healup and get prizes
		_SADMISSION = false;
	};

	sleep 10;
};

// deleteAll checks here - ensure no players near 
_anchorPos = getMarkerPos 'KILLZONE';
_deleteCheck = true;
while {_deleteCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 200) then {
			_dataStore pushback _x;
			systemChat format ["debug - pushing back based on %1 value", _dist]
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt == 0) then {
		systemChat "there no players within 200m of obj - safe to delete";
		[_anchorPos] call RGGd_fnc_Delete_AllWithinArea;
		_deleteCheck = false;
		// set up new mission 
		KILLZONE = false;
		deleteMarker "KILLZONE";

		sleep 10;

		systemChat "STARTING NEW KILLZONE MISSION"; // add voice here 
		_pos = getPos ammo1; // Pathfinder
		[_pos] spawn RGGm_fnc_mission_seekAndDestroy;
	} else {
		_deleteCheck = true;
		systemChat "players are near - do not delete";
	};

	sleep 5; // cycle frequency 
};




