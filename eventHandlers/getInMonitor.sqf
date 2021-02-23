/*
this script manages smoke actions while in heli 
*/

// this addEventHandler ["GetInMan", {
// 	params ["_unit", "_role", "_vehicle", "_turret"];
// }];

transport1a addEventHandler ["getInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	[_unit] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
}];

transport2a addEventHandler ["getInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	[_unit] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
}];

transport3a addEventHandler ["getInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	[_unit] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
}];



/*
bigHeli1 addEventHandler ["RopeBreak", {
	params ["_object1", "_rope", "_object2"];
	
	// this did not work ... make it work! 
	
	// switch (_object2) do {
	// 	case (typeOf _object2 == "B_Slingload_01_Medevac_F"): {
	// 		systemChat "Med-Base Deployed:"; 
	// 		[_object2, "B_Slingload_01_Medevac_F"] spawn RGGb_fnc_build_bluforMedbase; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case (typeOf _object2 == "B_Slingload_01_Ammo_F"): {
	// 		systemChat "Barracks Deployed"; 
	// 		[_object2, "B_Slingload_01_Ammo_F"] spawn RGGb_fnc_build_bluforBarracks; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case "I_supplyCrate_F": {
	// 		systemChat "Supplies Deployed"; 
	// 		[_object2, "I_supplyCrate_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case "CargoNet_01_barrels_F": {
	// 		systemChat "Fuel Deployed"; 
	// 		[_object2, "CargoNet_01_barrels_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case "I_CargoNet_01_ammo_F": {
	// 		systemChat "Ammo Deployed"; 
	// 		[_object2, "I_CargoNet_01_ammo_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	default { systemChat "Error: no suitable object found in rope break EH"; };
	// };

	// ----- BASES ----- //

	// supply base 
	if (typeOf _object2 == "B_Slingload_01_Cargo_F") then { 
		systemChat "Supply Depot Deployed"; 
		[_object2, "B_Slingload_01_Cargo_F"] spawn RGGb_fnc_build_bluforSupplyDepot; // NOTE - test theory that you do not need this second arg !!
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// barracks 
	if (typeOf _object2 == "B_Slingload_01_Ammo_F") then { 
		systemChat "Barracks Deployed"; 
		[_object2, "B_Slingload_01_Ammo_F"] spawn RGGb_fnc_build_bluforBarracks; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// med-base 
	if (typeOf _object2 == "B_Slingload_01_Medevac_F") then { 
		systemChat "Med-Base Deployed:"; 
		[_object2, "B_Slingload_01_Medevac_F"] spawn RGGb_fnc_build_bluforMedbase; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// workshop-base 
	if (typeOf _object2 == "B_Slingload_01_Fuel_F") then { 
		systemChat "workshop-Base Deployed:"; 
		[_object2, "B_Slingload_01_Fuel_F"] spawn RGGb_fnc_build_bluforWorkshop; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// ----- SUPPLIES ----- //

	// food 
	if (typeOf _object2 == "I_supplyCrate_F") then { 
		systemChat "Supplies Deployed"; 
		// here we apply a check to see if the respawn system is active (processing respawns)
		// we only call this is the queue is empty 
		if (!RESPAWNQUEUE) then {
			[] spawn RGGs_fnc_spawn_bluforSentryRespawnQueue; // triggers the sentry respawn checking process 
		};
		[_object2, "I_supplyCrate_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};
	
	// fuel 
	if (typeOf _object2 == "CargoNet_01_barrels_F") then { 
		systemChat "Fuel Deployed"; 
		[_object2, "CargoNet_01_barrels_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// ammo 
	if (typeOf _object2 == "I_CargoNet_01_ammo_F") then { 
		systemChat "Ammo Deployed"; 
		[_object2, "I_CargoNet_01_ammo_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

}];