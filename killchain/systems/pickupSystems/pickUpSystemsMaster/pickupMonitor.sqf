
systemChat "pickupMon is on";
_heli = _this select 0;

_HKSQUADGP = [];

_deploymentMission = true;
_initPhase = true;
_pickup = false;
_wait = false;
_dropoff = false;
_complete = false;
_myHeli = _heli;
_markerName = str _heli;

deleteMarker _markerName; // belt and braces - is needed??

private _HELI1ATL1 = "_HELI1ATL1";
while {_deploymentMission} do {

  // engine check
  if (isEngineOn _heli) then {
    _HELI1ATL1 = (getPosATL _myHeli) select 2;
    _HELI1ATL1 = round _HELI1ATL1;
    systemChat str _HELI1ATL1;
  } else {
    // this should shut everything down if the engine is turned off
    _deploymentMission = false;
    _initPhase = false;
    _pickup = false;
    _wait = false;
    _dropoff = false;
    _complete = false;
    deleteMarker _markerName; // belt and braces
    [_heli] execVM "killchain\systems\pickupSystems\pickupSystems1\pickupInit.sqf";
    systemChat "shutting down pickup system";
  };
  // alt check
  // _HELI1ATL1 = (getPosATL _myHeli) select 2;
  // _HELI1ATL1 = round _HELI1ATL1;
  // systemChat str _HELI1ATL1;
   
  if (_initPhase) then {
    if (_HELI1ATL1 > 5) then {
      _freeCargoPositions = _myHeli emptyPositions "cargo";
      systemChat format ["cargo available: %1", _freeCargoPositions];
      _initPhase = false;
      _pickup = true;
    };
  };
 
  // PICKUP 
 	if (_pickup) then {
    systemChat "Land so troops can board";
		if ((_HELI1ATL1) < 1) then {
			_extractLocation = position _heli;
			_dir = direction _heli;
			_extractMarker = createMarker [_markerName, _extractLocation];
			_extractMarker setMarkerShape "RECTANGLE";
			_extractMarker setMarkerColor "ColorGreen";
			_extractMarker setMarkerDir _dir;
			_extractMarker setMarkerSize [15, 50];
  			_units = allUnits inAreaArray _markerName;
			{
				_x assignAsCargo _myHeli;
				_squaddieGrp = group _x;
				_x setUnitPos "MIDDLE";
				// if !(group _squaddieGrp isEqualTo group player) then {
				//   HKSQUADGP pushBackUnique _squaddieGrp;
				// };
        		_HKSQUADGP pushBackUnique _squaddieGrp;
			} forEach _units;	
			_units orderGetIn true;
			_pickup = false;
			_wait = true;
		};
	};

  // WAIT / BOARD / TRANSIT
	if (_wait) then {
    systemChat "Troops boarded";
		if ((_HELI1ATL1) > 3) then {
			_wait = false;
			_dropoff = true;
			deleteMarker _markerName;
		};
	};

  // DISEMBARK
	if (_dropoff) then {
    systemChat "Get the troops on the ground";
		if ((_HELI1ATL1) < 1) exitWith {
			_extractLocation = position _heli;
			_extractMarker = createMarker [_markerName, _extractLocation];
			_extractMarker setMarkerShape "ELLIPSE";
			_extractMarker setMarkerColor "ColorRed";
			_extractMarker setMarkerSize [20, 20];
      // order getOut 
      { unassignVehicle _x } forEach crew _heli;

      _units = allUnits inAreaArray _markerName;
      _units orderGetIn false;

      {
        _x setUnitPos "AUTO";
      } forEach _units;
      _dropoff = false;
      _complete = true;
      {
        _squaddieGrp = group _x;
        _HKSQUADGP pushBackUnique _squaddieGrp;
      } forEach _units;
      systemChat format ["hk group: %1", _HKSQUADGP];
		};
	};

	if (_complete) then {
		_units = allUnits inAreaArray _markerName;
		{
		_x setUnitPos "AUTO";
		} forEach _units;
		_pos = getMarkerPos _markerName;
		_safeDelete = _heli distance _pos;
		if ((_safeDelete) > 5) then {
			if (HUNTERKILLER) then {
				_arraySize = count _HKSQUADGP; // probably 2 

				// this tries to delete any single-unit groups e.g. a player group 
				for "_i" from 1 to _arraySize do {
					_group = _HKSQUADGP select (_i -1);
					_size = count units _group; 
					systemChat format ["Iteration / Group: %1, Size: %2", _group, _size];
					if (_size > 1) then {
					// HKSQUADGP deleteAt _i;
					[_group] execVM "killChain\systems\hunterKillerSystems\runHK.sqf";
					systemChat format ["sending this: %1", _group];
					};
				};   
			};
			sleep 1;
			deleteMarker _markerName;
			_complete = false;
			_initPhase = true;
		};
	};

	sleep 2;
};

