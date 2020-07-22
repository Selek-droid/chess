//var boardState = argument0;
//var listOfMoves = ds_list_create();
//listOfMoves = argument1;

//var moversColor = argument2;
//var nonmoversColor = WHITE;
//if moversColor == WHITE nonmoversColor = BLACK;


//for (responseIndex = 0; responseIndex <= sizeOfResponseList; responseIndex += 4)
//	{						
//		var oldX = ds_list_find_value(possibleMoves,responseIndex);
//		var oldY = ds_list_find_value(possibleMoves,responseIndex + 1);
//		var newX = ds_list_find_value(possibleMoves,responseIndex + 2);
//		var newY = ds_list_find_value(possibleMoves,responseIndex + 3);
	
//	for (var xx = 0; xx < 8; xx += 1;)
//	{
//		for (var yy = 0; yy < 8; yy += 1;)
//		{
//			var piece = boardState[xx, yy];
//			if piece[1] == nonmoversColor   // check each piece at each square
				
//			{
//				switch (piece[0])
//				{
//					case PAWN: 
//					{
//						positionScore += (VPAWN + board_object.AIpawnTable[xx, yy]);
//						break;
//					}
//					case KNIGHT:
//					{
//						positionScore += (VKNIGHT + board_object.AIKnightTable[xx, yy]);
//						break;
//					}
//					case BISHOP:
//					{
//						positionScore += (VBISHOP + board_object.AIBishopTable[xx, yy]);
//						break;
//					}
//					case ROOK:
//					{
//						positionScore += (VROOK + board_object.AIRookTable[xx, yy]);;
//						break;
//					}
//					case QUEEN:
//					{
//						positionScore += (VQUEEN + board_object.AIQueenTable[xx, yy]);
//						break;
//					}
//					case KING:
//					{
//						positionScore += (VKING + board_object.AIKingTable[xx, yy]);
//						break;
//					}
//				}
//			}
				
//			if piece[1] == moversColor
//			{
//				switch (piece[0])
//				{
//					case PAWN: 
//					{
//						positionScore -= (VPAWN + board_object.HumanPawnTable[xx, yy]);
//						break;
//					}
//					case KNIGHT:
//					{
//						positionScore -= (VKNIGHT + board_object.HumanKnightTable[xx, yy]);
//						break;
//					}
//					case BISHOP:
//					{
//						positionScore -= (VBISHOP + board_object.HumanBishopTable[xx, yy]);
//						break;
//					}
//					case ROOK:
//					{
//						positionScore -= (VROOK + board_object.HumanRookTable[xx, yy]);;
//						break;
//					}
//					case QUEEN:
//					{
//						positionScore -= (VQUEEN + board_object.HumanQueenTable[xx, yy]);
//						break;
//					}
//					case KING:
//					{
//						positionScore -= (VKING + board_object.HumanKingTable[xx, yy]);
//						break;
//					}
//				}
//			}
//		}
//	}
//}
//// should have TOTAL positionScore from 64 loops thru the board. Pluses and minuses alike.	
	
//show_debug_message("ListIndex " + string(listIndex) + " : " + string(oldX) + " , " + 
//		string(oldY) + " to " + string(newX) + string(" , ") + string(newY) + " score: " +
//		string(positionScore));
	 
//if (positionScore == maxScore)   // if a tie, store both, randomize
//{
//	ds_list_add(tieBreakerList,responseIndex);
//	var possibleTie = true;
//}
	
//if (positionScore > maxScore) 
//{ 
//	if (possibleTie)
//	{
//		ds_list_clear(tieBreakerList);
//		possibleTie = false;
//	}
//	maxScore = positionScore;
//	candidate = responseIndex;  //store list index of current best score
//}
	
//positionScore = 0;
	
//}

//show_debug_message("Index of best move was " + string(candidate) + " with score of " + string(maxScore));
//show_debug_message("List size was " + string(listSize) + " and listIndex was " + string(listIndex)); 

//if (possibleTie)
//{
//	var tieBreakIndex = irandom((ds_list_size(tieBreakerList) - 1) );
//	candidate = ds_list_find_value(tieBreakerList,tieBreakIndex);
//	show_debug_message(("Tie break Index was ") + string(tieBreakIndex));
//}
//}
//ds_list_destroy(tieBreakerList);
//return candidate;