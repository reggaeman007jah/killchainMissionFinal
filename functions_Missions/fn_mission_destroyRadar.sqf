
/*
Create dish and bunker, close to eachother 
Spawn defensive opfor units - number based on amount of players near trigger zone 
Options:
- Spawn item within base for demo - Create watch system to track if item !alive 
- Have a backpck that can show opfor positions / deploy radar dish 
- need more ideas 

*/

systemChat "DEBUG - RUNNING: missions_destroyRadar";
// to do - add voice system 
// to do - make good 

_areaCenter = _this select 0; // sat dish object from patrol point  

_assetsCamp = [
	"Land_BagBunker_01_large_green_F",
	"CamoNet_ghex_big_F",
	"Land_Cargo_HQ_V4_F",
	"Land_MedicalTent_01_CSAT_greenhex_generic_outer_F",
	"Land_PillboxBunker_01_hex_F",
	"Land_MobileRadar_01_radar_F"
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

// opfor RF 
_assetsInfiRF = [
	"O_R_soldier_AR_ard_F",
	"O_R_Soldier_GL_ard_F",
	"O_R_soldier_M_ard_F",
	"O_R_soldier_AT_ard_F",
	"O_R_Soldier_AAT_ard_F",
	"O_R_Soldier_A_ard_F",
	"O_R_medic_ard_F"
];

// light armour
_assetsMRAP = [
	"O_R_APC_Wheeled_02_rcws_v2_ard_F",
	"O_R_APC_Tracked_02_medical_ard_F",
	"O_R_APC_Tracked_02_cannon_ard_F",
	"O_R_Truck_03_fuel_ard_F",
	"O_R_Truck_02_fuel_ard_F",
	"O_R_Truck_02_ard_F",
	"O_R_Truck_02_MRL_ard_F"
];

// mission pos 
_missionPos = [_areaCenter, 6000, 6500, 10, 0, 1, 0] call BIS_fnc_findSafePos;

deleteMarker "KILLZONE";
_pos1 = createMarker ["KILLZONE", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerAlpha 0.3;
_pos1 setMarkerSize [2000, 2000];
// add voice markers  

// call marker icon function  
KILLZONE = true; // for marker system 
[_missionPos, "hd_objective", "KILLZONE_Marker", "colorRed"] spawn RGGe_fnc_effects_markersSAD;

// hold - check/wait for player(s) near 
_anchorPos = getMarkerPos 'KILLZONE';
_activateCheck = true;

while {_activateCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 2500) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt >= 1) then {
		systemChat "players are near - radar mission activated";
		_activateCheck = false;
	};

	sleep 20; // cycle frequency 
};

// create items 
systemChat "debug - creating items";

_assetPos = [];
{
	_dist = random 100;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];
	_thing = _x createVehicle _thingPos;
	_thing setDir _dir;
	_assetPos pushBack _thingPos;
	sleep 0.5;
} forEach _assetsCamp;

// RF anchor 
_opforSpawnPos = _assetPos select 0;
// _opforSpawnPos = getPos _opforBase;

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
	// _opforVic setDir _dir; cc
	sleep 0.5;						
};

// to-do check for fired weapon and move opfor towards pos 

// check for opfor alive 
_RADARMISSION = true; 

while {_RADARMISSION} do {
		
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

	// mid-point opfor RF 
	if ((_redzoneOpfor < 10) && (_redzoneBlufor > 1)) then {
		hint "opfor RF inbound";
		// find nearest player 
		_dataStore = [];
		{
			_playerPos = getPos _x;
			_dist = _anchorPos distance _playerPos;

			if (_dist < 1500) then {
				_dataStore pushback _x;
			};
		} forEach allPlayers;

		// make sure this only happens if players are near 
		_nearPlayers = count _dataStore;
		if (_nearPlayers >= 1) then {
			_rfTarget = _dataStore select 0;
			_rfTargetPos = getPos _rfTarget;

			_opGroup = createGroup [east, true];
			{
				_unit = _opGroup createUnit [_x, _opforSpawnPos, [], 0.1, "none"]; 
				systemChat "creating RF unit here";
				systemChat str _opforSpawnPos;
				_unit doMove _rfTargetPos;
				systemChat "moving to player pos:";
				systemChat str _rfTargetPos;
				sleep 10;
			} forEach _assetsInfiRF;
		};
	};

	// STAGE WIN LOGIC 
	if ((_redzoneOpfor < 1) && (_redzoneBlufor > 1)) then {
		hint "mission won";
		// regroup, healup and get prizes
		_SADMISSION = false;
	};

	// debug stats 
	systemChat format ["REDZONE WEST: %1", _redzoneBlufor];
	systemChat format ["REDZONE EAST: %1", _redzoneOpfor];

	sleep 10;
};

// cleanup section - deleteAll checks happen here - ensure no players near before deleting everything 
_anchorPos = getMarkerPos 'KILLZONE'; // can delete? is this a duplicate?
_deleteCheck = true;

while {_deleteCheck} do {

	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 3000) then {
			_dataStore pushback _x;
			systemChat format ["debug - pushing back based on %1 value", _dist]
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt == 0) then {
		systemChat "there no players within 3km of obj - safe to delete";
		systemChat "mission now complete and can be deleted as no player proximity";
		[_anchorPos] call RGGd_fnc_Delete_AllWithinArea;
		_deleteCheck = false;
		// set up new mission 
		KILLZONE = false;
		deleteMarker "KILLZONE";

		sleep 10;

		// here we want to assign any reward or benefit to players as reward ...
	};

	sleep 5; // cycle frequency 
};

