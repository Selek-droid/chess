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
		animate([PAWN, BLACK],2,3,3,4);
		updateHistory_scr([PAWN, BLACK], 2, 3, 3, 4, true);
		oGame.turn += 1;
		oGame.state = "Player Turn";
		oGame.AIOpening = false;
		exit;
	}
	
if (oGame.turn == 4) && (ds_list_find_value(oGame.formattedHistory,6) == "Nd4")