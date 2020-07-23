var possibleMoves = argument0;
var boardState = argument1;
var listSize = (ds_list_size(possibleMoves)) - 4;
var deepScore = 0;
var maxScore = (0 - infinity);
var listIndex = 0;
var candidate = 0;
var possibleTie = false;
var tieBreakerList = ds_list_create();
var moversSeat = argument2;  // The seat the AI is playing. Will switch in Minmax!
var moversColor = argument3; // The color the AI is playing. Will switch in MinMax! *************

//if moversColor == WHITE 
//{
//	var nonmoversColor = BLACK;   // i.e., we'll send nonmoversColor to Minmax.
//}
//else nonmoversColor = WHITE;

//if moversSeat == NORTH
//{
//	var nonmoversSeat = SOUTH;
//}
//else nonmoversSeat = NORTH;

for (listIndex = 0; listIndex <= listSize; listIndex += 4)
{						
	var oldX = ds_list_find_value(possibleMoves,listIndex);
	var oldY = ds_list_find_value(possibleMoves,listIndex + 1);
	var newX = ds_list_find_value(possibleMoves,listIndex + 2);
	var newY = ds_list_find_value(possibleMoves,listIndex + 3);

	boardState = argument1;  // crucial: refresh the board, undoing the move just tested

	var selectedPiece = boardState[oldX, oldY];  // "move" piece to new location
	boardState[newX, newY] = selectedPiece;
	boardState[oldX, oldY] = [0 , 0]  
	//show_debug_message("AI/black proposed this move: (" +  string(oldX) + " , " + string(oldY) + " to (" +
	//string(newX) + " , " + string(newY) + ")" );

// now, INSTEAD of scoring, we run PossMoves again to generate 20 more moves!
// Then score each of those, but for other side, and flip sign of result.
// We do this in the NEXT script.  Could do it here but my head hurts.
// Not sure how to set arguments for global.NorthCanCastle eligibility, as might have changed.

	deepScore = MinMax(boardState, moversSeat, moversColor); // generate poss responses & return SINGLE best score from them
	// show_debug_message("MinMax returned a score of " + string(deepScore));

	deepScore = 0 - deepScore;  // Flip Minmax result!  
	if (deepScore == maxScore)   // if a tie, store both, randomize
	{
		ds_list_add(tieBreakerList,listIndex);
		var possibleTie = true;
	}
	
	if (deepScore > maxScore)
	{
		maxScore = deepScore;
		if (possibleTie)
		{
			ds_list_clear(tieBreakerList);
			possibleTie = false;
		}
		candidate = listIndex;  //store list index of current best score
	}
	
	deepScore = 0;
}

if (possibleTie)
	{
		var tieBreakIndex = irandom((ds_list_size(tieBreakerList) - 1) );
		candidate = ds_list_find_value(tieBreakerList,tieBreakIndex);
		// show_debug_message(("Tie break Index was ") + string(tieBreakIndex));
	}

// show_debug_message("Index of best move was " + string(candidate) + " with score of " + string(maxScore));
// show_debug_message("List size was " + string(listSize) + " and listIndex was " + string(listIndex)); 

ds_list_destroy(tieBreakerList);

return candidate;