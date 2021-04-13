systemChat "debug - delete when tested - technical spawner activated";
_anchor = _this select 0;
_target = _this select 1;

_assets = [
	"CUP_B_Hilux_AGS30_BLU_G_F",
	"CUP_B_Hilux_BMP1_BLU_G_F",
	"CUP_B_Hilux_btr60_BLU_G_F",
	"CUP_B_Hilux_DSHKM_BLU_G_F",
	"CUP_B_Hilux_igla_BLU_G_F",
	"CUP_B_Hilux_M2_BLU_G_F",
	"CUP_B_Hilux_metis_BLU_G_F",
	"CUP_B_Hilux_MLRS_BLU_G_F",
	"CUP_B_Hilux_SPG9_BLU_G_F",
	"CUP_B_Hilux_UB32_BLU_G_F",
	"CUP_B_Hilux_zu23_BLU_G_F",
	"CUP_B_Hilux_armored_AGS30_BLU_G_F",
	"CUP_B_Hilux_armored_BMP1_BLU_G_F",
	"CUP_B_Hilux_armored_BTR60_BLU_G_F",
	"CUP_B_Hilux_armored_DSHKM_BLU_G_F"
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
