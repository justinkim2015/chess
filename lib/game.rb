require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require 'pry'

class Game
  attr_accessor :board, :player1, :player2, :turn, :enemy

  def initialize
    @player1 = Player.new('Player 1', 'White')
    @player2 = Player.new('Player 2', 'Black')
    @board = Board.new
    @turn = @player1
    @enemy = @turn == @player1 ? @player2 : @player1
  end

  def taken_pieces
    p @turn.taken_pieces
  end

  def remember_spot(fin)
    pieces = if @turn == @player1
               @turn.pieces[:queen].black_pieces
             else
               @turn.pieces[:queen].white_pieces
             end

    return unless pieces.include?(board.grid[fin[0]][fin[1]])

    @turn.taken_pieces << board.grid[fin[0]][fin[1]]
  end

  def find_piece(spot)
    piece = board.grid[spot[0]][spot[1]]
    unicode_to_word(piece).to_sym
  end

  def valid_move?(start, fin)
    board.grid[start[0]][start[1]] == @turn.pieces[find_piece(fin)].color
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

  def winner_message
    puts "Congrats #{@enemy.name} you are the winner!!!"
  end

  def escape_check
    puts 'You are in check! Protect your king!'
    start = valid_input_start
    puts 'Where would you like to go?'
    fin = valid_input_fin
    move(start, fin)
    change_turn if board.grid[start[0]][start[1]] == ' ' && check? == false # I need to insert an error message here
    return if checkmate?

    return unless check?

    move(fin, start)
    board.drawboard
    puts 'You\'re still in check!'
    escape_check
  end

  def take_turn
    return winner_message if checkmate?

    board.drawboard
    puts "Its #{@turn.name}'s turn!"
    if check?
      info = which_piece_checking(@turn.pieces[:king].position)
      piece = info[:piece]
      loc = info[:position]
      puts "#{@turn.name} is being checked by #{piece} at #{loc}"
      escape_check
    else
      start = valid_input_start
      puts 'Where would you like to move it?'
      fin = valid_input_fin
      move(start, fin)
      change_turn if board.grid[start[0]][start[1]] == ' '
    end
  end

  def check?
    return true if spot_being_attacked?(@turn.pieces[:king].position)

    false
  end

  def spot_being_attacked?(spot, enemy = @enemy)
    return true if enemy.pieces[:pawn1].pawn_attacking_square?(@board, spot) ||
                   enemy.pieces[:bishop1].attacking_square?(@board, spot) ||
                   enemy.pieces[:knight1].attacking_square?(@board, spot) ||
                   enemy.pieces[:queen].attacking_square?(@board, spot) ||
                   enemy.pieces[:rook1].attacking_square?(@board, spot)

    false
  end

  def which_piece_checking(spot, enemy = @enemy)
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

  def checkmate?
    king_no_escape? && no_save_eating? && path_unblockable?
  end

  def unicode_to_word(unicode)
    possible_pieces = { ♙: 'pawn', ♕: 'queen', ♖: 'rook', ♘: 'knight', ♗: 'bishop',
                        ♟: 'pawn', ♛: 'queen', ♜: 'rook', ♞: 'knight', ♝: 'bishop'}
    sym = unicode.to_sym
    possible_pieces[sym]
  end

  def path_unblockable?
    return true unless check?

    king_spot = @turn.pieces[:king].position
    enemy = which_piece_checking(king_spot)
    enemy_position = enemy[:position]
    symbol_name = unicode_to_word(enemy[:piece]).to_sym
    path = @turn.pieces[symbol_name].find_path(king_spot, enemy_position)
    path.each do |place|
      return false if spot_being_attacked?(place, @turn)
    end
    true
  end

  # This is checking if a piece can be saved by being eaten by another
  # WHICH PLAYER IS IT CHECKING
  def no_save_eating?
    return true unless check?

    enemy_piece = which_piece_checking(@turn.pieces[:king].position)
    return false if spot_being_attacked?(enemy_piece[:position], @turn)

    true
  end

  # This is currently only checking the movement of the king to escape check
  # It does it by checking if the updated spot after calling move is being attacked
  # If all possible moves are being attacked then its true
  def king_no_escape?
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
    if @turn == @player1
      @turn = @player2
      @enemy = @player1
    else
      @turn = @player1
      @enemy = @player2
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
