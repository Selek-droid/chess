var xx;
var yy;
var legalMoves = ds_list_create();
var boardState = global.grid;

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
		
		if array_equals(global.grid[xx, yy],[KING, BLACK])
		{
			if (yy == 0) && (xx > 0) && (xx < 7)  // King on starting rank, not corners.
			{
				// Castling kingside (to right, assuming AI has black. Trying to make code cover both.)
				if (board_object.AICanCastleRight)
				{
					var castleTarget = global.grid[xx + 2, yy];  // offset 2, 0
					var targetID = global.grid[xx + 1, yy];
					if (targetID[1] == 0) && (castleTarget[1] == 0) &&
//					array_equals(boardState[6, 0], [0 , 0]) &&     // redundant placeholder check for AI as white
						!((threatenedSquare_scr(xx, yy, boardState)) ) &&
						!((threatenedSquare_scr(xx + 1, yy, boardState)) ) &&
						!((threatenedSquare_scr(xx + 2, yy, boardState)) ) 
						ds_list_add(legalMoves, xx, yy, xx + 2, yy);
				}
				
				if (board_object.AICanCastleLeft)
				{
					var knightThere = global.grid[xx - 3, yy];
					var castleTarget = global.grid[xx - 2, yy];  // offset 2, 0
					var targetID = global.grid[xx - 1, yy];
					if (targetID[1] == 0) && (castleTarget[1] == 0) && (knightThere[1] == 0) &&
						!((threatenedSquare_scr(xx, yy, boardState)) ) &&
						!((threatenedSquare_scr(xx + 1, yy, boardState)) ) &&
						!((threatenedSquare_scr(xx + 2, yy, boardState)) ) 
						ds_list_add(legalMoves, xx, yy, xx - 2, yy);
				}
				
				var targetID = global.grid[xx - 1, yy];  // offset -1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy);
								
				var targetID = global.grid[xx - 1, yy + 1];  // offset -1, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
								
				var targetID = global.grid[xx, yy + 1];  // offset 0, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy + 1);
				
				var targetID = global.grid[xx + 1, yy + 1];  // offset 1, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy + 1, boardState) ))
					ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
						
				var targetID = global.grid[xx + 1, yy];  // offset 1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy);		
			}
			
			if (yy == 0) && (xx == 0)  // King on starting rank, top leftcorner.
			{
				var targetID = global.grid[1, 0];  // offset 1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(1, 0, boardState)) )
					ds_list_add(legalMoves, 0, 0, 1, 0);
						
				var targetID = global.grid[1, 1];  // offset 1, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(1, 1, boardState)) )
					ds_list_add(legalMoves, 0, 0, 1, 1);	
						
				var targetID = global.grid[0, 1];  // offset 0, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(0, 1, boardState)) )
					ds_list_add(legalMoves, 0, 0, 0, 1);	
			}
			
			if (xx == 7) && (yy == 0) // King on starting rank, top right corner.
			{
				var targetID = global.grid[xx - 1, yy];  // offset -1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy);
						
				var targetID = global.grid[xx - 1, yy + 1];  // offset -1, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
						
				var targetID = global.grid[xx, yy + 1];  // offset 0, 1 
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy + 1);	
			}
			
			if (xx > 0) && (xx < 7) && (yy > 0) && (yy < 7)    // King not on any edge
			{
				var targetID = global.grid[xx - 1, yy];  // offset -1, 0. Prevent moving into check.
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy);
								
				var targetID = global.grid[xx - 1, yy + 1];  // offset -1, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
								
				var targetID = global.grid[xx, yy + 1];  // offset 0, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy + 1);
								
				var targetID = global.grid[xx + 1, yy + 1];  // offset 1, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy + 1, boardState)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
						
				var targetID = global.grid[xx + 1, yy];  // offset 1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy);
						
				var targetID = global.grid[xx + 1, yy - 1];  // offset 1, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);	
						
				var targetID = global.grid[xx, yy - 1];  // offset 0, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy - 1);	
						
				var targetID = global.grid[xx - 1, yy - 1];  // offset -1, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);		
			}
			
			if (xx == 0) &&  (yy > 0) && (yy < 7)    // King on left edge, not corners
			{
				var targetID = global.grid[xx, yy - 1];  // offset 0, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy - 1);	
					
				var targetID = global.grid[xx + 1, yy - 1];  // offset 1, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);
					
				var targetID = global.grid[xx + 1, yy];  // offset 1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy);
					
				var targetID = global.grid[xx + 1, yy + 1];  // offset 1, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
					
				var targetID = global.grid[xx, yy + 1];  // offset 0, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy + 1);
			}
			
			if (xx == 7) &&  (yy > 0) && (yy < 7)    // King on right edge, not corners
			{
				var targetID = global.grid[xx, yy - 1];  // offset 0, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy - 1);
					
				var targetID = global.grid[xx - 1, yy - 1];  // offset -1, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);
					
				var targetID = global.grid[xx - 1, yy];  // offset -1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy);
					
				var targetID = global.grid[xx - 1, yy + 1];  // offset -1 , 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);	
					
				var targetID = global.grid[xx, yy + 1];  // offset 0, 1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy + 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy + 1);
			}
			
			if (xx == 0) && (yy == 7)    // King on lower left corner
			{
				var targetID = global.grid[xx, yy - 1];  // offset 0, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy - 1);
					
				var targetID = global.grid[xx + 1, yy - 1];  // offset 1 , -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);
					
				var targetID = global.grid[xx + 1, yy];  // offset 1 , 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy);	
			}
			
			if (xx == 7) && (yy == 7)    // King on lower right corner
			{
				var targetID = global.grid[xx, yy - 1];  // offset 0, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy - 1);
					
				var targetID = global.grid[xx - 1, yy];  // offset -1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy);
					
				var targetID = global.grid[xx - 1, yy - 1];  // offset -1, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);
			}
			
			if (xx >= 1) && (xx <= 6) && (yy == 7)    // King on bottom edge, not in corners
			{
				var targetID = global.grid[xx - 1, yy];  // offset -1, 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy);
					
				var targetID = global.grid[xx, yy - 1];  // offset -1, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx - 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);
				
				var targetID = global.grid[xx, yy - 1];  // offset 0, -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx, yy - 1);
			
				var targetID = global.grid[xx + 1, yy - 1];  // offset 1 , -1
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy - 1, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);
					
				var targetID = global.grid[xx + 1, yy];  // offset 1 , 0
				if ((targetID[1] == 0) || (targetID[1] == WHITE)) && !((threatenedSquare_scr(xx + 1, yy, boardState)) )
					ds_list_add(legalMoves, xx, yy, xx + 1, yy);	
			}		
		}
		
		if array_equals(global.grid[xx, yy],[ROOK, BLACK])
		{		// Look left, first measuring room to maneuver, then iterate until hit obstacle
			if (xx > 0)
			{	var availableSpace = xx;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx - i, yy];  // offset -i, 0
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx - i, yy);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx < 7)  // now look right
			{	var availableSpace = 7 - xx;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx + i, yy];  // offset i, 0
					if (targetID[1] == 0) ds_list_add(legalMoves, xx, yy, xx + i, yy);
					if (targetID[1] == WHITE)
					{
						ds_list_add(legalMoves, xx, yy, xx + i, yy);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (yy > 0)  // now look up
			{	var availableSpace = yy;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx, yy - i];  // offset 0, -i
					if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy - i);
					if (targetID[1] == WHITE)
					{
						ds_list_add(legalMoves, xx, yy, xx, yy - i);
						break;
					}	
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (yy < 7)  // now look down
			{	var availableSpace = 7 - yy;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx, yy + i];  // offset 0, +i
					if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy + i);
					if (targetID[1] == WHITE)
					{
						ds_list_add(legalMoves, xx, yy, xx, yy + i);
						break;
					}	
					if (targetID[1] == BLACK) break;
				}
			}
		}
		
		if array_equals(global.grid[xx, yy],[BISHOP, BLACK])
		{
			if (xx > 0) && (yy > 0) // start looking NW
			{	var availableSpace = min(xx, yy);  // has less space than a rook!
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx - i, yy - i];  // offset -i, -i
					if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx < 7) && (yy < 7)  // next looking SE
			{	var availableSpace = min ((7 - xx), (7 - yy));
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx + i, yy + i];  // offset i, i
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy + i); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx + i, yy + i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx > 0) && (yy < 7) // now look SW
			{	var availableSpace = min(xx, (7 - yy));  // has less space than a rook!
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx - i, yy + i];  // offset -i, +i
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy + i); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx - i, yy + i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx < 7) && (yy > 0) // end by looking NE
			{	var availableSpace = min((7 - xx), yy);  // has less space than a rook!
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx + i, yy - i];  // offset +i, -i
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy - i); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx + i, yy - i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
		}
		
		if array_equals(global.grid[xx, yy],[QUEEN, BLACK])
		{
			if (xx > 0)
			{	var availableSpace = xx;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx - i, yy];  // offset -i, 0
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx - i, yy);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx < 7)  // now look right
			{	var availableSpace = 7 - xx;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx + i, yy];  // offset i, 0
					if (targetID[1] == 0) ds_list_add(legalMoves, xx, yy, xx + i, yy);
					if (targetID[1] == WHITE)
					{
						ds_list_add(legalMoves, xx, yy, xx + i, yy);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (yy > 0)  // now look up
			{	var availableSpace = yy;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx, yy - i];  // offset 0, -i
					if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy - i);
					if (targetID[1] == WHITE)
					{
						ds_list_add(legalMoves, xx, yy, xx, yy - i);
						break;
					}	
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (yy < 7)  // now look down
			{	var availableSpace = 7 - yy;
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx, yy + i];  // offset 0, +i
					if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy + i);
					if (targetID[1] == WHITE)
					{
						ds_list_add(legalMoves, xx, yy, xx, yy + i);
						break;
					}	
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx > 0) && (yy > 0) // start looking NW
			{	var availableSpace = min(xx, yy);  // has less space than a rook!
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx - i, yy - i];  // offset -i, -i
					if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx < 7) && (yy < 7)  // next looking SE
			{	var availableSpace = min ((7 - xx), (7 - yy));
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx + i, yy + i];  // offset i, i
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy + i); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx + i, yy + i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx > 0) && (yy < 7) // now look SW
			{	var availableSpace = min(xx, (7 - yy));  // has less space than a rook!
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx - i, yy + i];  // offset -i, +i
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy + i); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx - i, yy + i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
			
			if (xx < 7) && (yy > 0) // end by looking NE
			{	var availableSpace = min((7 - xx), yy);  // has less space than a rook!
				for (var i = 1; i <= availableSpace; i += 1;)
				{
					var targetID = global.grid[xx + i, yy - i];  // offset +i, -i
					if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy - i); // empty; keep looking
					if (targetID[1] == WHITE)  // record move and stop.
					{
						ds_list_add(legalMoves, xx, yy, xx + i, yy - i);
						break;
					}
					if (targetID[1] == BLACK) break;
				}
			}
		}
	}
}

return legalMoves;