class Player
  def initialize(name, color)
    @name = name
    @color = color
    @pieces = make_pieces
  end

  def make_pieces
    array = []
    array << Rook.new(@color)
    array << Rook.new(@color)
    array
  end
end