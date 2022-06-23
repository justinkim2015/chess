class Player
  attr_accessor :pieces, :name

  def initialize(name, color)
    @name = name
    @color = color
    @pieces = make_pieces(@color)
  end

  def positions
    if @color == 'White'
    else
    end
  end

  def make_pieces(color)
    hash = {}
    if color == 'White'
      hash[:rook1] = Rook.new(@color, [0, 0])
      hash[:rook2] = Rook.new(@color, [0, 7])
      hash[:queen] = Queen.new(@color, [0, 4])
      hash[:king] = King.new(@color, [0, 3])
      hash[:bishop1] = Bishop.new(@color, [0, 2])
      hash[:bishop2] = Bishop.new(@color, [0, 5])
      hash[:knight1] = Knight.new(@color, [0, 1])
      hash[:knight2] = Knight.new(@color, [0, 6])
      hash[:pawn1] = Pawn.new(@color, [1, 0])
      hash[:pawn2] = Pawn.new(@color, [1, 1])
      hash[:pawn3] = Pawn.new(@color, [1, 2])
      hash[:pawn4] = Pawn.new(@color, [1, 3])
      hash[:pawn5] = Pawn.new(@color, [1, 4])
      hash[:pawn6] = Pawn.new(@color, [1, 5])
      hash[:pawn7] = Pawn.new(@color, [1, 6])
      hash[:pawn8] = Pawn.new(@color, [1, 7])
    else
      hash[:rook1] = Rook.new(@color, [7, 0])
      hash[:rook2] = Rook.new(@color, [7, 7])
      hash[:queen] = Queen.new(@color, [7, 4])
      hash[:king] = King.new(@color, [7, 3])
      hash[:bishop1] = Bishop.new(@color, [7, 2])
      hash[:bishop2] = Bishop.new(@color, [7, 5])
      hash[:knight1] = Knight.new(@color, [7, 1])
      hash[:knight2] = Knight.new(@color, [7, 6])
      hash[:pawn1] = Pawn.new(@color, [6, 0])
      hash[:pawn2] = Pawn.new(@color, [6, 1])
      hash[:pawn3] = Pawn.new(@color, [6, 2])
      hash[:pawn4] = Pawn.new(@color, [6, 3])
      hash[:pawn5] = Pawn.new(@color, [6, 4])
      hash[:pawn6] = Pawn.new(@color, [6, 5])
      hash[:pawn7] = Pawn.new(@color, [6, 6])
      hash[:pawn8] = Pawn.new(@color, [6, 7])
    end
    hash
  end
end