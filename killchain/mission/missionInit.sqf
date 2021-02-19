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

// this is to enable player-controlled mission start 
waitUntil { (KILLCHAINMISSIONSTART == true) };

systemChat "cold-zone system activated - go to the office to start the mission";

// initialise counter system 
// execVM "killchain\systems\countingSystems\counter.sqf";

// initialise mh-6 pickup scripts 
execVM "killchain\systems\pickupSystems\pickUpSystems1\pickupInit.sqf";
execVM "killchain\systems\pickupSystems\pickUpSystems2\pickupInit.sqf";
execVM "killchain\systems\pickupSystems\pickUpSystems3\pickupInit.sqf";

// initialise para spawner script 
execVM "killchain\systems\spawnerSystems\spawnParas.sqf";

// voice bools 
COMMANDSPEAKING = false;
// this should ensure that second-level (random) voice alerts do not speak over mission-progression voice alerts 

// enables HK Team as default 
HUNTERKILLER = true;
// to turn off, use debug console for now, until think of better way 

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

// gather all patrol point position data from mission 
_killchainObj1 = getMarkerPos "killchainObj1";
_killchainObj2 = getMarkerPos "killchainObj2";
_killchainObj3 = getMarkerPos "killchainObj3";
_killchainObj4 = getMarkerPos "killchainObj4";
_killchainObj5 = getMarkerPos "killchainObj5";
_killchainObj6 = getMarkerPos "killchainObj6";
_killchainObjFinal = getMarkerPos "killchainObjFinal";
RGG_PatrolPoints = [];
RGG_PatrolPoints pushBack _killchainObj1;
RGG_PatrolPoints pushBack _killchainObj2;
RGG_PatrolPoints pushBack _killchainObj3;
RGG_PatrolPoints pushBack _killchainObj4;
RGG_PatrolPoints pushBack _killchainObj5;
RGG_PatrolPoints pushBack _killchainObj6;
RGG_PatrolPoints pushBack _killchainObjFinal;
// here RGG_PatrolPoints holds 6 patrol points and 1 end point 

// roamers 
// execVM "killChain\systems\randomThreatSystems\randomThreats.sqf";

// commence mission 
execVM "killchain\mission\missionStart.sqf";
systemChat "RUNNING PHASE 1";

// debug
execVM "killchain\systems\debugSystems\debug.sqf";








/*
OLD BELOW
This file sets up some basic mission-flow params 
one/two/threePoint relates to states I use to determine how many directions the retalliation should psawn from 

April 2020
monitorDefence is a mission state - it needs to be declared at this early stage as it is used by an Insurance System, and needs to be declared (as false)
in order to work - but check this is actually the case! Maybe try deleting it and see if it throws an error

toDo / April 2020 / confirm why I now do not need the commented out RF trigger value below 
*/

// RGG_reinforcementTrigger = 10;

// position blacklist - prevents overlapping of patrol points 
// RGG_patrolPositionBlacklist = ["black1","black2", "black3", "black4", "black5", "black6", "black7","black8","black9","black10"];
// RGG_patrolPositionBlacklist = ["blacklist4","blacklist3","blacklist2","blacklist1","nosouth","nowest"];
// RGG_patrolPositionBlacklist = ["blacklist4","blacklist3","blacklist2","blacklist1","nosouth","nowest","noeast"];
// RGG_patrolPositionBlacklist = ["blacklist4","blacklist3","blacklist2","blacklist1"];

// [[500,500],[12500,450]] // bottom edge boundary 
// [[500,12500],[12500,12450]] // top edge boundary 
// [[500,12500],[500,550]] // right edge boundary 
// [[12500,12500],[12550,500]] // left edge boundary
// [[500,3300],[12500,3000]],[[500,500],[12500,450]],[[500,12500],[12500,12450]],[[500,12500],[500,550]],[[12500,12500],[12550,500]],
// [[500,3300],[12500,3000]] // test lower third 

// Manages total count of groups created 
// RGG_totalOpforGroups = [];
// RGG_totalIndiforGroups = [];
// publicVariable "RGG_totalOpforGroups";
// publicVariable "RGG_totalIndiforGroups";

// opfor RF gen system
// ONEPOINT = false;
// TWOPOINT = false;
// THREEPOINT = false;
// these will be redundent as the points are set - so you can use patrolPointsTaken to define difficulty 





