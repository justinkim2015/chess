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
      false
    end
  end

  def take_turn
    board.drawboard
    puts "Its #{@turn.name}'s turn!"
    puts 'youre in check!' if check?
    start = valid_input_start
    puts 'Where would you like to move it?'
    fin = valid_input_fin
    move(start, fin)
    puts 'you checked the enemy!' if check?
    change_turn if board.grid[start[0]][start[1]] == ' '
  end

  def check?
    return true if spot_being_attacked?(@turn.pieces[:king].position)

    false
  end

  def spot_being_attacked?(spot)
    enemy = @turn == @player1 ? @player2 : @player1

    return true if enemy.pieces[:pawn1].pawn_attacking_square?(@board, spot) ||
                   enemy.pieces[:bishop1].attacking_square?(@board, spot) ||
                   enemy.pieces[:knight1].attacking_square?(@board, spot) ||
                   enemy.pieces[:queen].attacking_square?(@board, spot) ||
                   enemy.pieces[:rook1].attacking_square?(@board, spot)

    false
  end

  # currently this checks which piece and where the piece is thats attacking a spot
  def which_piece(spot)
    enemy = @turn == @player1 ? @player2 : @player1

    if enemy.pieces[:pawn1].pawn_attacking_square?(@board, spot)
      return enemy.pieces[:pawn1].pawn_attacking_square_info(@board, spot)
    elsif enemy.pieces[:bishop1].attacking_square?(@board, spot)
      return enemy.pieces[:bishop1].attacking_square_info(@board, spot)
    elsif enemy.pieces[:knight1].attacking_square?(@board, spot)
      return enemy.pieces[:knight1].attacking_square_info(@board, spot)
    elsif enemy.pieces[:queen].attacking_square?(@board, spot)
      return enemy.pieces[:queen].attacking_square_info(@board, spot)
    elsif enemy.pieces[:rook1].attacking_square?(@board, spot)
      return enemy.pieces[:rook1].attacking_square_info(@board, spot)
    end
    'nothing'
  end

  # The queens are checking each other for some reason
  # I wrote this to try to find the reason why its in check
  def queen_attacking?(spot)
    # enemy = @turn == @player1 ? @player2 : @player1

    # player1 is white
    # player2 is black
    if @player2.pieces[:queen].attacking_square?(@board, spot)
      p 'queen is checking king'
      p spot
      puts '--------'
      p @player1.name
      p @player1.pieces[:king].position
      puts '--------'
      p @player2.name
      p @player2.pieces[:queen].position
      puts '--------'
      puts 'player 2 queen moves'
      p @player2.pieces[:queen].moves(@player2.pieces[:queen].position)
    end 
    p board.grid[0][0]
    board.drawboard
  end

  def checkmate?
    king_escape?
  end

  def king_save_eat?
  end

  # This is currently only checking the movement of the king to escape check
  # It does it by checking if the updated spot after calling move is being attacked
  def king_escape?
    start = @turn.pieces[:king].position
    fin = @turn.pieces[:king].moves(start)
    array = []
    fin.each do |spot|
      move(start, spot)
      array << spot if spot_being_attacked?(@turn.pieces[:king].position)

      move(spot, start)
    end
    array.length == fin.length
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

  # Maybe I can use blocks to clean this up
  def place_pieces
    board.grid[0][0] = player2.pieces[:rook1].color
    board.grid[0][1] = player2.pieces[:knight1].color
    board.grid[0][2] = player2.pieces[:bishop1].color
    board.grid[0][4] = player2.pieces[:queen].color
    board.grid[0][3] = player2.pieces[:king].color
    board.grid[0][5] = player2.pieces[:bishop2].color
    board.grid[0][6] = player2.pieces[:knight2].color
    board.grid[0][7] = player2.pieces[:rook2].color
    # board.grid[1][0] = player2.pieces[:pawn1].color
    # board.grid[1][1] = player2.pieces[:pawn2].color
    # board.grid[1][2] = player2.pieces[:pawn3].color
    # board.grid[1][3] = player2.pieces[:pawn4].color
    # board.grid[1][4] = player2.pieces[:pawn5].color
    # board.grid[1][5] = player2.pieces[:pawn6].color
    # board.grid[1][6] = player2.pieces[:pawn7].color
    # board.grid[1][7] = player2.pieces[:pawn8].color

    board.grid[7][0] = player1.pieces[:rook1].color
    board.grid[7][1] = player1.pieces[:knight1].color
    board.grid[7][2] = player1.pieces[:bishop1].color
    board.grid[7][4] = player1.pieces[:queen].color
    board.grid[7][3] = player1.pieces[:king].color
    board.grid[7][5] = player1.pieces[:bishop2].color
    board.grid[7][6] = player1.pieces[:knight2].color
    board.grid[7][7] = player1.pieces[:rook2].color
    # board.grid[6][0] = player1.pieces[:pawn1].color
    # board.grid[6][1] = player1.pieces[:pawn2].color
    # board.grid[6][2] = player1.pieces[:pawn3].color
    # board.grid[6][3] = player1.pieces[:pawn4].color
    # board.grid[6][4] = player1.pieces[:pawn5].color
    # board.grid[6][5] = player1.pieces[:pawn6].color
    # board.grid[6][6] = player1.pieces[:pawn7].color
    # board.grid[6][7] = player1.pieces[:pawn8].color
  end
end
