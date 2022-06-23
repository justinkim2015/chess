class Piece
  def initialize
    @white_pieces = ['♚', '♛', '♜', '♝', '♞', '♟']
    @black_pieces = ['♔', '♕', '♖', '♗', '♘', '♙']
  end

  def move(board, start, fin)
    return unless can_attack_square?(board, start, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
    @location = fin
  end

  def can_attack_square?(board, start = @location, fin)
    valid_move?(start, fin) && valid_spot?(board, fin)
  end

  def valid_spot?(board, spot)
    enemy_pieces = if @white_pieces.include?(@color)
                     @black_pieces
                   else
                     @white_pieces
                   end

    return true if enemy_pieces.include?(board.grid[spot[0]][spot[1]]) ||
                   board.grid[spot[0]][spot[1]] == ' '

    false
  end
end