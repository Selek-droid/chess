
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
		if (global.grid[gridX, gridY] != 0)
		{
			selectedPiece = global.grid[gridX, gridY];
			global.grid[gridX, gridY] = [0 , 0]; 
			alarm[0] = room_speed / 5;  // alarm sets pickedUp to true
			
		}
	}
}

if (pickedUp) && (mouse_check_button_released(mb_left))  // destination clicked
	{	newX = floor( ( mouse_x - x ) / SQUARE_SIZE );  // check if empty or enemy
		newY = floor( ( mouse_y - y ) / SQUARE_SIZE );  // ... and if piece capable...
		targetID = global.grid[newX, newY];
		
		if array_equals([newX, newY],[gridX, gridY])  // check whether dest = origin.
		{
			global.grid[newX, newY] = selectedPiece;
			pickedUp = false;
			selectedPiece = [0 , 0]
			turnOver = false;   // Eventually this variable will change state to AI.
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
						turnOver = true;
						break;
					}
						
					else if ((gridY - newY == 1) && (gridX == newX)) 
						&& (array_equals(global.grid[newX, newY],[0, 0]))
					{
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						turnOver = true;
						break;
					} 
						
					else if ( (gridY == 6) && (gridY - newY == 2) && (gridX == newX) 
						&& (array_equals(global.grid[newX, newY],[0, 0]))
						&& (array_equals(global.grid[gridX, gridY - 1],[0 , 0]) ) )
						{
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						turnOver = true;
						break;
						}
						
					break;
				}
					
				case KING:
				{
					if  ((abs (newX - gridX) <= 1) && (abs (newY - gridY) <= 1))
					{
					global.grid[newX, newY] = selectedPiece;
					pickedUp = false;
					selectedPiece = [0 , 0];
					turnOver = true;
					break;
					}
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
					pickedUp = false;
					selectedPiece = [0 , 0];
					turnOver = true;
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
						turnOver = true;
						break;
					}
				}
				
				case BISHOP:
				{
					if ((abs (newX - gridX)) != abs (newY - gridY ))
					{
						exit;
					}
					
					var rangeX = abs (newX - gridX);
					var rangeY = abs (newY - gridY);
					var minX = min(gridX, newX);
					var minY = min(gridY, newY);
					
					
					{
						global.grid[newX, newY] = selectedPiece;
						pickedUp = false;
						selectedPiece = [0 , 0];
						turnOver = true;
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
	