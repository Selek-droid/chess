draw_self();

var xx;
var yy;

	//var gridX = x + (xx * SQUARE_SIZE);
	//var gridY = y + (yy * SQUARE_SIZE);


for (xx = 0; xx <= 7; xx += 1;)
{
	for (yy = 0; yy <= 7; yy += 1;)

	{
		if array_equals( global.grid[xx, yy] , [KNIGHT, WHITE] )
		{
			draw_sprite(white_knight_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [KNIGHT, BLACK] )
		{
			draw_sprite(black_knight_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [PAWN, BLACK] )
		{
			draw_sprite(black_pawn_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [PAWN, WHITE] )
		{
			draw_sprite(white_pawn_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}

	}
}