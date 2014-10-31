celo_fnc_sooth = {
	_group_data = (_this select 3) select 0;
	_count = (_this select 3) select 1;

	player removeAction (_this select 2);
	"" call celo_turn_off_modes;
	setAccTime 1;

	[_group_data,_count] spawn {
		_group_data = _this select 0;
		_count = _this select 1;
		player switchMove "AmovPercMstpSlowWpstDnon_AmovPknlMstpSlowWpstDnon";
		//player switchMove "AmovPercMstpSnonWpstDnon_AmovPsitMstpSnonWpstDnon_ground";
		cutText["","BLACK OUT",2];
		sleep 3;
		playMusic "skynet";
		0 fadeMusic 1;
		((-20 - (count (_group_data select 2)) + 3*_count) min 0)  call celo_fnc_add_hvozd_power;
		sleep 3;

		[["I_soldier_F",_count]] spawn celo_fnc_intermezzo_camera;

		sleep 20;

		player switchMove "AmovPsitMstpSrasWrflDnon_AmovPercMstpSlowWrflDnon";
		3 fadeMusic 0;
		sleep 4;
		playMusic "";
		sleep 3;
		saveGame;
	};

	true
};