draw_self();

if (animateSprite) 
{
	if ! (spriteInMotion)
	{
		global.grid[oldX, oldY] = [0, 0];
		spriteInMotion = true;
	}
	draw_sprite(movingSprite,-1,(spriteX + ((loc * deltaX)/ 20)),(spriteY + ((loc * deltaY)/ 20)));
	loc += 1;
	if (loc > 19) 
	{		
		global.grid[newX, newY] = movingPiece;   // Sicilian defense		
		animateSprite = false;
		spriteInMotion = false;
		loc = 0;
	}	 
}

var xx;
var yy;

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
		
		if array_equals( global.grid[xx, yy] , [BISHOP, WHITE] )
		{
			draw_sprite(white_bishop_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [ROOK, WHITE] )
		{
			draw_sprite(white_rook_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [QUEEN, WHITE] )
		{
			draw_sprite(white_queen_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [KING, WHITE] )
		{
			draw_sprite(white_king_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [PAWN, WHITE] )
		{
			draw_sprite(white_pawn_sprite, -1, 
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
		
		if array_equals( global.grid[xx, yy] , [QUEEN, BLACK] )
		{
			draw_sprite(black_queen_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [BISHOP, BLACK] )
		{
			draw_sprite(black_bishop_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [ROOK, BLACK] )
		{
			draw_sprite(black_rook_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( global.grid[xx, yy] , [KING, BLACK] )
		{
			draw_sprite(black_king_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
	
	}
}

if ! (array_equals(selectedPiece, [0 , 0]) )
{
	if array_equals( selectedPiece , [PAWN, WHITE]) 
		draw_sprite(white_pawn_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [ROOK, WHITE]) 
		draw_sprite(white_rook_sprite,-1,mouse_x - 32, mouse_y - 32);
		 		
	else if array_equals( selectedPiece , [KNIGHT, WHITE]) 
		draw_sprite(white_knight_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [BISHOP, WHITE]) 
		draw_sprite(white_bishop_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [QUEEN, WHITE]) 
		draw_sprite(white_queen_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [KING, WHITE]) 
		draw_sprite(white_king_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [PAWN, BLACK]) 
		draw_sprite(black_pawn_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [ROOK, BLACK]) 
		draw_sprite(black_rook_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [KNIGHT, BLACK]) 
		draw_sprite(black_knight_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [BISHOP, BLACK]) 
		draw_sprite(black_bishop_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [QUEEN, BLACK]) 
		draw_sprite(black_queen_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [KING, BLACK]) 
		draw_sprite(black_king_sprite,-1,mouse_x - 32, mouse_y - 32);
}
