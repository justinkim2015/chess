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

  def valid_move?(start, fin)
    return true if [fin[0], fin[1]] == [start[0] + 1, start[1] + 2] && ((start[0] + 1) && (start[1] + 2)) <= 7 ||
                   [fin[0], fin[1]] == [start[0] + 1, start[1] - 2] && ((start[0] + 1) <= 7 && (start[1] - 2)) >= 0 ||
                   [fin[0], fin[1]] == [start[0] + 2, start[1] + 1] && (start[0] + 2) && (start[1] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0] + 2, start[1] - 1] && (start[0] + 2) <= 7 && (start[1] - 1) >= 0 ||
                   [fin[0], fin[1]] == [start[0] - 1, start[1] + 2] && ((start[0] - 1) >= 0 && (start[1] + 2)) <= 7 ||
                   [fin[0], fin[1]] == [start[0] - 1, start[1] - 2] && (start[0] - 1) && (start[1] - 2) >= 0 ||
                   [fin[0], fin[1]] == [start[0] - 2, start[1] + 1] && (start[0] - 2) >= 0 && (start[1] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0] - 2, start[1] - 1] && (start[0] - 2) && (start[1] - 1) >= 0

    false
  end
end
