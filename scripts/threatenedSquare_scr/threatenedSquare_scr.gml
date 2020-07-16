// Are enemy pieces threatening the target square? (If so, king can't move there.)
// xx, yy is the square we're testing.
// Get current square (boardstate[xx,yy]), then see whether offset enemy units are targeting it.

var xx = argument0;
var yy = argument1;
var boardState = global.grid;

if (xx == 0) && (yy < 7) && (yy > 0) // LEFT EDGE but not corners
{
	var targetID = boardState[xx + 1, yy + 1];  // check for below-right enemy pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			return true;
		}
	}
	
	var targetID = boardState[xx, yy - 1];  // check for above king (and R, Q while at it)
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy - 1];  // king, Q, R directly NE
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy + 1];  // King, Q, R directly SE
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	// add cases for more distant QUEENS and BISHOPS here?
}

// ===============================================================================================

if (xx == 7) && (yy < 7) && (yy > 0 )  // RIGHT EDGE, but not corners
{
	var targetID = boardState[xx - 1, yy + 1];  // check for below-left enemy pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			return true;
		}
	}
	
	var targetID = boardState[xx, yy - 1];  // check for K, Q, R directly N
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy - 1];  // King, Q, R directly NW
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy + 1];  // King, Q, R directly SW
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}

}

// --------------------------------------------------------------------------------------

if (xx > 0) && (xx < 7 ) && (yy == 0)  // TOP EDGE
{
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy + 1];  // King, Q, R directly SE
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy + 1];  // King, Q, R directly SW
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}

}

// -------------------------------------------------------------------------

if (xx < 7 ) && (xx > 0 ) && (yy == 7)  // BOTTOM EDGE
{
	var targetID = boardState[xx, yy - 1];  // K, Q, R directly N
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy - 1];  // king, Q, R directly NE
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy - 1];  // King, Q, R directly NW
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}

} 

// -----------=============================

if (xx == 0) && (yy == 0)   // TOP LEFT CORNER
{
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy + 1];  // King, Q, R directly SE
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
}

if (xx == 7 ) && ( yy == 0 )  // TOP RIGHT CORNER
{
	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W -- only Rook really possible
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy + 1];  // King, Q, R directly SW
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
		
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
}






// =================================================================================================

if (xx < 7 ) && ( xx > 0 ) && (yy < 7) && (yy > 0)  // MOST OTHER CASES -- MIDDLE SQUARES
{
	var targetID = global.grid[xx - 1, yy + 1];  // check for below-left pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			show_debug_message("King could not capture a guarded piece");
			return true;
		}
	}
	
	var targetID = global.grid[xx + 1, yy + 1];  // check for below-right pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			show_debug_message("King could not capture a guarded piece");
			return true;
		}
	}
		
	var targetID = boardState[xx, yy - 1];  // check for above king (and R, Q while at it)
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy - 1];  // king, Q, R directly NE
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx + 1, yy + 1];  // King, Q, R directly SE
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx - 1, yy - 1];  // King, Q, R directly NW
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy];  // King, Q, R directly W
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
	var targetID = boardState[xx = 1, yy + 1];  // King, Q, R directly SW
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
	}
	
}

else return false;