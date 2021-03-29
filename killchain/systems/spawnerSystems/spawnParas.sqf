/*
From: initServer.sqf 

Note:
This should be improved to use waitUntil - waitUntil units inAreaArray == 0 
This was yu can reduce the background checks, and also make the subsequent groups appear quickly - good for when there is more than one heli doing pickup 

*/

// this will spawn a fireteam contantly, and only respawn another team when the previous one has been removed from the "pz1" marker area 
sleep 10;

// systemChat "para spawner activated";
// "recon para spawner activated" remoteExec ["systemChat", 0, true];	
// sleep 1;

// todo - make this only happy when players are nearby 

while {true} do {

	_units = allUnits inAreaArray "pz1";
	_spawn = [15074,17244];

	_unitCount1 = count _units;

	if (_unitCount1 == 0) then {
		_float = diag_tickTime;
		_stampToString = str _float;
		_stampToString = createGroup [west, true];
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_AR_F" createUnit [_spawn, _stampToString]; 
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_LAT_F" createUnit [_spawn, _stampToString]; 
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_Sharpshooter_F" createUnit [_spawn, _stampToString]; 
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_TL_F" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_TL_F" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		for "_i" from 1 to 1 do { 
			"B_Soldier_TL_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_support_GMG_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_support_AMG_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_Soldier_TL_F" createUnit [_spawn, _stampToString];  
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_support_MG_F" createUnit [_spawn, _stampToString];  
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"B_support_AMG_F" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		_stampToString move [15123.5,17202.7,0];
		_stampToString setFormation "DIAMOND";
		
		systemChat "recon squaddies ready .............................................!";
	};

	sleep 20;
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