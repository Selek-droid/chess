var xx;
var yy;
var pawnMoves = ds_list_create();

for (xx = 0; xx < 8; xx += 1;)
{
	for (yy = 0; yy < 8; yy += 1;)
	{
		if array_equals(global.grid[xx, yy],[PAWN, BLACK])
		{
//			if ( (yy == 1) && (gridY - newY == 2) && (gridX == newX) 
//						&& (array_equals(global.grid[newX, newY],[0, 0]))
//						&& (array_equals(global.grid[gridX, gridY - 1],[0 , 0]) ) )

			if (array_equals(global.grid[xx, yy +  1],[0 , 0]))
			{
				ds_list_add(pawnMoves, xx, yy, xx, (yy + 1));
			}
		}
	}
}

return pawnMoves;