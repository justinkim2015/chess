require_relative 'piece'

class Knight < Piece
  attr_accessor :color

  def initialize(color)
    super()
    @color = select_color(color)
  end

  def select_color(color)
    color == 'White' ? '♞' : '♘'
  end
end
