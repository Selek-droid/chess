var xx = argument0;
var yy = argument1;

if (xx == 0) && (yy < 7)  // left edge, but not bottom-left corner
{
	var targetID = global.grid[xx + 1, yy + 1];  // check for below-right pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			return true;
		}
	}
	// add cases for more distant QUEENS and BISHOPS here?
}

if (xx == 7) && (yy < 7) // right edge, but not bottom-right corner
{
	var targetID = global.grid[xx - 1, yy + 1];  // check for below-left pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			return true;
		}
	}
}

if (xx < 7 ) && ( xx > 0 ) && (yy < 7) // most other cases?
{
	var targetID = global.grid[xx - 1, yy + 1];  // check for below-left pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			return true;
		}
	}
	
	var targetID = global.grid[xx + 1, yy + 1];  // check for below-right pawn, king, queen, bishop
	if (targetID[1] == WHITE)
	{
		if (targetID[0] == PAWN) || (targetID[0] == BISHOP) 
			|| (targetID[0] == KING) || (targetID[0] == QUEEN)	
		{
			return true;
		}
	}
}

else return false;