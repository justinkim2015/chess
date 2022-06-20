require_relative 'piece'

class King < Piece
  attr_accessor :color

  def initialize(color)
    super()
    @color = select_color(color)
  end

  def select_color(color)
    color == 'White' ? '♚' : '♔'
  end

  def valid_move?(start, fin)
    return true if [fin[0], fin[1]] == [start[0] - 1, start[1]] && (start[0] - 1) >= 0 ||
                   [fin[0], fin[1]] == [start[0] + 1, start[1]] && (start[0] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0], start[1] + 1] && (start[1] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0], start[1] - 1] && (start[1] - 1) >= 0 ||
                   [fin[0], fin[1]] == [start[0] + 1, start[1] - 1] && ((start[0] + 1) <= 7 && (start[1] - 1)) >= 0 ||
                   [fin[0], fin[1]] == [start[0] + 1, start[1] + 1] && (start[0] + 1) && (start[1] + 1) <= 7 ||
                   [fin[0], fin[1]] == [start[0] - 1, start[1] - 1] && (start[0] - 1) && (start[1] - 1) >= 0 ||
                   [fin[0], fin[1]] == [start[0] - 1, start[1] + 1] && (start[0] - 1) >= 0 && (start[1] + 1) <= 7

    false
  end
end