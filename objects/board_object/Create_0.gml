x = (room_width/2) - (BOARD_WIDTH/2);
y = (room_height/2) - (BOARD_HEIGHT/2);

animateSprite = false;
spriteInMotion = false;
movingSprite = PAWN;
movingPiece = [PAWN, BLACK];
oldX = 0;
oldY = 0;
newX = 0;
newY = 0;
spriteX = 0;
spriteY = 0;
deltaX = 0;
deltaY = 0;
loc = 0;
// kingDoneCastling = true;  // prolly will delete castle-animate code?
// displayCastling = false;

// contents of squares: Piece, Color.

contents[1] = 0;
contents[0] = 0;
selectedPiece[1] = 0;
selectedPiece[0] = 0;
pickedUp = false;
turnOver = false;
canCastleLeft = true;
canCastleRight = true;
AICanCastleLeft = true;
AICanCastleRight = true;

gridX = 0;
gridY = 0;

var xx;
var yy;

// Populate board.

for (xx = 0; xx < 8; xx += 1;)
{
	for (yy = 0; yy < 8; yy += 1;)
	{
		global.grid[xx, yy] = contents;
	}
}

for (xx = 0; xx < 8; xx += 1;)
{
	global.grid[xx, 1] = [PAWN, BLACK];
}

for (xx = 0; xx < 8; xx += 1;)
{
	global.grid[xx, 6] = [PAWN, WHITE];
}

global.grid[0, 0] = [ROOK, BLACK];
global.grid[7, 0] = [ROOK, BLACK];
global.grid[1, 0] = [KNIGHT, BLACK];
global.grid[6, 0] = [KNIGHT, BLACK];
global.grid[2, 0] = [BISHOP, BLACK];
global.grid[5, 0] = [BISHOP, BLACK];
global.grid[3, 0] = [QUEEN, BLACK];
global.grid[4, 0] = [KING, BLACK];

global.grid[0, 7] = [ROOK, WHITE];
global.grid[7, 7] = [ROOK, WHITE];
global.grid[1, 7] = [KNIGHT, WHITE];
global.grid[6, 7] = [KNIGHT, WHITE];
global.grid[2, 7] = [BISHOP, WHITE];
global.grid[5, 7] = [BISHOP, WHITE];
global.grid[3, 7] = [QUEEN, WHITE];
global.grid[4, 7] = [KING, WHITE];
