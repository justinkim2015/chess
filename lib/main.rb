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
#   p game.which_piece(game.turn.pieces[:king].position)
# end

# game.queen_attacking?(game.turn.pieces[:king].position)
# p game.spot_being_attacked?(game.turn.pieces[:king].position)

puts '#which_piece_checking'
p game.turn.pieces[:king].position
p game.which_piece_checking(game.turn.pieces[:king].position)
p game.turn.pieces[:king].position

puts '----------------------'
game = Game.new

puts '#spot_being_attacked?'
p game.turn.pieces[:king].position
p game.spot_being_attacked?(game.turn.pieces[:king].position)
p game.turn.pieces[:king].position

puts '----------------------'
game = Game.new

puts '#check?'
p game.turn.pieces[:king].position
p game.check?
p game.turn.pieces[:king].position
