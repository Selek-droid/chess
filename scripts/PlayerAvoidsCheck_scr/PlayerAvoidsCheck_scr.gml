var proposedState = argument0;

// find proposed King position. Might be same as existing K position if proposed State reflects non-king move.

for (var xx = 0; xx < 8; xx += 1;)
{
	for (var yy = 0; yy < 8; yy += 1;)
	{
		if array_equals(proposedState[xx, yy],[KING, WHITE])
		{
			var proposedKingPosition = [xx , yy];
			break;
		}
	}
}

// Now see if proposed King position is threatend by enemy.

if !threatenedSquare_scr(proposedKingPosition[0],proposedKingPosition[1], proposedState)
{
return true;
}
else return false;