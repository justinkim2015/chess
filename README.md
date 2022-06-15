# chess
This is the final project for the ruby portion of TOP.  I'm really excited to get working on this because after I finish I can move into learning some frameworks and other things that are used daily at companies.  I really want to start making personal projects that I can deploy to the internet and hopefully some of these things will actually be useful to myself and others.  

This project seems like a really big step-up in scale over the rest of the projects I've done until now and I think before I start I should really sit down and figure out what my plan is for this.

PARTS OF A CHESS GAME
-Board(8x8)
-Players(2)
-Pieces ***This should also store the location of the piece possibly.***
  -Pawns(8 ea)
  -Rooks(2 ea)
  -Bishops(2 ea)
  -Knights(2 ea)
  -Queen(1)
  -King(1)
-Game logic

TO-DO
-First and easiest I should create a Player class, with name and color saved on init. **DONE**

-Second I should figure out how to best represent the board.  In knight travails I used 32 nodes, but I think for this one I can use a 2d array because I'm only moving the piece once.   **DONE**

-To make a board, I want each space to be 3x3 grid of pixels so that it's not a board for ants.   **DONE**
  -Therefore I want to start with making a full row from the top with length of 9-ish.   **DONE**
  -Next I need to do the middle row of the 3x3 grid which is the hardest, I need every single middle value of the 3 to be different so I cant do an entire row at once.  I need to do 3 units, then switch colors, then do 3 units again.  **DONE**
    -The value I need that's in the @grid local variable is the value of grid[x][y]. and I need EVERY value so maybe I can use the each enumerator.  space/grid[0][0]/space.colorize(:color), next is space/grid[0][1]/space.colorize(:color) etc...  **DONE**

Now that I've figured out how to draw the board, next step is to figure out how to place the pieces on the board.  

-First of all I need to initialize an object for each of the 32 pieces and save them somewhere. 
  -If I save these to player class how will I call them? 
    -game.player1.knight
  -If I save these to game class how will I call them?
    -game.white_pieces.knight << This feels more messy, plus if I do it like this, player2 could potentially call player1's pieces.

*MAIN THING TO FIGURE OUT ATM, WHERE DO I SAVE THE LOCATIONS OF THE PIECES
