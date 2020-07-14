var gridX = 0;
var gridY = 0;
var newX = 0;
var newY = 0;


// look for mouse click on a piece. If something there,
// store it, then clear its space, then put it on mouse cursor.
// Then look for second click. If valid, move piece there.
// If not valid, keep piece on cursor.
// If user hits ESC, cancel move, restore saved selection.


if (!pickedUp) && (mouse_check_button_released(mb_left)) 
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
			alarm[0] = room_speed;
		}
	}
}

if (pickedUp) && (mouse_check_button_released(mb_left))  // destination clicked
		{	newX = floor( ( mouse_x - x ) / SQUARE_SIZE );  // check if valid
			newY = floor( ( mouse_y - y ) / SQUARE_SIZE );
			if (array_equals(global.grid[newX, newY],[0, 0]))
				{
					global.grid[newX, newY] = selectedPiece;
					pickedUp = false;
					selectedPiece = [0 , 0]
				}
		}
		

	