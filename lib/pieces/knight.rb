class Knight
  attr_accessor :color

  def initialize(color)
    @color = select_color(color)
  end

  def select_color(color)
    color == 'White' ? '♞' : '♘'
  end
end