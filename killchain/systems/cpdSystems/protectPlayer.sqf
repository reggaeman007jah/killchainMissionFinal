_player = _this select 0;
_shieldTeam = _this select 1;

systemChat "running protectPlayer";
systemChat format ["debug - _player: %1 cpd: %2", _player, _shieldTeam];
format ["debug - _player: %1 cpd: %2", _player, _shieldTeam] remoteExec ["systemChat", 0]; // ?

sleep 5;

_cycle = true;
while {_cycle} do {
	_count = count units _shieldTeam;
	if (_count > 0) then {
		_endPoint1 = _player getRelPos [100,0];
		_shieldTeam move _endPoint1; 
	} else {
		_cycle = false;
	};
	sleep 15;
};
