class Bishop
  attr_accessor :color

  def initialize(color)
    @color = select_color(color)
  end

  def select_color(color)
    color == 'White' ? '♝' : '♗'
  end

  def move(board, x, y)
    board.grid[x][y] = @color
  end
end