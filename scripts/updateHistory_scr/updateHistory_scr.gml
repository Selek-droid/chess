var piece = argument0;
var oldX = argument1;
var oldY = argument2;
var newX = argument3;
var newY = argument4;
var capture = argument5;

var formattedMove;

notationX[7] = "h";
notationX[6] = "g";
notationX[5] = "f";
notationX[4] = "e";
notationX[3] = "d";
notationX[2] = "c";
notationX[1] = "b";
notationX[0] = "a";

notationY[7] = "1";
notationY[6] = "2";
notationY[5] = "3";
notationY[4] = "4";
notationY[3] = "5";
notationY[2] = "6";
notationY[1] = "7";
notationY[0] = "8";

 
// store info for AI openings and stalemate by repetition
// reformat info to display to user (console for now)

ds_list_add(oGame.history,piece[0],oldX,oldY,newX,newY,capture);  
switch (piece[0]) 
{
	case PAWN: 
	{
		formattedMove = string(notationX[newX]) + string(notationY[newY]);
		break;
	}
	
	case BISHOP:
	{
		formattedMove = string("B") + string(notationX[newX]) + string(notationY[newY]);
		break;
	}
	
	case ROOK:
	{
		formattedMove = string("R") + string(notationX[newX]) + string(notationY[newY]);
		break;
	}
	
	case KNIGHT:
	{
		formattedMove = string("N") + string(notationX[newX]) + string(notationY[newY]);
		break;
	}
	
	case QUEEN:
	{
		formattedMove = string("Q") + string(notationX[newX]) + string(notationY[newY]);
		break;
	}
	
	case KING:
	{
		formattedMove = string("K") + string(notationX[newX]) + string(notationY[newY]);
	}
}

ds_list_add(oGame.formattedHistory,formattedMove);
show_debug_message(formattedMove);