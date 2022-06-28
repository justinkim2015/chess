require_relative 'board'
require_relative 'player'
require_relative 'game'
require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'

game = Game.new

game.place_pieces

# loop do
#   game.take_turn
# end

game.queen_attacking?(game.turn.pieces[:king].position)
p game.which_piece(game.turn.pieces[:king].position)
p game.spot_being_attacked?(game.turn.pieces[:king].position)
