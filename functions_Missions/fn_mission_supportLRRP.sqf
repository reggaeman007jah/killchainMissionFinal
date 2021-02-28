/*
An outer regions patrol has encountered a larger enemy force and need support 
This is a time-limited one-off situation, i.e. not a killchain mission

Mission trigger will gen a position far away - no easy RF 
spawn small indifor and much larger incoming opfor 
Get support in this area quickly - either run CAS around surrounded forces, or drop off players to support 

To win, you need to repell all incoming opfor 

to-do:
Sort out correct classes for mission 
decide when to change patrol stances to auto 
smoke on arrival - check whether any player is near to trigger 
set up bigger marker to declare - in voice - how many opfor are "in the wire"

make it so that fire can be in full effect on close prox, or totally quiet - and if quiet, either kicks off on landing full scale, or remains quiet 
so, three outcomes here 

*/
systemChat "DEBUG - RUNNING: missions_LRRP";

// _areaCenter = _this select 0; // should be Pathfinder, but could also be a patrol point, or any thing else 
_welcomeParty = selectRandom [1,2,3]; // decides what is happening on approach to area and how players are welcomed 

// the welcome party switch will determine if the ambush happens on landing, on approach, or whether opfor are way further out as heli approaches 
private "_trigActDist";
switch (_welcomeParty) do {
	case "1": { _trigActDist = 20 }; // waits for landing before ambush - so sets activation var to small - needs a z value here 
	case "2": { _trigActDist = 100 }; // triggers an attack on close approach - so sets activation var to medium
	case "3": { _trigActDist = 500 }; // triggers an attack on long approach - so sets activation var to large 
	default { systemChat "Switch Error _trogActDist" };
};



_missionPos = [5108,20058,0]; // hand picked location(s)

// _missionPos = [_areaCenter, 4000, 5000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

_pos1 = createMarker ["BATTLEZONE", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerSize [250, 250];
systemChat "DEBUG - Marker 1 made";
// replace this with voice markers  

// _pos2 = createMarker ["PZ", _extractPos];
// _pos2 setMarkerShape "ELLIPSE";
// _pos2 setMarkerColor "ColorRed";
// _pos2 setMarkerSize [5, 5];

// add marker icon here 

// find location for opfor comms base - need to destroy this base in order to stop RF 
_opforBase = [_missionPos, 750, 1000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

// debug marker 
// _pos3 = createMarker ["ENEMYBASE", _missionPos];
// _pos3 setMarkerShape "ELLIPSE";
// _pos3 setMarkerColor "ColorRed";
// _pos3 setMarkerSize [250, 250];

// systemChat "DEBUG - Marker 2 made";

for "_i" from 1 to 30 do {
	_group = createGroup west;
	_unit = _group createUnit ["B_A_Soldier_A_F", _missionPos, [], 0.1, "none"]; 
	_randomMovePos = [ ["BATTLEZONE"] ] call BIS_fnc_randomPos;
	_unit doMove _randomMovePos;
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	_unit setUnitCombatMode "BLUE";
	_unit setCaptive true;
	systemChat "blufor unit created";
	sleep 1;
};
systemChat "DEBUG - sleeping for 30";
// enable time to get into position  
sleep 10;

// freeze blufor unit behaviour 
_allUnits = allUnits inAreaArray "BATTLEZONE";
{
	// _x disableAI "AUTOTARGET";
	_x disableAI "MOVE";
} forEach _allUnits;
systemChat "DEBUG - disabled blufor AI";

// create welecome party 
for "_i" from 1 to 15 do {
	_group = createGroup east;
	_dist = selectRandom [150, 160, 170];
	_dir = random 359;
	_spawnPos = _missionPos getPos [_dist, _dir];
	
	_unit = _group createUnit ["O_G_Soldier_A_F", _spawnPos, [], 0.1, "none"]; 
	_unit setCaptive true;
	// _unit disableAI "AUTOTARGET"; // this assumes ambush setting is on 
	_unit setUnitPos "DOWN";
	// _unit disableAI "MOVE"; 
	// _unit setUnitCombatMode "BLUE";

	// _unit setDir [_unit, _missionPos] call BIS_fnc_dirTo;

	systemChat "opfor unit created";
	sleep 0.1;
};
systemChat "DEBUG - created opfor and disabled AI";

// smoke trigger 
_trgSmk = createTrigger ["EmptyDetector", _missionPos];
_trgSmk setTriggerArea [1000, 1000, 0, false];
_trgSmk setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trgSmk setTriggerStatements ["this", "
	_smoke = createVehicle ['G_40mm_smokeYELLOW', _missionPos, [], 0, 'none']; 
", "systemChat 'no player near'"];

// triggers 
// _trg = createTrigger ["EmptyDetector", _missionPos, true];
// _trg setTriggerArea [50, 50, 0, false];

// _trg setTriggerActivation ["ANYPLAYER", "PRESENT", false]; // i.e. one-off 
// systemChat "DEBUG - created trigger";

// if (triggerActivated _trg) then {
// 	// kick off firefight 
	// systemChat "DEBUG - created trigger activator";
	// _allUnits = allUnits inAreaArray "BATTLEZONE";
	// {
	// 	_x enableAI "AUTOTARGET";
	// 	_x enableAI "MOVE";
	// 	_x setBehaviour "COMBAT";
	// 	_x setUnitPos "AUTO";
	// 	_x setCaptive false;
	// } forEach _allUnits;
// };

attackNow = false;

_trg = createTrigger ["EmptyDetector", _missionPos];
_trg setTriggerArea [_trigActDist, _trigActDist, 0, false];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["this", "
	systemChat 'DEBUG - created trigger activator';
	_allUnitsX = allUnits inAreaArray 'BATTLEZONE';
	{
		_x enableAI 'MOVE';
		_x setBehaviour 'COMBAT';
		_x setCaptive false;
		_x setUnitPos 'AUTO';
	} forEach _allUnitsX;
	attackNow = true;
", "systemChat 'no player near'"];

waitUntil { attackNow; };
// I do this as for some reason, having two forEach loops was not working within the trigger statement 

// this section pushes opfor to rush the LZ, and sets up blufor into a defensive perimiter 
_allUnitsX = allUnits inAreaArray 'BATTLEZONE';
_opfor = [];
_blufor = [];
{
	if ((side _x) == EAST) then {
		_opfor pushBack _x;
	}; 
	if ((side _x) == WEST) then {
		_blufor pushBack _x;
	}; 
} forEach _allUnitsX;

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [10, 15, 20];
	_endPoint1 = _missionPos getPos [_randomDist,_randomDir];
	_x doMove _endPoint1;
	systemChat "a do move happened";
} forEach _opfor;

sleep 5;

systemChat str _blufor;
{
	_randomDir = random 359;
	_randomDist = selectRandom [20, 25, 30, 35];
	_endPoint1 = _missionPos getPos [_randomDist,_randomDir];
	_x doMove _endPoint1;
	systemChat "a blufor do move happened";
} forEach _blufor;


// wait until all opfor are killed, and then move out 

// build camp 
[_opforBase] call RGG_fnc_2_build_opforCamp;
systemChat "DEBUG - called opfor camp fnc";
// check - does base appear ok ?

// to-do ... spawn and send in troops while base is alive 

