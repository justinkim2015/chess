# chess
This is the final project for the ruby portion of TOP.  I'm really excited to get working on this because after I finish I can move into learning some frameworks and other things that are used daily at companies.  I really want to start making personal projects that I can deploy to the internet and hopefully some of these things will actually be useful to myself and others.  

This project seems like a really big step-up in scale over the rest of the projects I've done until now and I think before I start I should really sit down and figure out what my plan is for this.

PARTS OF A CHESS GAME
-Board(8x8) *DONE*
-Players(2)*DONE*
-Pieces *DONE*
  -Pawns(8 ea)*DONE*
  -Rooks(2 ea)*DONE*
  -Bishops(2 ea)*DONE*
  -Knights(2 ea)*DONE*
  -Queen(1)*DONE*
  -King(1)*DONE*
-Game logic

TO-DO
-First and easiest I should create a Player class, with name and color saved on init. **DONE**

-Second I should figure out how to best represent the board.  In knight travails I used 32 nodes, but I think for this one I can use a 2d array because I'm only moving the piece once.   **DONE**

-To make a board, I want each space to be 3x3 grid of pixels so that it's not a board for ants.   **DONE**
  -Therefore I want to start with making a full row from the top with length of 9-ish.   **DONE**
  -Next I need to do the middle row of the 3x3 grid which is the hardest, I need every single middle value of the 3 to be different so I cant do an entire row at once.  I need to do 3 units, then switch colors, then do 3 units again.  **DONE**
    -The value I need that's in the @grid local variable is the value of grid[x][y]. and I need EVERY value so maybe I can use the each enumerator.  space/grid[0][0]/space.colorize(:color), next is space/grid[0][1]/space.colorize(:color) etc...  **DONE**

Now that I've figured out how to draw the board, next step is to figure out how to place the pieces on the board.  

-First of all I need to initialize an object for each of the 32 pieces and save them somewhere. **DONE saved to player classes**
  -If I save these to player class how will I call them? 
    -game.player1.knight
  -If I save these to game class how will I call them?
    -game.white_pieces.knight << This feels more messy, plus if I do it like this, player2 could potentially call player1's pieces.

*MAIN THING TO FIGURE OUT ATM, WHERE DO I SAVE THE LOCATIONS OF THE PIECES
-If I want to save the locations to game, board.grid[0][0] = player1.pieces[:rook1].color  **DONE** I don't need to save the locations anywhere, the board will track it.

What do I need to do to move a piece.  The things I need to know are
-Initial location
-End location
-Type of piece
**Done** 

So I can move the piece, now how should I get these three things in the game class.  

I want to be able to select the intial location by typing in 1a, 2c, etc...  What I need returned after typing in something like this is the coordinates of the piece and the color of the piece.  **DONE**

Next I need to figure out how to take a turn, where it doesn't change the turn with an invalid move.  *DONE but maybe could be done better*

How can I make a pawn move forward twice if its the first move?
- I can have a instance variable @turns but then I would need to make an individual object for every piece
- I can check the starting location of the piece and if it's where it starts on the board it can move twice, since pawns cant move backwards I don't have to worry about them going back to the same space and moving twice again. **DONE**
  - starting locations of pawns 
    -white [a2..h2]
    -white [a7..h2]

How can I check if the king is in check and which class should it be in?
  -If any enemy piece can move to a block then that block can be considered in check.  How can I 'check' (heh) this state?
    -Everytime the king tries to move to a new space, it'll check EVERY space that could possibly have an attacking enemy piece.   
      -So bascially first i'll check the two diags to see if theres a pawn there
        -white_king = x, y / possible black pawns = x-1, y-1 / x-1, y+1
      -Second i'll check the 4 cardinal directions til I hit a piece to see if its a queen or a rook
      -Third i'll check the 4 diags until I hit a piece to look for a queen or bishop
      -Fourth i'll check the 8 possible locations a knight could be.
    If all of these checks come back safe then the king can move to the spot.  If all these checks fail, the spot is marked unsafe and can't be moved too.
    
    If all possible moves of the king are deemed unsafe, the king is in checkmate and the game is finished.  

  -I should write this logic in the king class.  

# WAIT A KING MOVING CAN EXPOSE AN OPPOSING KING TO CHECK.  I NEED TO CHECK WHEN THE OPPONENT MOVES, NOT WHEN THE KING ITSELF MOVES. Oh wait I probably have to do both, as a king cannot move itself into check, but also can be checked by moving.  
  -If king is in check it must move, therefore maybe I should have an instance variable saying whether the kings in check or not.

  Basically I think with the way I'm doing this now, i'll just check if the king is in check after every move.  If i'm going to write it like this, maybe this king check logic should be in every single class.  For example pawn checking king should be in pawn class.  pawn_checking? or something.   

# before making a move make sure the move doesn't put the active players king into check.  

# before switching turns check if the opposing players king is in check

Check movement logic
  -If in check you must protect your king (eat attacking piece, move king, block with another piece)
    - Get start value of piece you want to protect with
    - get finish value of piece you want to protect with
    -using these two values check to see if king would be in check.
      -if so then move is illegal and ask to try again
      -if not then move is allowed.

Checkmate

There are no safe spaces left for king -> checkmate
-First check if the king itself can make any safe moves. **done**
-How to check if there are any pieces that can eat the enemy attacking piece?
  -Use king_in_check function except instead of king target the piece attacking the king.
    -For example a king at a8 is being threatened by a queen at a7.  A rook a a1 is attacking a7, therefore theres a move that will save the king. 

  I should probably actually refactor the (piece)_checking functions to attacking spots...  
     -#valid_move? is basically this function that checks if a piece is attacking a certain square but it also requires the starting position, so it would be a pain to always write it in.  So if I make every single piece know its starting position i can set the default value.  but this would mean every single piece must be its own object... 
      - **I think this is the way to go**
      - Have position also be set on making a new class in the player class.

  ***FIRST THING TO DO TOMORROW***
  -Find out why my piece is always in check, see what broke.
    -well only black pieces seem to be broken, white works just fine
    **STILL DONT KNOW WHY** But going to take a step away from the check method to refactor a bit so it's easier to see whats going on in my logic

