var xx;
var yy;
var legalMoves = ds_list_create();

for (xx = 0; xx < 8; xx += 1;)
{
	for (yy = 0; yy < 8; yy += 1;)
	{
		if array_equals(global.grid[xx, yy],[PAWN, BLACK])
		{ 
			if ( (yy == 1) && (array_equals(global.grid[xx, 3],[0, 0])) // Pawn two-space move
						&& (array_equals(global.grid[xx, 2],[0 , 0]) ) )
			{
				ds_list_add(legalMoves, xx, yy, xx, (yy + 2));
			}

			if (yy < 7) && (array_equals(global.grid[xx, yy +  1],[0 , 0])) // Pawn one-move, <7th rank.
			{
				ds_list_add(legalMoves, xx, yy, xx, (yy + 1));
			} 
			
			if (xx == 0) & (yy < 7) // check edge-pawn capture separately, to avoid out-of-array 
			{
				var targetID = global.grid[1, yy + 1];
				if (targetID[1] == WHITE) 
				{
					ds_list_add(legalMoves, 0, yy, 1, yy + 1); 
				}
			} 
			
			if (xx == 7) & (yy < 7) // check other-edge pawn capture
			{
				var targetID = global.grid[6, yy + 1];
				if (targetID[1] == WHITE)
				{
					ds_list_add(legalMoves, 7, yy, 6, yy + 1);
				}
			}
			 
			if (xx < 7) && (xx > 0) && (yy < 7)
			{
				var targetID = global.grid[xx + 1, yy + 1];
				if (targetID[1] == WHITE)
				{
					ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
				}
				
				var targetID = global.grid[xx - 1, yy + 1];
				if (targetID[1] == WHITE)
				{
					ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
				}
			}
		}
	
	
		if array_equals(global.grid[xx, yy],[KNIGHT, BLACK])
		{
			if (xx <= 6) && (yy <= 5) // offset 1, 2
			{
				var targetID = global.grid[xx + 1, yy + 2];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx + 1, yy + 2);
				}
			}
			
			if (xx <= 5) && (yy <= 6) // offset 2, 1
			{
				var targetID = global.grid[xx + 2, yy + 1];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx + 2, yy + 1);
				}
			}
			
			if (xx <= 5) && (yy >= 1) // offset 2, -1
			{
				var targetID = global.grid[xx + 2, yy - 1];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx + 2, yy - 1);
				}
			}
				
			if (xx <= 6) && (yy >= 2) // offset 1, -2
			{
				var targetID = global.grid[xx + 1, yy - 2];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx + 1, yy - 2);
				}
			}
				
			if (xx >= 2) && (yy >= 1) // offset -2, -1
			{
				var targetID = global.grid[xx - 2, yy - 1];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx - 2, yy - 1);
				}
			}
			
			if (xx >= 2) && (yy <= 6) // offset -2, 1
			{
				var targetID = global.grid[xx - 2, yy + 1];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx - 2, yy + 1);
				}
			}
			
			if (xx >= 1) && (yy <= 5) // offset -1, 2
			{
				var targetID = global.grid[xx - 1, yy + 2];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx - 1, yy + 2);
				}
			}
			
			if (xx >= 1) && (yy >= 2) // offset -1, -2
			{
				var targetID = global.grid[xx - 1, yy - 2];
				if (targetID[1] == WHITE) || (targetID[1] == 0)
				{
					ds_list_add(legalMoves, xx, yy, xx - 1, yy - 2);
				}
			}
		}
	}
}

return legalMoves;