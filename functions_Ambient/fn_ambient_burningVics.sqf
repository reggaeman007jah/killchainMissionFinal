/*
This function manages creation of ambient burning wrecks
*/

// ** imports 
private ["_battleZone", "_burningVics"];
_battleZone = param[0]; // main battlezone pos
_burningVics = param[1]; // number of vics to burn
// ** imports 

// decide on when they should be burning - what triggers the spawn and fire?
// to do: spawn vics, then reduce damage so they burn 
