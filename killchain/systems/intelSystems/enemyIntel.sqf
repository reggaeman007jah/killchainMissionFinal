// generate side-tasks when player near 
systemChat "enemy intel system running";

_dish = _this select 0;
_anchorPos = getPos _dish;

// wait until a player near 

_playersNotNear = true;

while {_playersNotNear} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 3) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt >= 1) then {
		// systemChat "players are near - create mini-mission";
		// decide on best anchor for mission and pass to creation script  
		
		// [] execVM "";
		[_anchorPos] spawn RGGm_fnc_mission_destroyRadar;
		_playersNotNear = false;
	};

	sleep 10; 
};

