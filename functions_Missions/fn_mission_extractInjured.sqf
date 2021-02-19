/*
This function generates a random medevac mission 

To-do:
This is nowhere near finished!!

*/

// gen random pos 
// gen units + injured units 
// gen marker 
systemChat "RUNNING - missions_extractInjured";

_areaCenter = [10000,3000];
_extractPos = [_areaCenter, 10, 3000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

_medevacPos = createMarker ["EXTRACT", _extractPos];
_medevacPos setMarkerShape "ELLIPSE";
_medevacPos setMarkerColor "ColorRed";
_medevacPos setMarkerSize [50, 50];
// _barracksDZ setMarkerAlpha 0.5;

_medevacPos1 = createMarker ["PZ", _extractPos];
_medevacPos1 setMarkerShape "ELLIPSE";
_medevacPos1 setMarkerColor "ColorRed";
_medevacPos1 setMarkerSize [5, 5];




// _indiGroup = createGroup independent;
for "_i" from 1 to 10 do {
	_indiGroup = createGroup independent;
	_unit = _indiGroup createUnit ["I_soldier_F", _extractPos, [], 0.1, "none"]; 
	_randomMovePos = [ ["EXTRACT"] ] call BIS_fnc_randomPos;
	_unit doMove _randomMovePos;
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;

	sleep 2;
};

_injured = selectRandom [2,3,4,5,6,7];

for "_i" from 1 to _injured do {
	_indiGroup = createGroup independent;
	// _randomMovePos = [ ["EXTRACT"] ] call BIS_fnc_randomPos;
	_unit = _indiGroup createUnit ["I_soldier_F", _extractPos, [], 0.1, "none"]; 
	// _unit doMove _randomMovePos; Item_Medikit
	_unit removeItem "Item_Medikit";
	_unit removeItem "Item_Medikit";
	_unit removeItem "Item_Medikit";
	_unit setDamage 0.9;

	sleep 2;
};

_injured = allUnits inAreaArray "PZ";

sleep 10;

{
	_x setDamage 0.9;
	
} forEach _injured;
// I do this ^^ bc when you spawn an injured unit the heal as soon as they spawn in .. so this is a hacky way around that issue 

