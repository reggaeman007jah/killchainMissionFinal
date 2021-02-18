/*
From: initServer.sqf 
*/

waitUntil { isEngineOn transport1a; }; 
execVM "autoPatrolSystem\pickupSystems\pickup.sqf";