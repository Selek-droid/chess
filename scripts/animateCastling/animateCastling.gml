// side = argument0;
board_object.movingPiece = [KING, BLACK];
board_object.oldX = argument0;
board_object.oldY = 0;
board_object.newX = argument1;
board_object.newY = 0;

// King moves two right on right side.

board_object.spriteX = board_object.x + (SQUARE_SIZE * argument0);
board_object.spriteY = board_object.y;
var newSpriteX = board_object.x + (SQUARE_SIZE * argument1);
// var newSpriteY = board_object.y + (SQUARE_SIZE * argument4);
board_object.deltaX = newSpriteX - board_object.spriteX;
board_object.deltaY = 0;
// board_object.movingSprite = black_king_sprite;

// board_object.castlingRookSprite = black_rook_sprite;

board_object.displayCastling = true; 
		  