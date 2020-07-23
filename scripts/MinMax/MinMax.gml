var boardState = argument0;
var moversSeat = argument1;  // in any human game, this will be NORTH. We flip to south below.
var moversColor = argument2;
var possibleMoves = ds_list_create();
var listSize = (ds_list_size(possibleMoves)) - 4;
var positionScore = 0;
var maxScore = (0 - infinity);
var listIndex = 0;
var piece = [0 , 0];
var selectedPiece = [0 , 0];
var candidate = 0;

if moversColor == WHITE   // flip color: white AI now "plays" as black, and vice-versa
{
	moversColor = BLACK;
	var nonmoversColor = WHITE;
} 

else if moversColor == BLACK // AI playing as black; flip it to white.
{
	moversColor = WHITE;
	var nonmoversColor = BLACK;
}

if moversSeat == NORTH   // flip side: north AI now "plays" as south, and vice-versa
{
	moversSeat = SOUTH;
	var nonmoversSeat = NORTH;
}

else if moversSeat == SOUTH
{
	moversSeat = NORTH;
	var nonmoversSeat = SOUTH;
}

// Got boardState from evaluate(), reflecting just one move.  Now generate all possible RESPONSES.

possibleMoves = possibleMoves_scr(boardState, moversSeat, moversColor, true, true);  // generate ds_list of possible moves
possibleMoves = avoidCheck_scr(possibleMoves, moversColor, moversSeat);   // prune them for check outside possMoves?

listSize = (ds_list_size(possibleMoves)) - 4;
// show_debug_message("Number of possible human responses was " + string(listSize));

//  "make" each 4-element move in the pruned list; just save highest score?

for (listIndex = 0; listIndex <= listSize; listIndex += 4)
{						
	var oldX = ds_list_find_value(possibleMoves,listIndex);
	var oldY = ds_list_find_value(possibleMoves,listIndex + 1);
	var newX = ds_list_find_value(possibleMoves,listIndex + 2);
	var newY = ds_list_find_value(possibleMoves,listIndex + 3);

	boardState = argument0;  // crucial: refresh the board, undoing the move just tested
// Number of possible human responses to this move was " + string(floor(listSize/4)));


	var selectedPiece = boardState[oldX, oldY];  // "move" piece to new location
	boardState[newX, newY] = selectedPiece;
	boardState[oldX, oldY] = [0 , 0]  

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
							// show_debug_message("Added Knight score for " + string(xx) + " , " + string(yy));
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
							// show_debug_message("Subtracted Knight score for " + string(xx) + " , " + string(yy));
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
		
//		show_debug_message("Tested this white response: (" +  string(oldX) + " , " + string(oldY) + " to (" +
//	string(newX) + " , " + string(newY) + ")" );
		//show_debug_message("Response-move ListIndex " + string(listIndex) + " :  (" + string(oldX) + " , " + 
		//	string(oldY) + ") to  (" + string(newX) + string(" , ") + string(newY) + ") initial deepScore: " +
		//	string(positionScore));

	if (positionScore > maxScore) 
	{ 
		maxScore = positionScore;
		candidate = listIndex;  // unnecessary, I think; delete?
	}
	
	positionScore = 0;

	
	}
	// show_debug_message("Index of best DEEP move was " + string(candidate) + " with score of " + string(maxScore));
	// show_debug_message("List size was " + string(listSize) + " and listIndex was " + string(listIndex)); 
}

return maxScore;