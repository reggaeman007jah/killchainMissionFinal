/*
get anchor, find safePos or find wooded areas 
is there a sandbag mortar ?
*/

_startPos = _this select 0;

_grp = createGroup [east, true];
_pos = [_startPos, 0, 50] call BIS_fnc_findSafePos;
_unit = _grp createUnit ["o_g_soldier_ar_f", _pos, [], 1, "none"];
_static = "O_HMG_01_high_F" createVehicle _pos;
_unit moveInGunner _static;
_unit setBehaviour "COMBAT";
	







