/*
This function generates a random medevac mission 

To-do:


decide what anchor this should use - for now we can try to use Pathfinder 

or use the container drop system to enable players to decide where their medical FOB is 
this could also trigger the mission - PLUS - it might enable usage during a full killchain session by having a medical base near to the action 

side note - can you disable death and instead have a one-life system with AIS, to enforce medevac back to base for real heal? 

players get a notification with a location - go to 1234 1234 for pickup of walking wounded 

side note - can also enable ammo drops using similar system 

side note - dont forget padre system - dialog to request pickup, drop off, cas, ammo drop, medevac, patrol, scout etc 

side note - dont forget LZ assist - global system to share locational data across helis 

side note - dont forget in-air tracking, to track speed, heading and owner of heli nearby 

you go there 

injured boards heli 

defensive perimiter is there already 

spawn in enemy on approach 

set damage false on all units in that area - this is an effect thing 

ensure lots of machine gunners on both sides 

when near - auto smoke nearby 

when land - injured board 

take off and land at medi-base where they disembark and head into medi tent 

have white coats come out to greet also - like mash 

build system to nuke all when no players are near 

*/

// gen random pos 
// gen units + injured units 
// gen marker 
systemChat "DEBUG - RUNNING: missions_extractInjured";

// this should be informed by the dropping of a medical container 
// container drop should build a medical FOB 
// medical FOB is then the anchor for missions 
// missions must always be at least 1km away from anchor, no more than 4km 

_areaCenter = _this select 0;

_extractPos = [_areaCenter, 1000, 3000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

_medevacPos = createMarker ["EXTRACT", _extractPos];
_medevacPos setMarkerShape "ELLIPSE";
_medevacPos setMarkerColor "ColorRed";
_medevacPos setMarkerSize [50, 50];
// replace this with voice markers 

_medevacPos1 = createMarker ["PZ", _extractPos];
_medevacPos1 setMarkerShape "ELLIPSE";
_medevacPos1 setMarkerColor "ColorRed";
_medevacPos1 setMarkerSize [5, 5];

for "_i" from 1 to 10 do {
	_indiGroup = createGroup west;
	_unit = _indiGroup createUnit ["I_soldier_F", _extractPos, [], 0.1, "none"]; 
	_randomMovePos = [ ["EXTRACT"] ] call BIS_fnc_randomPos;
	_unit doMove _randomMovePos;
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	sleep 2;
};

_injured = selectRandom [4,5,6,7,8];
for "_i" from 1 to _injured do {
	_indiGroup = createGroup west;
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
// I do this ^^ bc when you spawn an injured unit they heal as soon as they spawn in .. so this is a hacky way around that issue 

