var possibleMoves = argument0;
var numberOfMoves = argument1;
var boardState = argument2;


for (var xx = 0; xx < 8; xx += 1;)
{
	for (var yy = 0; yy < 8; yy += 1;)
	{
		var piece = boardState[xx, yy];
		if piece[1] == BLACK
		{
			switch (piece[0])
			{
				case PAWN: 
				{
					points += VPAWN;
					break;
				}
				case KNIGHT:
				{
					points += VKNIGHT;
					break;
				}
				case BISHOP:
				{
					points += VBISHOP;
					break;
				}
				case ROOK:
				{
					points += VROOK;
					break;
				}
				case QUEEN:
				{
					points += VQUEEN;
					break;
				}
				case KING:
				{
					points += VKING;
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
					points -= VPAWN;
					break;
				}
				case KNIGHT:
				{
					points -= VKNIGHT;
					break;
				}
				case BISHOP:
				{
					points -= VBISHOP;
					break;
				}
				case ROOK:
				{
					points -= VROOK;
					break;
				}
				case QUEEN:
				{
					points -= VQUEEN;
					break;
				}
				case KING:
				{
					points -= VKING;
					break;
				}
			}
		}
	}
}

return points;