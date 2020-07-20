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

// Piece-square tables ============================================

AIpawnTable [7, 7] = 0;  // AI back rank; pawns never here until promoted
AIpawnTable [6, 7] = 0;
AIpawnTable [5, 7] = 0;
AIpawnTable [4, 7] = 0;
AIpawnTable [3, 7] = 0;
AIpawnTable [2, 7] = 0;
AIpawnTable [1, 7] = 0;
AIpawnTable [0, 7] = 0;

AIpawnTable [7, 6] = 50;  // AI on verge of promotion
AIpawnTable [6, 6] = 50;
AIpawnTable [5, 6] = 50;
AIpawnTable [4, 6] = 50;
AIpawnTable [3, 6] = 50;
AIpawnTable [2, 6] = 50;
AIpawnTable [1, 6] = 50;
AIpawnTable [0, 6] = 50;

AIpawnTable [7, 5] = 10;  // AI control center, player's side of board 
AIpawnTable [6, 5] = 10;
AIpawnTable [5, 5] = 20;
AIpawnTable [4, 5] = 30;
AIpawnTable [3, 5] = 30;
AIpawnTable [2, 5] = 20;
AIpawnTable [1, 5] = 10;
AIpawnTable [0, 5] = 10;

AIpawnTable [7, 4] = 5;  // AI control center, player side of board 
AIpawnTable [6, 4] = 5;
AIpawnTable [5, 4] = 10;
AIpawnTable [4, 4] = 25;
AIpawnTable [3, 4] = 25;
AIpawnTable [2, 4] = 10;
AIpawnTable [1, 4] = 5;
AIpawnTable [0, 4] = 5;

AIpawnTable [7, 3] = 0;  // AI's K4/Q4 etc, AI side of board 
AIpawnTable [6, 3] = 0;
AIpawnTable [5, 3] = 0;
AIpawnTable [4, 3] = 20;
AIpawnTable [3, 3] = 20;
AIpawnTable [2, 3] = 0;
AIpawnTable [1, 3] = 0;
AIpawnTable [0, 3] = 0;

AIpawnTable [7, 2] = 5;  // AI's K3/Q3 etc, AI side of board 
AIpawnTable [6, 2] = -5;
AIpawnTable [5, 2] = -10;
AIpawnTable [4, 2] = 0;
AIpawnTable [3, 2] = 0;
AIpawnTable [2, 2] = -10;
AIpawnTable [1, 2] = -5;
AIpawnTable [0, 2] = 5;

AIpawnTable [7, 1] = 5;  // AI's starting pawn row 
AIpawnTable [6, 1] = 10;
AIpawnTable [5, 1] = 10;
AIpawnTable [4, 1] = -20;
AIpawnTable [3, 1] = -20;
AIpawnTable [2, 1] = 10;
AIpawnTable [1, 1] = 10;
AIpawnTable [0, 1] = 5;

AIpawnTable [7, 0] = 0;  // AI's pawns never here, behind start row 
AIpawnTable [6, 0] = 0;
AIpawnTable [5, 0] = 0;
AIpawnTable [4, 0] = 0;
AIpawnTable [3, 0] = 0;
AIpawnTable [2, 0] = 0;
AIpawnTable [1, 0] = 0;
AIpawnTable [0, 0] = 0;


// --------------------------------------------

HumanPawnTable [7, 7] = 0;  // behind pawns starting spot, so never used
HumanPawnTable [6, 7] = 0;
HumanPawnTable [5, 7] = 0;
HumanPawnTable [4, 7] = 0;
HumanPawnTable [3, 7] = 0;
HumanPawnTable [2, 7] = 0;
HumanPawnTable [1, 7] = 0;
HumanPawnTable [0, 7] = 0;

HumanPawnTable [7, 6] = 5;  // human starting pawn row
HumanPawnTable [6, 6] = 10;  
HumanPawnTable [5, 6] = 10;  
HumanPawnTable [4, 6] = -20;  
HumanPawnTable [3, 6] = -20;  
HumanPawnTable [2, 6] = 10;  
HumanPawnTable [1, 6] = 10;  
HumanPawnTable [0, 6] = 5;  

HumanPawnTable [7, 5] = 5;  // row 3. Protect king; holes on edges
HumanPawnTable [6, 5] = -5; 
HumanPawnTable [5, 5] = -10; 
HumanPawnTable [4, 5] = 0; 
HumanPawnTable [3, 5] = 0; 
HumanPawnTable [2, 5] = -10; 
HumanPawnTable [1, 5] = -5; 
HumanPawnTable [0, 5] = 5; 

HumanPawnTable [7, 4] = 0; // row4. Control center.
HumanPawnTable [6, 4] = 0;
HumanPawnTable [5, 4] = 0;
HumanPawnTable [4, 4] = 20;
HumanPawnTable [3, 4] = 20;
HumanPawnTable [2, 4] = 0;
HumanPawnTable [1, 4] = 0;
HumanPawnTable [0, 4] = 0;

HumanPawnTable [7, 3] = 5;  // row 5.  Center again.
HumanPawnTable [6, 3] = 5;
HumanPawnTable [5, 3] = 10;
HumanPawnTable [4, 3] = 25;
HumanPawnTable [3, 3] = 25;
HumanPawnTable [2, 3] = 10;
HumanPawnTable [1, 3] = 5;
HumanPawnTable [0, 3] = 5;

HumanPawnTable [7, 2] = 10;  // row 6.  Center again.
HumanPawnTable [6, 2] = 10;
HumanPawnTable [5, 2] = 20;
HumanPawnTable [4, 2] = 30;
HumanPawnTable [3, 2] = 30;
HumanPawnTable [2, 2] = 20;
HumanPawnTable [1, 2] = 10;
HumanPawnTable [0, 2] = 10;

HumanPawnTable [7, 1] = 50;  // row 7.  Verge of promotion.
HumanPawnTable [6, 1] = 50;
HumanPawnTable [5, 1] = 50;
HumanPawnTable [4, 1] = 50;
HumanPawnTable [3, 1] = 50;
HumanPawnTable [2, 1] = 50;
HumanPawnTable [1, 1] = 50;
HumanPawnTable [0, 1] = 50;

HumanPawnTable [7, 0] = 0; // row 8. Becomes different piece if promoted.
HumanPawnTable [6, 0] = 0;
HumanPawnTable [5, 0] = 0;
HumanPawnTable [4, 0] = 0;
HumanPawnTable [3, 0] = 0;
HumanPawnTable [2, 0] = 0;
HumanPawnTable [1, 0] = 0;
HumanPawnTable [0, 0] = 0;

// ============== Rook tables

AIRookTable [7, 7] = 0;  // Until endgame, no reason to be here
AIRookTable [6, 7] = 0;
AIRookTable [5, 7] = 0;
AIRookTable [4, 7] = 0;
AIRookTable [3, 7] = 0;
AIRookTable [2, 7] = 0;
AIRookTable [1, 7] = 0;
AIRookTable [0, 7] = 0;

AIRookTable [7, 6] = -5;  // AI likes human second row
AIRookTable [6, 6] = 10;
AIRookTable [5, 6] = 10;
AIRookTable [4, 6] = 10;
AIRookTable [3, 6] = 10;
AIRookTable [2, 6] = 10;
AIRookTable [1, 6] = 10;
AIRookTable [0, 6] = -5;

AIRookTable [7, 5] = -5;  // keep off the edge files
AIRookTable [6, 5] = 0;
AIRookTable [5, 5] = 0;
AIRookTable [4, 5] = 0;
AIRookTable [3, 5] = 0;
AIRookTable [2, 5] = 0;
AIRookTable [1, 5] = 0;
AIRookTable [0, 5] = -5;

AIRookTable [7, 4] = -5;
AIRookTable [6, 4] = 0;
AIRookTable [5, 4] = 0;
AIRookTable [4, 4] = 0;
AIRookTable [3, 4] = 0;
AIRookTable [2, 4] = 0;
AIRookTable [1, 4] = 0;
AIRookTable [0, 4] = -5;

AIRookTable [7, 3] = -5;
AIRookTable [6, 3] = 0;
AIRookTable [5, 3] = 0;
AIRookTable [4, 3] = 0;
AIRookTable [3, 3] = 0;
AIRookTable [2, 3] = 0;
AIRookTable [1, 3] = 0;
AIRookTable [0, 3] = -5;

AIRookTable [7, 2] = -5;
AIRookTable [6, 2] = 0;
AIRookTable [5, 2] = 0;
AIRookTable [4, 2] = 0;
AIRookTable [3, 2] = 0;
AIRookTable [2, 2] = 0;
AIRookTable [1, 2] = 0;
AIRookTable [0, 2] = -5;

AIRookTable [7, 1] = -5;
AIRookTable [6, 1] = 0;
AIRookTable [5, 1] = 0;
AIRookTable [4, 1] = 0;
AIRookTable [3, 1] = 0;
AIRookTable [2, 1] = 0;
AIRookTable [1, 1] = 0;
AIRookTable [0, 1] = -5;

AIRookTable [7, 0] = 0;
AIRookTable [6, 0] = 0;
AIRookTable [5, 0] = 0;
AIRookTable [4, 0] = 5;
AIRookTable [3, 0] = 5;
AIRookTable [2, 0] = 0;
AIRookTable [1, 0] = 0;
AIRookTable [0, 0] = 0;

// Human rooks: ----------------------------------------------------

HumanRookTable [7, 7] = 0;
HumanRookTable [6, 7] = 0;
HumanRookTable [5, 7] = 0;
HumanRookTable [4, 7] = 5;
HumanRookTable [3, 7] = 5;
HumanRookTable [2, 7] = 0;
HumanRookTable [1, 7] = 0;
HumanRookTable [0, 7] = 0;

HumanRookTable [7, 6] = -5;
HumanRookTable [6, 6] = 0;
HumanRookTable [5, 6] = 0;
HumanRookTable [4, 6] = 0;
HumanRookTable [3, 6] = 0;
HumanRookTable [2, 6] = 0;
HumanRookTable [1, 6] = 0;
HumanRookTable [0, 6] = -5;

HumanRookTable [7, 5] = -5;
HumanRookTable [6, 5] = 0;
HumanRookTable [5, 5] = 0;
HumanRookTable [4, 5] = 0;
HumanRookTable [3, 5] = 0;
HumanRookTable [2, 5] = 0;
HumanRookTable [1, 5] = 0;
HumanRookTable [0, 5] = -5;

HumanRookTable [7, 4] = -5;
HumanRookTable [6, 4] = 0;
HumanRookTable [5, 4] = 0;
HumanRookTable [4, 4] = 0;
HumanRookTable [3, 4] = 0;
HumanRookTable [2, 4] = 0;
HumanRookTable [1, 4] = 0;
HumanRookTable [0, 4] = -5;

HumanRookTable [7, 3] = -5;
HumanRookTable [6, 3] = 0;
HumanRookTable [5, 3] = 0;
HumanRookTable [4, 3] = 0;
HumanRookTable [3, 3] = 0;
HumanRookTable [2, 3] = 0;
HumanRookTable [1, 3] = 0;
HumanRookTable [0, 3] = -5;

HumanRookTable [7, 2] = -5;
HumanRookTable [6, 2] = 0;
HumanRookTable [5, 2] = 0;
HumanRookTable [4, 2] = 0;
HumanRookTable [3, 2] = 0;
HumanRookTable [2, 2] = 0;
HumanRookTable [1, 2] = 0;
HumanRookTable [0, 2] = -5;

HumanRookTable [7, 1] = -5;
HumanRookTable [6, 1] = 10;
HumanRookTable [5, 1] = 10;
HumanRookTable [4, 1] = 10;
HumanRookTable [3, 1] = 10;
HumanRookTable [2, 1] = 10;
HumanRookTable [1, 1] = 10;
HumanRookTable [0, 1] = -5;

HumanRookTable [7, 0] = 0;
HumanRookTable [6, 0] = 0;
HumanRookTable [5, 0] = 0;
HumanRookTable [4, 0] = 0;
HumanRookTable [3, 0] = 0;
HumanRookTable [2, 0] = 0;
HumanRookTable [1, 0] = 0;
HumanRookTable [0, 0] = 0;












