if (oGame.turn == 1) && (ds_list_find_value(oGame.formattedHistory,0) == "e4") 
	{
		animate([PAWN, BLACK],2,1,2,3);
		updateHistory_scr([PAWN, BLACK], 2, 1, 2, 3, false);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		exit;
	}

if (oGame.turn == 2) 
{
	if ((ds_list_find_value(oGame.formattedHistory,2) == "Nf3"))
	{
		animate([PAWN, BLACK],3,1,3,2);
		updateHistory_scr([PAWN, BLACK], 3, 1, 3, 2, false);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		exit;
	}
	else 
	{
		animate([KNIGHT, BLACK],1,0,2,2);
		updateHistory_scr([KNIGHT, BLACK], 1, 0, 2, 2, false);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		oGame.AIOpening = false;
		exit;
	}
}	
	
if (oGame.turn == 3) && (ds_list_find_value(oGame.formattedHistory,4) == "d4")
{
	animate([PAWN, BLACK],2,3,3,4);  // Pawn x d4
	updateHistory_scr([PAWN, BLACK], 2, 3, 3, 4, true);
	oGame.turn += 1;
	oGame.state = "Player Turn";
	exit;
}
	
if (oGame.turn == 4) && (ds_list_find_value(oGame.formattedHistory,6) == "Nxd4")
{
	animate([KNIGHT, BLACK],6,0,5,2);  // Nf6
	updateHistory_scr([KNIGHT, BLACK], 6, 0, 5, 2, false);
	oGame.turn += 1;
	oGame.state = "Player Turn";
	exit;
}

if (oGame.turn == 5) && (ds_list_find_value(oGame.formattedHistory,8) == "Nc3")
{
	animate([PAWN, BLACK],0,1,0,2);  // Najdorf variation: 5...a6
	updateHistory_scr([PAWN, BLACK],  0, 1, 0, 2, false);
	oGame.turn += 1;
	oGame.state = "Player Turn";
	exit;
}

if (oGame.turn == 6) 
{
	if (ds_list_find_value(oGame.formattedHistory,10) == "Be3")
	{
		animate([PAWN, BLACK],4,1,4,3);  // Najdorf variation, English attack. Response: 6...e5
		updateHistory_scr([PAWN, BLACK], 4, 1, 4, 3, false);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		exit;
	}
	
	if (ds_list_find_value(oGame.formattedHistory,10) == "Bg5")
	{
		animate([PAWN, BLACK],4,1,4,2);  // Najdorf variation, classical attack. Response: 6...e6
		updateHistory_scr([PAWN, BLACK], 4, 1, 4, 2, false);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		exit;
	}
}

if (oGame.turn == 7) 
{
	if (ds_list_find_value(oGame.formattedHistory,10) == "Be3") &&
	(ds_list_find_value(oGame.formattedHistory,12) == "Nb3")
	{
		animate([BISHOP, BLACK],2,0,4,2);  // Najdorf variation, classical attack. Response: 7...Be6
		updateHistory_scr([BISHOP, BLACK], 2, 0, 4, 2, false);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		oGame.AIOpening = false;
		exit;
	}
	
	if (ds_list_find_value(oGame.formattedHistory,10) == "Bg5") &&
	(ds_list_find_value(oGame.formattedHistory,12) == "f4")
	{
		animate([BISHOP, BLACK],5,0,4,1);  // Najdorf variation, classical attack. Response: 7...Be6
		updateHistory_scr([BISHOP, BLACK], 5, 0, 4, 1, false);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		oGame.AIOpening = false;
		exit;
	}
	
}