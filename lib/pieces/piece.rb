class Piece
  def initialize
    @white_pieces = ['♚', '♛', '♜', '♝', '♞', '♟']
    @black_pieces = ['♔', '♕', '♖', '♗', '♘', '♙']
  end

  def valid_spot?(board, spot)
    enemy_pieces = if @color == 'White'
                     @black_pieces
                   else
                     @white_pieces
                   end

    return true unless enemy_pieces.include?(board.grid[spot[0]][spot[1]])

    false
  end
end