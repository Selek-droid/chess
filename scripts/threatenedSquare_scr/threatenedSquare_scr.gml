// Are enemy pieces threatening the target square? (If so, king can't move there.)
// xx, yy is the square we're testing.
// Get current square (boardstate[xx,yy]), then see whether offset enemy units are targeting it.

var enemy;
var friend;
var availableSpace;
var xx = argument0;
var yy = argument1;
var boardState = global.grid; 

if (oGame.state == "AI Turn") 
{
	enemy = WHITE;
	friend = BLACK;
}
	
if (oGame.state == "Player Turn") 
{
	enemy = BLACK;
	friend = WHITE;
}

// Checke 1-square range first -- King and Pawns essentially, but others as warranted

if (xx == 0) && (yy < 7) && (yy > 0) // LEFT EDGE but not corners
{
	var targetID = boardState[xx, yy - 1];  // check for above king (and R, Q while at it)
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy - 1];  // king, Q, B directly NE
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy + 1];  // King, Q, B, P directly SE
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
		|| (targetID[0] == PAWN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	// add cases for more distant QUEENS and BISHOPS here?
}

// ===============================================================================================

if (xx == 7) && (yy < 7) && (yy > 0 )  // RIGHT EDGE, but not corners, range 1
{
	var targetID = boardState[xx, yy - 1];  // check for K, Q, R directly N
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy - 1];  // King, Q, B directly NW
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy + 1];  // King, Q, B directly SW
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
		|| (targetID[0] == PAWN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}

}

// --------------------------------------------------------------------------------------

if (xx > 0) && (xx < 7 ) && (yy == 0)  // TOP EDGE, range 1
{
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy + 1];  // King, Q, B, P directly SE
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
		|| (targetID[0] == PAWN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy];  // King, Q, R directly W
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy + 1];  // King, Q, B or P directly SW
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
		|| (targetID[0] == PAWN) return true;
	}

}

// -------------------------------------------------------------------------

if (xx < 7 ) && (xx > 0 ) && (yy == 7)  // BOTTOM EDGE, range 1
{
	var targetID = boardState[xx, yy - 1];  // K, Q, R directly N
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy - 1];  // king, Q, B directly NE
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy - 1];  // King, Q, B directly NW
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}

} 

// -----------=============================

//if (xx == 0) && (yy == 0)   // TOP LEFT CORNER
//{
//	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
//	if (targetID[1] == enemy)
//	{
//		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
//	}
	
//	var targetID = boardState[xx + 1, yy + 1];  // King, Q, R directly SE
//	if (targetID[1] == enemy)
//	{
//		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
//	}
	
//	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
//	if (targetID[1] == enemy)
//	{
//		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
//	}
//}

//if (xx == 7 ) && ( yy == 0 )  // TOP RIGHT CORNER
//{
//	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W -- only Rook really possible
//	if (targetID[1] == enemy)
//	{
//		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
//	}
	
//	var targetID = boardState[xx = 1, yy + 1];  // King, Q, R directly SW
//	if (targetID[1] == enemy)
//	{
//		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
//	}
		
//	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
//	if (targetID[1] == enemy)
//	{
//		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
//	}
//}


// SE and SW corners later



// =================================================================================================

if (xx < 7 ) && ( xx > 0 ) && (yy < 7) && (yy > 0)  // MOST OTHER 1-range CASES -- MIDDLE SQUARES
{
	var targetID = boardState[xx, yy - 1];  // check K, Q, R directly N of target square
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy - 1];  // king, Q, B directly NE
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy + 1];  // King, Q, B, P directly SE
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) ||  (targetID[0] == QUEEN) 
			|| (targetID[0] == PAWN) || (targetID[0] == BISHOP) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy - 1];  // King, Q, B directly NW
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy];  // King, Q, R directly W
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy + 1];  // King, Q, B, P directly SW
	if (targetID[1] == enemy)
	{
		if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
			|| (targetID[0] == PAWN) return true;
	}
}

// ==================== Distant Q and R. Look LEFT first, starting at range 1 to be safe, in case I missed one.

if (xx > 0)
{	
	var availableSpace = xx;
	for (var i = 1; i <= availableSpace; i += 1;)
	{
		var targetID = boardState[xx - i, yy];  // offset -i, 0
		if (targetID[1] == friend) 
		{
			if (targetID[0] != KING) break;    // friendly non-king blocks enemy fire; 
		}
		if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
		{
			show_debug_message("R or Q protected piece right  of them")
			return true;
		}
	}
}			

if (xx < 7)  // Now look right for Q and R.
{
var availableSpace = 7 - xx;
	for (var i = 1; i <= availableSpace; i += 1;)
	{
		var targetID = boardState[xx + i, yy];  // offset -i, 0
		if (targetID[1] == friend) 
		{
			if (targetID[0] != KING) break;    // friendly non-king blocks enemy fire; 
		}									  //  if it is king keep looping past king to distant Q/R
		if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
		{
			show_debug_message("R or Q protected piece left of them")
			return true;
		}
	}
}

if (yy > 0)  // Look up for Q and R
{
var availableSpace = yy;
	for (var i = 1; i <= availableSpace; i += 1;)
	{
		var targetID = boardState[xx, yy - i];  // offset 0, -i
		if (targetID[1] == friend)
		{
			if (targetID[0] != KING) break;    // friendly non-king blocks enemy fire; 
		}
		if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
		{
			show_debug_message("R or Q protected piece below them")
			return true;
		}
	}
}

if (yy < 7)  // Look down for Q and R
{
var availableSpace = 7 - yy;
	for (var i = 1; i <= availableSpace; i += 1;)
	{
		var targetID = boardState[xx, yy + i];  // offset 0, i
		if (targetID[1] == friend) 
		{
			if (targetID[0] != KING) break;    // friendly non-king blocks enemy fire; 
		}		
		if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
		{
			show_debug_message("R or Q protected piece above them")
			return true;
		}
	}
}

else return false;