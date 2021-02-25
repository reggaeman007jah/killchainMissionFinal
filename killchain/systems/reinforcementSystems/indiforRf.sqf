
_initStartPos = _this select 0;
_objPos = _this select 1;

_indi = independent countSide allUnits;

if (_indi <10) then {
	// ORDER RF HERE
	systemChat "debug - INDIFOR RF Inbound";
	[_initStartPos, _objPos] execVM "killChain\systems\spawnerSystems\createIndiforRFUnits.sqf";
	_smoke = createVehicle ["G_40mm_smokeYELLOW", _initStartPos, [], 0, "none"]; // drop this from up high?
	// voice broadcasts
	execVM "media\sounds\thisIsCommand.sqf";
	sleep 3;
	execVM "media\sounds\rfInbound.sqf";
} else {
	systemChat "Debug - RF called but already too many INDIFOR troops in game - current limit is <10";
};
