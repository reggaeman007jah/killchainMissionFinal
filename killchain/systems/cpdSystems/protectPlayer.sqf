_player = _this select 0;
_shieldTeam = _this select 1;

systemChat "running protectPlayer";
"MP debug - running protectPlayer" remoteExec ["systemChat", 0, true];

systemChat format ["debug - _player: %1 cpd: %2", _player, _shieldTeam];
format ["MP debug - _player: %1 cpd: %2", _player, _shieldTeam] remoteExec ["systemChat", 0]; 

sleep 5;

systemChat "running cycleCheck";
"MP debug - running cycleCheck" remoteExec ["systemChat", 0, true];

_cycle = true;
while {_cycle} do {
	_count = count units _shieldTeam;
	if (_count > 0) then {
		systemChat "CPD moving";
		"MP debug - CPD moving" remoteExec ["systemChat", 0, true];
		_endPoint1 = _player getRelPos [100,0];
		_shieldTeam move _endPoint1; 
	} else {
		_cycle = false;
		systemChat "CPD cycle false";
		"MP debug - CPD cycle false" remoteExec ["systemChat", 0, true];
	};
	sleep 15;
};

// "MP MSG there are %1 waves incoming" remoteExec ["systemChat format", 0, true];
// format ["Intel suggests %1 ", _numberOfAttackers] remoteExec ["hint", 0];
// format ["The Patrol has been compromised, with %1 units", RGG_redzoneIndi] remoteExec ["hint", 0];
