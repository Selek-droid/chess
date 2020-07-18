// Find universe of possible moves.  Evaluate them.

randomize();

if oGame.AIOpening
{
	if (ds_list_find_value(oGame.formattedHistory,0) == "e4") && (oGame.turn == 1)
	{
		animate([PAWN, BLACK],2,1,2,3);
		//global.grid[2, 3] = global.grid[2, 1];   // Sicilian defense
		//global.grid[2, 1] = [0, 0]; 
		oGame.turn += 1;
		oGame.state = "Player Turn";
		exit;
	}
	if (oGame.turn == 2)
		animate([KNIGHT, BLACK],1,0,2,2);
		//global.grid[2, 2] = global.grid[1, 0];   // Sicilian defense
		//global.grid[1, 0] = [0, 0]; 
		oGame.turn += 1;
		oGame.state = "Player Turn";
		oGame.AIOpening = false;
		exit;
}

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
// show_debug_message("value of listIndex is " + string(listIndex));
// var indexByFour = floor((irandom(i)) / 4 );    // each list entry is 4 items long: x of piece, y of piece, x target, y target
// show_debug_message("value of indexByFour is " + string(indexByFour));
//var xx = ds_list_find_value(possibleMoves,indexByFour);
//var yy = ds_list_find_value(possibleMoves,indexByFour + 1);
//var newX = ds_list_find_value(possibleMoves,indexByFour + 2);
//var newY = ds_list_find_value(possibleMoves,indexByFour + 3);

var xx = ds_list_find_value(possibleMoves,listIndex);
var yy = ds_list_find_value(possibleMoves,listIndex + 1);
var newX = ds_list_find_value(possibleMoves,listIndex + 2);
var newY = ds_list_find_value(possibleMoves,listIndex + 3);

show_debug_message("value of startingxx is " + string(xx));
show_debug_message("value of start yy is " + string(yy));
show_debug_message("newX is " + string(newX));
show_debug_message("newY is " + string(newY));

var chosenPiece = global.grid[xx, yy];
animate(chosenPiece, xx, yy, newX, newY);
//global.grid[newX, newY] = global.grid[xx, yy];   // move piece to new square
//global.grid[xx, yy] = [0, 0];    // delete piece from old square

if (newY == 7) && (array_equals(global.grid[newX, newY],[PAWN, BLACK])) // check for pawn promotion 
{
	global.grid[newX, newY] = [QUEEN, BLACK];
}

oGame.turn += 1;
oGame.state = "Player Turn";