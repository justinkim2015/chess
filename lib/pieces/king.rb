require_relative 'piece'
require 'pry'

class King < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @in_check = false
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♚' : '♔'
  end

  def moves(location, result = [])
    moves = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [-1, 1], [1, -1]]
    moves.each do |move|
      x = location[0] + move[0]
      y = location[1] + move[1]
      result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end
    result
  end
end
