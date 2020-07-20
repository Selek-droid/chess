var possibleMoves = argument0;
var boardState = argument1;
var listSize = (ds_list_size(possibleMoves)) - 4;
var positionScore = 0;
var maxScore = (0 - infinity);
var listIndex = 0;
var piece = [0 , 0];
var selectedPiece = [0 , 0];
var candidate = 0;

//  "make" each 4-element move in the list; save each move's positionScore and its index.

for (listIndex = 0; listIndex <= listSize; listIndex += 4)
{						
	var oldX = ds_list_find_value(possibleMoves,listIndex);
	var oldY = ds_list_find_value(possibleMoves,listIndex + 1);
	var newX = ds_list_find_value(possibleMoves,listIndex + 2);
	var newY = ds_list_find_value(possibleMoves,listIndex + 3);

	boardState = argument1;
	var selectedPiece = boardState[oldX, oldY];  // "move" piece to new location
	boardState[newX, newY] = selectedPiece;
	boardState[oldX, oldY] = [0 , 0]  // need to check for castling, but first test  *****
									//  Now score the new boardState:  ****************
	{
		for (var xx = 0; xx < 8; xx += 1;)
		{
			for (var yy = 0; yy < 8; yy += 1;)
			{
				var piece = boardState[xx, yy];
				if piece[1] == BLACK   // check each piece at each square
				
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
							positionScore += VKNIGHT;
							break;
						}
						case BISHOP:
						{
							positionScore += VBISHOP;
							break;
						}
						case ROOK:
						{
							positionScore += (VROOK + board_object.AIRookTable[xx, yy]);;
							break;
						}
						case QUEEN:
						{
							positionScore += VQUEEN;
							break;
						}
						case KING:
						{
							positionScore += VKING;
							break;
						}
					}
				}
				
				if piece[1] == WHITE
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
							positionScore -= VKNIGHT;
							break;
						}
						case BISHOP:
						{
							positionScore -= VBISHOP;
							break;
						}
						case ROOK:
						{
							positionScore -= (VROOK + board_object.HumanRookTable[xx, yy]);;
							break;
						}
						case QUEEN:
						{
							positionScore -= VQUEEN;
							break;
						}
						case KING:
						{
							positionScore -= VKING;
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
		
	if (positionScore > maxScore) 
		{
			maxScore = positionScore;
			candidate = listIndex;  //store list index of current best score
		}
	positionScore = 0;
	
}

show_debug_message("Index of best move was " + string(candidate) + " with score of " + string(maxScore));
show_debug_message("List size was " + string(listSize) + " and listIndex was " + string(listIndex)); 

return candidate;