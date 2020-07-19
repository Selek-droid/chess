// Find universe of possible moves.  Evaluate them.

randomize();

if oGame.AIOpening
{
	AIOpeningsScript();  // returns true if able to move
	if (oGame.AIMadeScriptedMove) exit;  // bypass AI if AI made scripted move. Else on to AI.
}

var capture = false;
var possibleMoves = ds_list_create();
possibleMoves = possibleMoves_scr();
possibleMoves = avoidCheck_scr(possibleMoves);

// show_debug_message("value of possibleMoves is " + string(possibleMoves));
// show_debug_message("possMoves contains " + ds_list_write(possibleMoves));

// var listSize = ds_list_size(possibleMoves) - 1;
var numberOfMoves = floor((ds_list_size(possibleMoves) / 4));
if (numberOfMoves == 0)   // Check for stalemate/checkmate eventually. For now, revert to player. 
	{
		show_debug_message("AI can't find a move")
	oGame.state = "Player Turn";
	exit;
	}
show_debug_message("number of moves is " + string(numberOfMoves));
var listIndex = 4 * (irandom(numberOfMoves - 1));

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
		//animate(chosenPiece, xx, yy, newX, newY);
		//updateHistory_scr(chosenPiece, xx, yy, newX, newY, capture);
		//var chosenPiece = global.grid[7, 0];   // move rook too
		//animate(chosenPiece, 7, 0, 5, 0);
		//board_object.AICanCastleLeft = false;
		//board_object.AICanCastleRight = false;
		//oGame.turn += 1;
		//oGame.state = "Player Turn";
		//exit;
	}
}

if (newY == 0) && (xx - newX == 2)   // left side now
{
	var chosenPiece = global.grid[xx, yy];
	if (chosenPiece[0] == KING)
	{
		//animate(chosenPiece, xx, yy, newX, newY);
		//updateHistory_scr(chosenPiece, xx, yy, newX, newY, capture);
		//var chosenPiece = global.grid[0, 0];   // move rook too
		//animate(chosenPiece, 0, 0, newX + 1, 0);
		//if (newX > xx) 	
		//{
		//	ds_list_add(oGame.formattedHistory,"O-O");
		//	show_debug_message("0-0");
		//}
		//else 
		//{
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

// most other cases:

var chosenPiece = global.grid[xx, yy];
if !(array_equals(global.grid[newX, newY], [0, 0])) capture = true;
animate(chosenPiece, xx, yy, newX, newY);


if (newY == 7) && (array_equals(global.grid[newX, newY],[PAWN, BLACK])) // check for pawn promotion 
{
	global.grid[newX, newY] = [QUEEN, BLACK];
}

updateHistory_scr(chosenPiece, xx, yy, newX, newY, capture);
oGame.turn += 1;
oGame.state = "Player Turn";