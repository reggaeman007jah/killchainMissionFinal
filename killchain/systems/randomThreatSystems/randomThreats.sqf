/*
From: initServer.sqf 

this will not run always, rather be triggered during one or both of the stage loops 
it takes next available point as anchor point 
does not run during endGame 

The _anchor is the next patrol point .. to avoid a boring train of incoming from roughly the same dir, we need 
to spead out other anchors from the base anchor, far enough away while not spawning under players (hopefully)
To do this, we want a t-shape .. so get heading from _anchor to defend-point  
Then work out 90 and 270 relative to the defend-point  
Then get two more anchors ... this is the idea, to be done anotehr time 
For now, just pick a random dir and dist from _anchor .. good enough for now 

spawn random groups of 3 or 4, on outer reaches of battlezone, and send them in 
*/

if (patrolPointsTaken > 0 ) then {
	// this will avoid base spawwning on mission start 
	systemChat "debug - delete when tested - roamers activated";
	_anchor = _this select 0;
	_target = _this select 1;

	// get pos in battlezone outer edges 
	_randomEnemySpawnPos = [_anchor, 500, 600, 3, 0, 0, 0] call BIS_fnc_findSafePos; 

	// voice alerts 
	// [_randomEnemySpawnPos] execVM "killchain\systems\alertSystems\roamerAlerts.sqf";
	// 05 march 2021 - removing the above alert for now 
	systemChat format ["enemy roamers spawned: %1", _randomEnemySpawnPos]; 

	// create randoms 
	_opforClass = [
		"O_G_Soldier_A_F",
		"O_G_Soldier_AR_F",
		"O_G_medic_F",
		"O_G_engineer_F",
		"O_G_Soldier_exp_F",
		"O_G_Soldier_GL_F",
		"O_G_Soldier_M_F",
		"O_G_officer_F",
		"O_G_Soldier_F",
		"O_G_Soldier_LAT_F",
		"O_G_Soldier_LAT2_F",
		"O_G_Soldier_lite_F",
		"O_G_Sharpshooter_F",
		"O_G_Soldier_SL_F",
		"O_G_Soldier_TL_F"
	];
	_opforGroup = createGroup [east, true];
	_opforTeam = [];
	_base = 6;
	_random = random 6;
	_size = _base + _random + patrolPointsTaken; // 

	for "_i" from 1 to _size do {
		_unit = selectRandom _opforClass;
		_unit1 = _opforGroup createUnit [_unit, _randomEnemySpawnPos, [], 0.1, "none"];
		_opforTeam pushBack _unit1;
	};

	_dist = random 30;
	_dir = random 359;
	_unitDest = _target getPos [_dist, _dir];
	_opforTeam doMove _unitDest;

	// _opforTeam setFormation "diamond";
	// why not work?
	// spawnedIndiUnit = spawnedIndiUnit + _groupSize;

	// TODO - WORK OUT HOW TO MAKE DIAMOND FORMATION
};
