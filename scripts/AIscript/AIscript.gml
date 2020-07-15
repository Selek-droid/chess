// Find universe of possible moves.  Evaluate them.

randomize();
var possibleMoves = ds_list_create();
possibleMoves = possiblePawnMoves_scr();
show_debug_message("value of possibleMoves is " + string(possibleMoves));
show_debug_message("possMoves contains " + ds_list_write(possibleMoves));

var i = ds_list_size(possibleMoves) - 1;
show_debug_message("value of i is " + string(i));
var indexByFour = floor((irandom(i)) / 4 );    // each list entry is 4 items long: x of piece, y of piece, x target, y target
show_debug_message("value of indexByFour is " + string(indexByFour));
//var xx = ds_list_find_value(possibleMoves,indexByFour);
//var yy = ds_list_find_value(possibleMoves,indexByFour + 1);
//var newX = ds_list_find_value(possibleMoves,indexByFour + 2);
//var newY = ds_list_find_value(possibleMoves,indexByFour + 3);

var xx = ds_list_find_value(possibleMoves,0);
var yy = ds_list_find_value(possibleMoves,1);
var newX = ds_list_find_value(possibleMoves,2);
var newY = ds_list_find_value(possibleMoves,3);

show_debug_message("value of xx is " + string(xx));
show_debug_message("value of yy is " + string(yy));


global.grid[newX, newY] = global.grid[xx, yy];   // move piece to new square
global.grid[xx, yy] = [0, 0];    // delete piece from old square

oGame.state = "Player Turn";