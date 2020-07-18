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

//show_debug_message("value of startingxx is " + string(xx));
//show_debug_message("value of start yy is " + string(yy));
//show_debug_message("newX is " + string(newX));
//show_debug_message("newY is " + string(newY));

var chosenPiece = global.grid[xx, yy];
if !(array_equals(global.grid[newX, newY], [0, 0])) capture = true;
animate(chosenPiece, xx, yy, newX, newY);
//global.grid[newX, newY] = global.grid[xx, yy];   // move piece to new square
//global.grid[xx, yy] = [0, 0];    // delete piece from old square

if (newY == 7) && (array_equals(global.grid[newX, newY],[PAWN, BLACK])) // check for pawn promotion 
{
	global.grid[newX, newY] = [QUEEN, BLACK];
}

updateHistory_scr(chosenPiece, xx, yy, newX, newY, capture);
oGame.turn += 1;
oGame.state = "Player Turn";