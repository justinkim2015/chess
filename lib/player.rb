class Player
  attr_accessor :pieces

  def initialize(name, color)
    @name = name
    @color = color
    @pieces = make_pieces
  end

  def make_pieces
    hash = {}
    hash[:rook1] = Rook.new(@color)
    hash[:rook2] = Rook.new(@color)
    hash[:queen] = Queen.new(@color)
    hash[:king] = King.new(@color)
    hash[:bishop1] = Bishop.new(@color)
    hash[:bishop2] = Bishop.new(@color)
    hash[:knight1] = Knight.new(@color)
    hash[:knight2] = Knight.new(@color)
    hash[:pawn1] = Pawn.new(@color)
    hash[:pawn2] = Pawn.new(@color)
    hash[:pawn3] = Pawn.new(@color)
    hash[:pawn4] = Pawn.new(@color)
    hash[:pawn5] = Pawn.new(@color)
    hash[:pawn6] = Pawn.new(@color)
    hash[:pawn7] = Pawn.new(@color)
    hash[:pawn8] = Pawn.new(@color)
    hash
  end
end