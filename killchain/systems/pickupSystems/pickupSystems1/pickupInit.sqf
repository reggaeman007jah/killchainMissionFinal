/*
From: initServer.sqf 
*/

waitUntil { isEngineOn transport1a; }; 
execVM "killchain\systems\pickupSystems\pickupSystem1\pickup.sqf";