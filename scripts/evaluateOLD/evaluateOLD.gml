var possibleMoves = argument0;
var boardState = argument1;
var listSize = (ds_list_size(possibleMoves)) - 4;
var positionScore = 0;
var maxScore = (0 - infinity);
var listIndex = 0;
var piece = [0 , 0];
var selectedPiece = [0 , 0];
var candidate = 0;
var possibleTie = false;
var tieBreakerList = ds_list_create();

var possibleResponses = ds_list_create();
var sizeOfResponseList = (ds_list_size(possibleResponses)) - 4;
var responseIndex = 0;

var moversColor = argument2; // Color will oscillate depending on as-yet-undeclared depth variable *************
if moversColor == WHITE 
{
	var nonmoversColor = BLACK;
}
else nonmoversColor = WHITE;
//  "make" each 4-element move in the list; save each move's positionScore and its index.

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

// now, INSTEAD of scoring, we run PossMoves again to generate 20 more moves!
// Then score each of those, but for other side, and flip sign of result.

	//possibleResponses = possibleMoves_scr(boardState, nonmoversColor, true, true);
	//for (responseIndex = 0; responseIndex <= sizeOfResponseList; responseIndex += 4)
	//{						
	//	var oldX = ds_list_find_value(possibleMoves,listIndex);
	//	var oldY = ds_list_find_value(possibleMoves,listIndex + 1);
	//	var newX = ds_list_find_value(possibleMoves,listIndex + 2);
	//	var newY = ds_list_find_value(possibleMoves,listIndex + 3);
	
	
									//  Now score the new boardState:  ****************
	{
		for (var xx = 0; xx < 8; xx += 1;)
		{
			for (var yy = 0; yy < 8; yy += 1;)
			{
				var piece = boardState[xx, yy];
				if piece[1] == moversColor   // check each piece at each square
				
				{
					switch (piece[0])
					{
						case PAWN: 
						{
							positionScore += (VPAWN + board_object.AIpawnTable[xx, yy]);
							break;
						}
						case KNIGHT:
						{
							positionScore += (VKNIGHT + board_object.AIKnightTable[xx, yy]);
							break;
						}
						case BISHOP:
						{
							positionScore += (VBISHOP + board_object.AIBishopTable[xx, yy]);
							break;
						}
						case ROOK:
						{
							positionScore += (VROOK + board_object.AIRookTable[xx, yy]);;
							break;
						}
						case QUEEN:
						{
							positionScore += (VQUEEN + board_object.AIQueenTable[xx, yy]);
							break;
						}
						case KING:
						{
							positionScore += (VKING + board_object.AIKingTable[xx, yy]);
							break;
						}
					}
				}
				
				if piece[1] == nonmoversColor
				{
					switch (piece[0])
					{
						case PAWN: 
						{
							positionScore -= (VPAWN + board_object.HumanPawnTable[xx, yy]);
							break;
						}
						case KNIGHT:
						{
							positionScore -= (VKNIGHT + board_object.HumanKnightTable[xx, yy]);
							break;
						}
						case BISHOP:
						{
							positionScore -= (VBISHOP + board_object.HumanBishopTable[xx, yy]);
							break;
						}
						case ROOK:
						{
							positionScore -= (VROOK + board_object.HumanRookTable[xx, yy]);;
							break;
						}
						case QUEEN:
						{
							positionScore -= (VQUEEN + board_object.HumanQueenTable[xx, yy]);
							break;
						}
						case KING:
						{
							positionScore -= (VKING + board_object.HumanKingTable[xx, yy]);
							break;
						}
					}
				}
			}
		}
	}
	// should have TOTAL positionScore from 64 loops thru the board. Pluses and minuses alike.	
	
	show_debug_message("ListIndex " + string(listIndex) + " : " + string(oldX) + " , " + 
			string(oldY) + " to " + string(newX) + string(" , ") + string(newY) + " score: " +
			string(positionScore));
	 
	if (positionScore == maxScore)   // if a tie, store both, randomize
	{
		ds_list_add(tieBreakerList,listIndex);
		var possibleTie = true;
	}
	
	if (positionScore > maxScore) 
	{ 
		if (possibleTie)
		{
			ds_list_clear(tieBreakerList);
			possibleTie = false;
		}
		maxScore = positionScore;
		candidate = listIndex;  //store list index of current best score
	}
	
	positionScore = 0;
	
}

show_debug_message("Index of best move was " + string(candidate) + " with score of " + string(maxScore));
show_debug_message("List size was " + string(listSize) + " and listIndex was " + string(listIndex)); 

if (possibleTie)
{
	var tieBreakIndex = irandom((ds_list_size(tieBreakerList) - 1) );
	candidate = ds_list_find_value(tieBreakerList,tieBreakIndex);
	show_debug_message(("Tie break Index was ") + string(tieBreakIndex));
}

ds_list_destroy(tieBreakerList);
return candidate;