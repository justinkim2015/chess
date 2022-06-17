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
game.move
game.board.drawboard