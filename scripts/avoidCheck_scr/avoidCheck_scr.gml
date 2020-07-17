// Check each move to see whether AI king is in check. If so, remove move.

// var legalMoves = ds_list_create();
// legalMoves = argument0;

var legalMoves = ds_list_create();
var boardState = global.grid;
var proposedState = boardState;
var numberOfMoves = floor( ( (ds_list_size(argument0)) / 4) );

// find AI King position

for (var xx = 0; xx < 8; xx += 1;)
{
	for (var yy = 0; yy < 8; yy += 1;)
	{
		if array_equals(boardState[xx, yy],[KING, BLACK])
		{
			var kingPosition = [xx , yy];
			break;
		}
	}
}

// Get each 4-position move in list of possible moves. oldx, oldy moves to proposed newx, newy.

for (var i = 0; i < numberOfMoves; i += 1;)
{
	var oldX = ds_list_find_value(argument0, 4 * i);
	var oldY = ds_list_find_value(argument0,( (4 * i) + 1 ));
	var newX = ds_list_find_value(argument0,(( 4 * i) + 2 ));
	var newY = ds_list_find_value(argument0,(( 4 * i) + 3 ));
//	show_debug_message("Here is the first recorded move " + string(xx) + " , " + string(yy) +
//		" , " + string(newX) + " , " + string(newY));
	
// "Make" the move, and see if king is on a "threatenedSquare"
	var movingPiece = boardState[oldX, oldY];
	proposedState[oldX, oldY] = [0, 0];
	proposedState[newX, newY] = [ movingPiece[0], movingPiece[1] ];
	
	if !threatenedSquare_scr(kingPosition[0],kingPosition[1], proposedState)
		{
			ds_list_add(legalMoves,oldX,oldY,newX,newY);
		}
	else show_debug_message("AI King should avoid check"); 
	
// Find King position after proposed move and test whether it's ok:	
	if (movingPiece[0] == KING) && !threatenedSquare_scr(newX, newY, proposedState)
	{
		ds_list_add(legalMoves,oldX,oldY,newX,newY);
	}
	
	
// "Unmake the move", whether or not the move is valid.
	proposedState = boardState;
	
}
	return legalMoves;
	


