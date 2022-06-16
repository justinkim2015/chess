class Player
  attr_accessor :pieces

  def initialize(name, color)
    @name = name
    @color = color
    @pieces = make_pieces
  end

  def make_pieces
    hash = {}
    hash[:rook] = Rook.new(@color)
    hash[:queen] = Queen.new(@color)
    hash[:king] = King.new(@color)
    hash[:bishop] = Bishop.new(@color)
    hash[:knight] = Knight.new(@color)
    hash[:pawn] = Pawn.new(@color)
    hash
  end
end