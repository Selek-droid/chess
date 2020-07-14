gridX = 0;
gridY = 0;


// look for mouse click on a piece. If something there,
// store it, then clear its space, then put it on mouse cursor.
// Then look for second click. If valid, move piece there.
// If not valid, keep piece on cursor.
// If user hits ESC, cancel move, restore saved selection.

if (mouse_check_button_pressed(mb_left))
	if (mouse_x >= x) && (mouse_x <= x + BOARD_WIDTH)
		&& (mouse_y >= y) && (mouse_y <= y + BOARD_HEIGHT)
	{
		gridX = floor( ( mouse_x - x ) / SQUARE_SIZE );
		gridY = floor( ( mouse_y - y ) / SQUARE_SIZE );
		if (global.grid[gridX, gridY] != 0)
		{
			selectedPiece = global.grid[gridX, gridY];
			global.grid[gridX, gridY] = [0 , 0];
			
		}
		
	}