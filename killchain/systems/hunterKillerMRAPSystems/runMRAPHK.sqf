_mrap = _this select 0;

systemChat format ["dropping off %1", _mrap];

sleep 1;

_commander = commander _mrap;
systemChat format ["Commander is %1", _commander];

_group = group _commander;

sleep 1;

[_group] execVM "killChain\systems\hunterKillerSystems\runHK.sqf";
systemChat format ["sending this: %1", _group];
