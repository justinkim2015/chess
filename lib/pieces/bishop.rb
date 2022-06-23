require_relative 'piece'

class Bishop < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♝' : '♗'
  end

  def valid_move?(start, fin)
    i = 1
    7.times do
      return true if [fin[0], fin[1]] == [start[0] + i, start[1] + i] && ((start[0] + i) && (start[1] + i)) <= 7 ||
                     [fin[0], fin[1]] == [start[0] - i, start[1] - i] && ((start[0] - i) && (start[1] - i)) >= 0 ||
                     [fin[0], fin[1]] == [start[0] + i, start[1] - i] && (start[0] + i) <= 7 && (start[1] - i) >= 0 ||
                     [fin[0], fin[1]] == [start[0] - i, start[1] + i] && (start[0] - i) >= 0 && (start[1] + i) <= 7

      i += 1
    end
    false
  end
end
