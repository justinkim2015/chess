require_relative 'board'
require_relative 'player'
require_relative 'game'
require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require 'pry'

game = Game.new

gamefiles = game.load
game = if gamefiles.nil?
         Game.new
       else
         gamefiles
       end

game.place_pieces

loop do
  if game.checkmate?
    game.winner_message
    break
  end

  game.take_turn
end
