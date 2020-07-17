switch (oGame.state)
{
	case ("AI Turn"):
	{
		AIscript();
		break;
	}
}



var newX = 0;
var newY = 0;
var targetID = [0 , 0];
var pieceType;


// look for mouse click on a piece. If something there,
// store it, then clear its space, then put it on mouse cursor.
// Then look for second click. If valid, move piece there.
// If not valid, keep piece on cursor.
// If user hits ESC, cancel move, restore saved selection.


if (!pickedUp) && (mouse_check_button_released(mb_left))  // pickup
{
	if (mouse_x >= x) && (mouse_x <= x + BOARD_WIDTH)
		&& (mouse_y >= y) && (mouse_y <= y + BOARD_HEIGHT)
	{
		gridX = floor( ( mouse_x - x ) / SQUARE_SIZE );
		gridY = floor( ( mouse_y - y ) / SQUARE_SIZE );
		mouse_clear(mb_left);
//		if (global.grid[gridX, gridY] != 0)  // THURSDAY ATTEMPTED FIX BELOW
		if ! ( array_equals(global.grid[gridX, gridY], [0 , 0]) )
		{
			selectedPiece = global.grid[gridX, gridY];
			global.grid[gridX, gridY] = [0 , 0]; 
			pickedUp = true;
	//		alarm[0] = room_speed / 5;  // alarm sets pickedUp to true
//			mouse_clear(mb_left); // NEW TRY
			
		}
	}
}

if (pickedUp) && (mouse_check_button_released(mb_left))  // destination clicked
	{	newX = floor( ( mouse_x - x ) / SQUARE_SIZE );  // check if empty or enemy
		newY = floor( ( mouse_y - y ) / SQUARE_SIZE );  // ... and if piece capable...
		mouse_clear(mb_left);
		if (newX < 0) || (newX > 7) || (newY < 0) || (newY > 7)
		{
//			mouse_clear(mb_left);
			exit;
		}
		
		targetID = global.grid[newX, newY];
		
		if array_equals([newX, newY],[gridX, gridY])  // check whether dest = origin.
		{
			global.grid[newX, newY] = selectedPiece; // maybe CHANGE THIS CODE.  BUG???
			pickedUp = false;
			selectedPiece = [0 , 0]
			turnOver = false;   // Eventually this variable will change state to AI.
			oGame.state = "Player Turn";
//			mouse_clear(mb_left);
		}
			
			
		if (targetID[1] == BLACK) || (array_equals(global.grid[newX, newY],[0, 0]))
		{
			pieceType = selectedPiece[0];
			switch (pieceType) 
			{
				case PAWN: 
				{
					if ( (targetID[1] == BLACK) && ((abs (newX - gridX)) == 1 ) 
						&& (gridY - newY == 1) ) 
					{
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					}
						
					else if ((gridY - newY == 1) && (gridX == newX)) 
						&& (array_equals(global.grid[newX, newY],[0, 0]))
					{
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					} 
						
					else if ( (gridY == 6) && (gridY - newY == 2) && (gridX == newX) 
						&& (array_equals(global.grid[newX, newY],[0, 0]))
						&& (array_equals(global.grid[gridX, gridY - 1],[0 , 0]) ) )
						{
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
						}
						
					break;
				}
					
				case KING:
				{
					if  ((abs (newX - gridX) <= 1) && (abs (newY - gridY) <= 1))
					{
						global.grid[newX, newY] = selectedPiece;
						canCastleLeft = false;
						canCastleRight = false;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					}
// Castling code. Will work for white and black, in theory!		
					if (canCastleRight) && (newX == gridX + 2) 
					{
						if array_equals(global.grid[gridX + 1, 7],[0, 0]) &&
						array_equals(global.grid[gridX + 2, 7],[0, 0]) &&
						array_equals(global.grid[6, 7],[0, 0]) &&
						!threatenedSquare_scr(gridX + 1, 7, global.grid) &&
						!threatenedSquare_scr(gridX + 2, 7, global.grid) 
						{
							global.grid[gridX + 2, 7] = [KING, WHITE];
							global.grid[gridX + 1, 7] = [ROOK, WHITE];
							global.grid[7, 7] = [0 , 0];
							canCastleLeft = false;
							canCastleRight = false;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					} 
					
					if (canCastleLeft) && (newX == gridX - 2)
					{
						if array_equals(global.grid[gridX - 1, 7],[0, 0]) &&
						array_equals(global.grid[gridX - 2, 7],[0, 0]) &&
						array_equals(global.grid[1, 7],[0, 0]) &&
						!threatenedSquare_scr(gridX - 1, 7, global.grid) &&
						!threatenedSquare_scr(gridX - 2, 7, global.grid) 						
						{
							global.grid[gridX - 2, 7] = [KING, WHITE];
							global.grid[gridX - 1, 7] = [ROOK, WHITE];
							global.grid[0, 7] = [0 , 0];
							canCastleLeft = false;
							canCastleRight = false;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
					break;
				}
					
				case ROOK:
				{
					if ((newX != gridX) && (newY != gridY))
					{
					break;
					}
					var rangeX = abs (newX - gridX);
					var rangeY = abs (newY - gridY);
					var minX = min(gridX, newX);
					var minY = min(gridY, newY);
					if (newX == gridX)
					{
						for (var i = 1; i < rangeY; i += 1;)
						{
						if array_equals(global.grid[newX, minY + i],[0 , 0])
							{
								var clearPath = true;  // unused var for now
							}
						else 
							{					
							exit;
							}
						}
					}
					if (newY == gridY)
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(global.grid[minX + i, newY],[0 , 0])
							{
								var clearPath = true;
							}
							else 
							{
								exit;
							}
						}
					}
						
					global.grid[newX, newY] = selectedPiece;
					if (gridX == 0) && (gridY == 7) canCastleLeft = false;
					if (gridX == 7) && (gridY == 7) canCastleRight = false;
					pickedUp = false;
					selectedPiece = [0 , 0];
					oGame.state = "AI Turn";
					break;
				}
				
				case KNIGHT:
				{
					if (((abs (newX - gridX)) == 1) && ((abs (newY - gridY)) == 2))
					|| (((abs (newX - gridX)) == 2) && ((abs (newY - gridY)) == 1)) 
					{
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					}
					break;
				}
				
				case BISHOP:
				{
					if ((abs (newX - gridX)) != (abs (newY - gridY )))
					{
						exit;
					}
					
					var rangeX = abs (newX - gridX);
					var rangeY = abs (newY - gridY);
					var minX = min(gridX, newX);
					var minY = min(gridY, newY);
					var maxY = max(gridY, newY);
					
					// upward sloping, both x and y rising
					// search from lowest to highest coords
					
					if  ( ((newX > gridX) && (newY > gridY))
					|| ((newX < gridX) && (newY < gridY)) )
							
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(global.grid[minX + i, minY + i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					}
					
					// now negative slope; again start with small x and add, but sub from max y
					
					for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(global.grid[minX + i, maxY - i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
					
					
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
				}
				
				case QUEEN:
				{
					var rangeX = abs (newX - gridX);
					var rangeY = abs (newY - gridY);
					var minX = min(gridX, newX);
					var minY = min(gridY, newY);
					var maxY = max(gridY, newY);
					
					if (newX == gridX)  // check moving straight up or down
					{
						for (var i = 1; i < rangeY; i += 1;)
						{
						if array_equals(global.grid[newX, minY + i],[0 , 0])
							{
								var clearPath = true;  // unused var for now
							}
						else 
							{					
							exit;
							}
						}
					global.grid[newX, newY] = selectedPiece;
					pickedUp = false;
					selectedPiece = [0 , 0];
					oGame.state = "AI Turn";
					exit;
					}
					
					else if (newY == gridY)   // check moving horizontally
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(global.grid[minX + i, newY],[0 , 0])
							{
								var clearPath = true;
							}
							else 
							{
								exit;
							}
						}
						
					global.grid[newX, newY] = selectedPiece;
					pickedUp = false;
					selectedPiece = [0 , 0];
					oGame.state = "AI Turn";
					exit;
					}
// now bishop-like movement, first positive slope:
					
					else if  ( ((newX > gridX) && (newY > gridY))
					|| ((newX < gridX) && (newY < gridY)) )
							
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(global.grid[minX + i, minY + i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					}
					
					// now negative slope; again start with small x and add, but sub from max y
					else
					{
					for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(global.grid[minX + i, maxY - i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
					
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					}
				}
			}
		}
	}
	
		
if (pickedUp) && (keyboard_check_pressed(vk_escape))   // user aborts move
{
	global.grid[gridX, gridY] = selectedPiece;
	pickedUp = false;
	selectedPiece = [0, 0];
}
	