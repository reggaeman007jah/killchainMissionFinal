_player = _this select 0; // owner of CPD Team 
_shieldTeam = _this select 1; // CPD Team

systemChat "running protectPlayer";
"MP debug - running protectPlayer" remoteExec ["systemChat", 0, true];

systemChat format ["debug - _player: %1 cpd: %2", _player, _shieldTeam];
format ["MP debug - _player: %1 cpd: %2", _player, _shieldTeam] remoteExec ["systemChat", 0]; 

sleep 5;

systemChat "running cycleCheck";
"MP debug - running cycleCheck" remoteExec ["systemChat", 0, true];

// storage container to track whether player has moved enough to warrant CPD move progression 
_dataStore = [];
_playerPos = getPos _player;
_dataStore pushback _playerPos;
// here ^^ we have an initial position from which to make more movement decisions 

_cycle = true; // while true, CPD will move relative to player 

while {_cycle} do {
	_count = count units _shieldTeam;
	if (_count > 0) then {
		// ie CPD has fighting units 
		_shieldTeam setFormation "line";
		_curr = getPos _player;
		_prev = _dataStore select 0;
		_dist = _prev distance _curr;
		if (_dist > 5) then {
			// after this works we need to decide whether to retain relPos, or use direction between old and new pos, to enable walking backwards and still have CPD advance in movement direction, not look direction...
			_endPoint1 = _player getRelPos [40,0];
			_shieldTeam move _endPoint1; 
			_shieldTeam setFormation "line";
			// combat stance 		
		} else {
			// middle stance 
			// spread out, look in all directions 
			// _shieldTeam setFormation "DIAMOND";
		};
		_dataStore = []; // clean out 
		_dataStore pushback _curr;
	} else {
		_cycle = false;
		"CPD Team is all dead" remoteExec ["systemChat", 0, true];
	};
	sleep 5;
};
