systemChat "debug - delete when tested - technicals activated";
_anchor = _this select 0;
_target = _this select 1;

private ["_num", "_delay"]; 

switch (patrolPointsTaken) do {
	case 1: { _num = 1; _delay = 0; };
	case 2: { _num = 1; _delay = 0; };
	case 3: { _num = 2; _delay = 180; };
	case 4: { _num = 2; _delay = 120; };
	case 5: { _num = 3; _delay = 60; };
	case 6: { _num = 3; _delay = 30; };
	default { systemChat "zero patrol points - no technicals" };
};

for "_i" from 1 to _num do {
	_pos = [_anchor, 0, 40] call BIS_fnc_findSafePos;
	_opforVic = [_pos, 180, "O_G_Offroad_01_armed_F", east] call BIS_fnc_spawnVehicle;
	_opforVic doMove _target;
	sleep _delay;
};
