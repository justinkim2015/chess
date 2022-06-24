require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require 'pry'

class Game
  attr_accessor :board, :player1, :player2, :turn

  def initialize
    @player1 = Player.new('Player 1', 'White')
    @player2 = Player.new('Player 2', 'Black')
    @board = Board.new
    @turn = @player1
  end

  def move(start, fin)
    if board.grid[start[0]][start[1]] == @turn.pieces[:bishop1].color
      @turn.pieces[:bishop1].move(@board, start, fin)
    elsif board.grid[start[0]][start[1]] == @turn.pieces[:rook1].color
      @turn.pieces[:rook1].move(@board, start, fin)
    elsif board.grid[start[0]][start[1]] == @turn.pieces[:knight1].color
      @turn.pieces[:knight1].move(@board, start, fin)
    elsif board.grid[start[0]][start[1]] == @turn.pieces[:pawn1].color
      @turn.pieces[:pawn1].move_pawn(@board, start, fin)
    elsif board.grid[start[0]][start[1]] == @turn.pieces[:king].color
      @turn.pieces[:king].move(@board, start, fin)
    elsif board.grid[start[0]][start[1]] == @turn.pieces[:queen].color
      @turn.pieces[:queen].move(@board, start, fin)
    else
      puts 'Invalid move, try again'
    end
  end

  def take_turn
    board.drawboard
    puts "Its #{@turn.name}'s turn!"
    # check?
    start = valid_input_start
    puts 'Where would you like to move it?'
    fin = valid_input_fin
    move(start, fin)
    change_turn if board.grid[start[0]][start[1]] == ' '
  end

  # This is working but very inelegant
  def check?
    return unless spot_in_check?

    puts 'You are in check, protect your king!'
    start = valid_input_start
    fin = valid_input_fin
    move(start, fin)
    if spot_in_check?
      move(fin, start)
      check?
    end
    # The way that my king_in_check? function works is it looks at the current board
    # and checks if any current piece is checking the king.  It takes the two arguments
    # kings_spot and board.  So basically to check if the new value would be safe, I'd
    # have to move there, and check the value, if its not safe then I roll back the board
    # change and run the function again.
  end

  def spot_in_check?
    @turn.pieces[:king].king_in_check?(@board, @turn.pieces[:king].position)
  end

  # This is currently only checking the movement of the king to escape check
  def checkmate?
    start = @turn.pieces[:king].position
    fin = [[start[0] - 1, start[1]], [start[0] + 1, start[1]], [start[0], start[1] + 1], [start[0], start[1] - 1], [start[0] + 1, start[1] - 1], [start[0] + 1, start[1] + 1], [start[0] - 1, start[1] - 1], [start[0] - 1, start[1] + 1]]
    i = 0
    8.times do
      move(start, fin[i])
      return true if spot_in_check?

      move(fin[i], start)
      i += 1
    end
    false
  end

  def convert(value)
    letter_value = value[0].ord
    shift_value_letter = letter_value - 97

    num_value = value[-1].to_i
    shift_value_number = 8 - num_value

    [shift_value_number, shift_value_letter]
  end

  def valid_input_start
    input = convert(gets.chomp)

    return input if input[0].between?(0, 7) && input[1].between?(0, 7) &&
                    board.grid[input[0]][input[1]] != ' '

    puts 'INVALID SPACE'
    valid_input_start
  end

  def valid_input_fin
    input = convert(gets.chomp)

    return input if input[0].between?(0, 7) && input[1].between?(0, 7)

    puts 'INVALID SPACE'
    valid_input_fin
  end

  def change_turn
    @turn = if @turn == @player1
              @player2
            else
              @player1
            end
  end

  def place_pieces
    board.grid[0][0] = player2.pieces[:rook1].color
    board.grid[0][1] = player2.pieces[:knight1].color
    board.grid[0][2] = player2.pieces[:bishop1].color
    board.grid[0][4] = player2.pieces[:queen].color
    board.grid[0][3] = player2.pieces[:king].color
    board.grid[0][5] = player2.pieces[:bishop2].color
    board.grid[0][6] = player2.pieces[:knight2].color
    board.grid[0][7] = player2.pieces[:rook2].color
    board.grid[1][0] = player2.pieces[:pawn1].color
    board.grid[1][1] = player2.pieces[:pawn2].color
    board.grid[1][2] = player2.pieces[:pawn3].color
    board.grid[1][3] = player2.pieces[:pawn4].color
    board.grid[1][4] = player2.pieces[:pawn5].color
    board.grid[1][5] = player2.pieces[:pawn6].color
    board.grid[1][6] = player2.pieces[:pawn7].color
    board.grid[1][7] = player2.pieces[:pawn8].color

    board.grid[7][0] = player1.pieces[:rook1].color
    board.grid[7][1] = player1.pieces[:knight1].color
    board.grid[7][2] = player1.pieces[:bishop1].color
    board.grid[7][4] = player1.pieces[:queen].color
    board.grid[7][3] = player1.pieces[:king].color
    board.grid[7][5] = player1.pieces[:bishop2].color
    board.grid[7][6] = player1.pieces[:knight2].color
    board.grid[7][7] = player1.pieces[:rook2].color
    board.grid[6][0] = player1.pieces[:pawn1].color
    board.grid[6][1] = player1.pieces[:pawn2].color
    board.grid[6][2] = player1.pieces[:pawn3].color
    board.grid[6][3] = player1.pieces[:pawn4].color
    board.grid[6][4] = player1.pieces[:pawn5].color
    board.grid[6][5] = player1.pieces[:pawn6].color
    board.grid[6][6] = player1.pieces[:pawn7].color
    board.grid[6][7] = player1.pieces[:pawn8].color
  end
end
