piece = argument0;
board_object.oldX = board_object.x + (SQUARE_SIZE * argument1);
board_object.oldY = board_object.y + (SQUARE_SIZE * argument2);
var newX = board_object.x + (SQUARE_SIZE * argument3);
var newY = board_object.y + (SQUARE_SIZE * argument4);

board_object.deltaX = newX - oldX;
board_object.deltaY = newY - oldY;

switch (piece)
{
	case PAWN:
	{
		board_object.movingSprite = black_pawn_sprite;
		break;
	}
	
	case BISHOP:
	{
		board_object.movingSprite = black_bishop_sprite;
		break;
	}
	
	case KNIGHT:
	{
		board_object.movingSprite = black_knight_sprite;
		break;
	}
	
	case ROOK:
	{
		board_object.movingSprite = black_rook_sprite;
		break;
	}
	
	case QUEEN:
	{
		board_object.movingSprite = black_queen_sprite;
		break;
	}
	
	case KING:
	{
		board_object.movingSprite = black_king_sprite;
	}
}

board_object.animateSprite = true;

//for (var i = 0; i < 100; i += 1;)
//{
//	draw_sprite(movingSprite,-1,(oldX + ((i * deltaX)/ 100)),(oldY + ((i * deltaY)/ 100)));
	
//}

		  
		  