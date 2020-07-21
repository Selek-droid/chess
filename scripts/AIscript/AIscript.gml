randomize();

if oGame.AIOpening
{
	AIOpeningsScript();  // returns true if able to move
	if (oGame.AIMadeScriptedMove) exit;  // bypass AI if AI made scripted move. Else on to AI.
}

var boardState = global.grid;
var capture = false;
var possibleMoves = ds_list_create();
var AISide = BLACK;

possibleMoves = possibleMoves_scr(AISide, boardState, true, true);  // generate ds_list of possible moves
possibleMoves = avoidCheck_scr(possibleMoves);   // prune them for check outside possMoves?
// maybe move this to inside possMoves?

var numberOfMoves = floor((ds_list_size(possibleMoves) / 4));
if (numberOfMoves == 0)   // Check for stalemate/checkmate eventually. For now, revert to player. 
	{
		show_debug_message("AI can't find a move")
	oGame.state = "Player Turn";
	exit;
	}
show_debug_message("number of moves is " + string(numberOfMoves));

// var boardState = global.grid;  // moved this up top.  Safely delete?
var listIndex = evaluate(possibleMoves, boardState);

// var listIndex = 4 * (irandom(numberOfMoves - 1));

var xx = ds_list_find_value(possibleMoves,listIndex);
var yy = ds_list_find_value(possibleMoves,listIndex + 1);
var newX = ds_list_find_value(possibleMoves,listIndex + 2);
var newY = ds_list_find_value(possibleMoves,listIndex + 3);

// check for castling double-move; special case; right side first
if (newY == 0) && (newX - xx == 2) 
{
	var chosenPiece = global.grid[xx, yy]; 
	if (chosenPiece[0] == KING)
	{
		ds_list_add(oGame.formattedHistory,"O-O");
		show_debug_message("0-0");
//		animateCastling(xx, newX);
		global.grid[4, 0] = [0, 0];
		global.grid[7, 0] = [0, 0];
		global.grid[6, 0] = [KING, BLACK];
		global.grid[5, 0] = [ROOK, BLACK];
		board_object.AICanCastleLeft = false;
		board_object.AICanCastleRight = false;
		oGame.turn += 1;
		oGame.state = "Player Turn";
		exit;
	}
}

if (newY == 0) && (xx - newX == 2)   // left side now
{
	var chosenPiece = global.grid[xx, yy];
	if (chosenPiece[0] == KING)
	{
		ds_list_add(oGame.formattedHistory,"O-O-0");
		show_debug_message("0-0-0");
//		animateCastling(xx, newX); DELETE THIS ENTIRE FUNCTION? PFFT
		global.grid[0, 0] = [0, 0];
		global.grid[4, 0] = [0, 0];
		global.grid[2, 0] = [KING, BLACK];
		global.grid[3, 0] = [ROOK, BLACK];
		board_object.AICanCastleLeft = false;
		board_object.AICanCastleRight = false;
		oGame.turn += 1;
		oGame.state = "Player Turn";
		exit;
	}
}
// ********** PERFORM THE MOVE! *****************

var chosenPiece = global.grid[xx, yy];
if !(array_equals(global.grid[newX, newY], [0, 0])) capture = true;
animate(chosenPiece, xx, yy, newX, newY);

// ******* post-move adjustments ***************

if (chosenPiece[0] == ROOK) && ( xx == 0 ) && ( yy == 0 ) board_object.AICanCastleLeft = false;
if (chosenPiece[0] == ROOK) && ( xx == 7 ) && ( yy == 0 ) board_object.AICanCastleRight = false;
if (chosenPiece[0] == KING) && ( (abs(newX - xx)) == 1 ) 
{
	board_object.AICanCastleLeft = false;
	board_object.AICanCastleRight = false;
}


updateHistory_scr(chosenPiece, xx, yy, newX, newY, capture);
oGame.turn += 1;
oGame.state = "Player Turn";