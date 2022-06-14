require_relative 'board'
require_relative 'player'

board = Board.new

board.grid[0][0] = 'f'
board.make_row_blocks(:red, :green, 0)
board.make_row_blocks(:green, :red, 1)


# board.make_row_blocks(:green, :red)
# board.make_row(:red, :green)
# board.make_row_value_with_data(:red, :green, 0)
# board.make_row(:red, :green)

# board.drawboard