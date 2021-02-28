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
systemChat "DEBUG - RUNNING: missions_extractInjured";

_areaCenter = _this select 0; // should be Pathfinder, but could also be a patrol point, or any thing else 
_welcomeParty = selectRandom [1,2,3]; // decides what is happening on approach to area and how players are welcomed 

_missionPos = [_areaCenter, 4000, 5000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

_pos1 = createMarker ["BATTLEZONE", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerSize [50, 50];
// replace this with voice markers  

// _pos2 = createMarker ["PZ", _extractPos];
// _pos2 setMarkerShape "ELLIPSE";
// _pos2 setMarkerColor "ColorRed";
// _pos2 setMarkerSize [5, 5];

// add marker icon here 

// find location for opfor comms base - need to destroy this base in order to stop RF 
_opforBase = [_missionPos, 750, 1000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

// debug marker 
_pos3 = createMarker ["ENEMYBASE", _missionPos];
_pos3 setMarkerShape "ELLIPSE";
_pos3 setMarkerColor "ColorRed";
_pos3 setMarkerSize [50, 50];

for "_i" from 1 to 20 do {
	_group = createGroup west;
	_unit = _group createUnit ["I_soldier_F", _pos1, [], 0.1, "none"]; 
	_randomMovePos = [ ["BATTLEZONE"] ] call BIS_fnc_randomPos;
	_unit doMove _randomMovePos;
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;

	systemChat "blufor unit created";
	sleep 1;
};

// enable time to get into position  
sleep 30;

// freeze blufor unit behaviour 
_allUnits = allUnits inAreaArray "BATTLEZONE";
{
	_x disableAI "AUTOTARGET";
	_x disableAI "MOVE";
} forEach _allUnits;

// create welecome party 
for "_i" from 1 to 20 do {
	_group = createGroup east;
	_dist = 200;
	_dir = random 359;
	_spawnPos = _missionPos getPos [_dist, _dir];

	_unit = _group createUnit ["I_soldier_F", _spawnPos, [], 0.1, "none"]; 
	_unit disableAI "AUTOTARGET"; // this assumes ambush setting is on 
	_unit setUnitPos "DOWN";
	_unit disableAI "MOVE"; 

	systemChat "opfor unit created";
	sleep 1;
};

// https://community.bistudio.com/wiki/setTriggerActivation
_trg = createTrigger ["EmptyDetector", _missionPos, true];
// _trg setTriggerArea [5, 5, 0, false];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false]; // one-off 

if (triggerActivated _trg) then {
	// kick off firefight 
	_allUnits = allUnits inAreaArray "BATTLEZONE";
	{
		_x enableAI "AUTOTARGET";
		_x enableAI "MOVE";
		_x setBehaviour "COMBAT";
		_x setUnitPos "AUTO";
	} forEach _allUnits;
};

// checkpoint - does this all work so far?

// build camp 
[_opforBase] call RGG_fnc_2_build_opforCamp;

// check - does base appear ok ?

// to-do ... spawn and send in troops while base is alive 