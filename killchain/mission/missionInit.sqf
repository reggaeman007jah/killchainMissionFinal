/*
From: initServer.sqf 

Plan:
Create points to patrol based on mission-placed markers - this gives mission-maker control without needing to open a script  

Mission Marker names are as follows: 
killchainObj1, killchainObj1, killchainObj1, killchainObj1, killchainObj1, killchainObj1, killchainFinal

to-do:
Replace:
// ONEPOINT = false;
// TWOPOINT = false;
// THREEPOINT = false;
System with more simple system 

*/

systemChat "cold-zone system activated - go to the office to start the mission";

// this is to enable player-controlled mission start 
waitUntil { (KILLCHAINMISSIONSTART == true) };


// initialise counter system 
// execVM "killchain\systems\countingSystems\counter.sqf";

// // initialise mh-6 pickup scripts 
// execVM "killchain\systems\pickupSystems\pickUpSystems1\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\pickUpSystems2\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\pickUpSystems3\pickupInit.sqf";
// note: these are triggered elsewhere to enable system without being part of Killchain mission  

// // initialise para spawner script 
// execVM "killchain\systems\spawnerSystems\spawnParas.sqf";
// note: this triggered elsewhere to enable system without being part of Killchain mission 

// mission bool 
KILLCHAINISLIVE = true;

// voice bools 
COMMANDSPEAKING = false;
// this should ensure that second-level (random) voice alerts do not speak over mission-progression voice alerts 

// enables HK Team as default 
// HUNTERKILLER = true;
// to turn off, use debug console for now, until think of better way 
// removed as is already delcared in initServer 

// enables shushing of command woman 
BESILENT = false;
// if this is false, then command lady will speak, turn to TRUE on console to silence her 

// mission state 
monitorDefence = false;
// to-do - check what this bool does 

// base-counter var for tracking how many missions have been completed 
patrolPointsTaken = 0;
publicVariable "patrolPointsTaken";
// this will be key to progression in mission 

// flybyIsActive 
flybyIsActive = true;
// this helps to ensure an orderly spawning of ambient aircraft 

// field bases array
RGG_fieldbases = [];
// TBC what does this hold and what is it used for?

// campItems 
RGG_CampItems = [];
// used to store and then delete camp data 

// respawn location store 
RGG_respawnStore = [];
// used to manage the last-point-spawn system 

// mission status 
MISSIONTASK = "Setting up initial patrol";
publicVariable "MISSIONTASK";
// there are a few different stages of the mission, these states will track the current task 
// to do - confirm what purpose MISSIONTASK does 

// gather all patrol point position data from mission markers 
RGG_PatrolPoints = [];
for [{private _i = 1}, {_i < 7}, {_i = _i + 1}] do {
    private _marker = format ["killchainObj%1", _i];
	RGG_PatrolPoints pushBack (getMarkerPos _marker);
};
RGG_PatrolPoints pushBack (getMarkerPos "killchainFinal");

// trigger indifor markers 
// execVM "killchain\systems\markerSystems\indiforMarkers.sqf";
// removed on march 05 2021

// reinstated to test further - later march 2021
execVM "killchain\systems\markerSystems\indiforMarkers.sqf";

// commence mission 
execVM "killchain\mission\missionStart.sqf";
systemChat "RUNNING PHASE 1";


// _killchainObj1 = getMarkerPos "killchainObj1";
// _killchainObj2 = getMarkerPos "killchainObj2";
// _killchainObj3 = getMarkerPos "killchainObj3";
// _killchainObj4 = getMarkerPos "killchainObj4";
// _killchainObj5 = getMarkerPos "killchainObj5";
// _killchainObj6 = getMarkerPos "killchainObj6";
// _killchainFinal = getMarkerPos "killchainFinal";
// RGG_PatrolPoints = [];
// RGG_PatrolPoints pushBack _killchainObj1;
// RGG_PatrolPoints pushBack _killchainObj2;
// RGG_PatrolPoints pushBack _killchainObj3;
// RGG_PatrolPoints pushBack _killchainObj4;
// RGG_PatrolPoints pushBack _killchainObj5;
// RGG_PatrolPoints pushBack _killchainObj6;
// RGG_PatrolPoints pushBack _killchainFinal;
// here RGG_PatrolPoints holds 6 patrol points and 1 end point 

// roamers 
// execVM "killChain\systems\randomThreatSystems\randomThreats.sqf";
// note: Roamers are triggered during phases

