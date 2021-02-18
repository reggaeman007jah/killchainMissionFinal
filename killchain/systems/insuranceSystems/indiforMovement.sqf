
_objPos = _this select 1; // objective point for any new mission 
sleep 180; // no need to run this system straight away 

while {RFCHECK} do {
	
	_indi = [];
	_units = allUnits inAreaArray "objective 1";

	{ if ((side _x) == INDEPENDENT) then {_indi pushBack _x} } forEach _units;

	{
		_randomDir = selectRandom [270, 310, 00, 50, 90];
		_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
		_unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
		_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
		sleep 2;
		_x setBehaviour "COMBAT";
		_x doMove _endPoint1;
	} forEach _indi;

	sleep 180;
};

// not currently used - test to see if still needed!