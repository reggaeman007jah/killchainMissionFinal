
private ["_vic"];

_vic = param[0];
systemChat "vic is:";
_vic2 = str _vic;
systemchat str _vic2;

_crewCount = [_vic2, true] call BIS_fnc_crewCount;
systemChat format ["_crewCount: %1", _crewCount];
systemChat format ["This heli has %1 seats", _crewCount];

_list = fullCrew _vic;
systemChat str _list;