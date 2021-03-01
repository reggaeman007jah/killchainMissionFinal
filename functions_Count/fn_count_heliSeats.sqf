// imports
private ["_vic"];
_vic = param[0];

// debug 
systemChat "vic model is:";
_freeCargoPositions = _vic emptyPositions "cargo";
systemChat format ["cargo available: %1", _freeCargoPositions];



