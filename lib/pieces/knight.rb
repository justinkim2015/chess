require_relative 'piece'

class Knight < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♞' : '♘'
  end

  def moves(location, result = [])
    moves = [[1, 2], [2, 1], [-1, -2], [-2, -1], [-1, 2], [1, -2], [-2, 1], [2, -1]]
    moves.each do |move|
      x = location[0] + move[0]
      y = location[1] + move[1]
      result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end
    result
  end

  # If the spot is empty nothing can block a knight
  def path_empty?(_, _, _)
    true
  end
end
