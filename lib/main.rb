require_relative 'board'
require_relative 'player'
require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'

board = Board.new
player1 = Player.new('Justin', 'White')
player2 = Player.new('Maya', 'Black')

board.drawboard

player1.pieces.each do |hash|
  p hash
end

puts '-------------------------------'

player2.pieces.each do |hash|
  p hash
end
