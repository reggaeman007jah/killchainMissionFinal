_player = _this select 0;
_sheildTeam = _this select 1;

systemChat "running protectPlayer";
systemChat format ["debug - _player: %1 cpd: %2", _player, _shieldTeam];

sleep 5;

_cycle = true;
while {_cycle} do {
	if (count (units AI_GROUP) < 3) then {
		_endPoint1 = _player getRelPos [100,0];
		_sheildTeam doMove _endPoint1; 
	} else {
		_cycle = false;
	};
	sleep 15;
};
