class Piece
  def initialize
    @white_pieces = ['♚', '♛', '♜', '♝', '♞', '♟']
    @black_pieces = ['♔', '♕', '♖', '♗', '♘', '♙']
  end

  def move(board, start, fin)
    return unless valid_move?(start, fin) && valid_spot?(board, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
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