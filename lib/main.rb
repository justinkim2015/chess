require_relative 'board'
require_relative 'player'

board = Board.new

board.grid[0][0] = 'f'
board.grid[0][1] = 'g'
board.grid[0][2] = 'h'
board.grid[0][3] = 'i'
board.grid[1][0] = 'a'
board.grid[2][0] = 'b'
board.grid[3][0] = 'c'
board.grid[4][0] = 'd'

board.drawboard


# board.make_row_blocks(:green, :red)
# board.make_row(:red, :green)
# board.make_row_value_with_data(:red, :green, 0)
# board.make_row(:red, :green)

# board.drawboard