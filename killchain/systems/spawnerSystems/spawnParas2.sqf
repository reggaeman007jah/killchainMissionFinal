/*
From: initServer.sqf 

Note:
This should be improved to use waitUntil - waitUntil units inAreaArray == 0 
This was yu can reduce the background checks, and also make the subsequent groups appear quickly - good for when there is more than one heli doing pickup 

BAF classes
"B_A_Soldier_SL_F",
"B_A_Soldier_AR_F",
"B_A_Soldier_GL_F",
"B_A_soldier_M_F",
"B_A_Soldier_AT_F",
"B_A_Soldier_AAT_F",
"B_A_Soldier_A_F",
"B_A_Medic_F",
"B_A_Soldier_AT_F",
"B_A_Medic_F"

*/

// this will spawn a fireteam contantly, and only respawn another team when the previous one has been removed from the "pz1" marker area 
sleep 10;

systemChat "para spawner 2 activated";
// "recon para spawner activated" remoteExec ["systemChat", 0, true];	
// sleep 1;

// todo - make this only happy when players are nearby 

while {true} do {

	_units = allUnits inAreaArray "pz2";
	_spawn = [15099,17262.3,0.0992565];
	_unitCount2 = count _units;

	if (_unitCount2 == 0) then {
		_float = diag_tickTime;
		_stampToString = str _float;
		_stampToString = createGroup [west, true];
		for "_i" from 1 to 1 do { 
			"B_A_Soldier_SL_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Soldier_AR_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Soldier_GL_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_soldier_M_F" createUnit [_spawn, _stampToString];  
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Soldier_AT_F" createUnit [_spawn, _stampToString];  
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Soldier_AAT_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Soldier_A_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Medic_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Soldier_AT_F" createUnit [_spawn, _stampToString];  
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_A_Medic_F" createUnit [_spawn, _stampToString];  
			sleep 0.1;
		};

		_stampToString move [15137.7,17229.8,0];
		_stampToString setFormation "DIAMOND";
		
		systemChat "DEBUG - recon squaddies 2 ready .............................................!";
	};

	sleep 30;
};

		// for "_i" from 1 to 1 do { 
		// 	// "B_W_Soldier_A_F" createUnit [[15074,17244], _indiGroup]; 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_AR_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_LAT_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_Sharpshooter_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_TL_F B_W_Recon_GL_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_TL_F B_W_Recon_GL_F
		// 	sleep 0.1;
		// };