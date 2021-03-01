
_pos = _this select 0;
systemChat format ['received this: %1', _pos];

systemChat "DELETING EVERYTHING IN AREA";
hint "DELETING EVERYTHING IN AREA";
{ 
	deleteVehicle _x 
} forEach nearestObjects [_pos, ['all'], 400];

