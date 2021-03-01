
private _heliTrainer = _this select 0;
// systemChat format ["Passed: %1", _heli];

_heliTrainer addAction ["<t color='#FF0000'>Enable Damage</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target allowDamage true;
}];

_heliTrainer addAction ["<t color='#FF0000'>Disable Damage</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target allowDamage false;
}];

_heliTrainer addAction ["<t color='#FF0000'>Damage Tail Rotor</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setHitPointDamage ["HitVRotor", 1];
}];

_heliTrainer addAction ["<t color='#FF0000'>Damage Main Rotor</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setHitPointDamage ["HitHRotor", 1];
}];

_heliTrainer addAction ["<t color='#FF0000'>Kill Engine</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setFuel 0;
}];

_heliTrainer addAction ["<t color='#FF0000'>Refuel Engine</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	// _gas = fuel _heliTrainer;
	_target setFuel 1;
	systemChat "starting engine";
}];

_heliTrainer addAction ["<t color='#00FF00'>Go Fast and North</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setVelocity [0, 80, 0];
}];



_heliTrainer addAction ["<t color='#00FF00'>Fix It Up</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setDamage 0;
}];

_heliTrainer addAction ["<t color='#00FF00'>Set Height 200m</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[_target, 200] call BIS_fnc_setHeight;
}];

// _heli addAction ["<t color='#FF0000'>Generate Enemy Infi 300m North</t>", {
// \_pos = _heli getPos [300, 0];
// \_group1 = createGroup EAST;
// \_unit1 = \_group1 createUnit ["O_Soldier_F", \_pos, [], 10, "NONE"];
// }];

// _heli addAction ["<t color='#FF0000'>Generate Enemy APC 600m North</t>", {
// 	_pos = hel_helii1 getPos [600, 0];
// 	_jeep = "O_R_APC_Wheeled_02_rcws_v2_ard_F" createVehicle \_pos;
// }];

// _heli addAction ["<t color='#0000FF'>REARM</t>", {
// 	heli1 setVehicleAmmo 1;
// }];