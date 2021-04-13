systemChat "debug - delete when tested - technical spawner activated";
_anchor = _this select 0;
_target = _this select 1;

_assets = [
	"I_G_Offroad_01_armed_F"
];

// private ["_num", "_delay"]; 
_num = 0;
_delay = 0;

switch (patrolPointsTaken) do {
	case 1: { _num = 1; _delay = 0; };
	case 2: { _num = 1; _delay = 0; };
	case 3: { _num = 2; _delay = 20; };
	case 4: { _num = 2; _delay = 60; };
	case 5: { _num = 3; _delay = 120; };
	case 6: { _num = 4; _delay = 10; };
	default { systemChat "zero patrol points - no technicals" };
};

for "_i" from 1 to _num do {
	_pos = [_anchor, 0, 100] call BIS_fnc_findSafePos;
	_type = selectRandom _assets;
	_opforVic = [_pos, 180, _type, east] call BIS_fnc_spawnVehicle;
	_opforVic doMove _target;
	sleep _delay;
};
