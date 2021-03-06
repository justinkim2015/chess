require 'pry'

module Castling
  def space_clear?(rook_spot)
    return true if @turn.pieces[:rook].path_empty?(@board, @turn.pieces[:king].position, rook_spot)

    false
  end

  def spots_safe?(rook_spot)
    spots = @turn.pieces[:rook].find_path(@turn.pieces[:king].position, rook_spot)
    spots.each do |spot|
      return false if spot_being_attacked?(spot)
    end
    true
  end

  def original_positions_left?
    rook = @turn.color == 'White' ? :rook : :rook2

    if @turn.color == 'White'
      king_start = [7, 3]
      rook_start = [7, 0] # rook
    else
      king_start = [0, 3]
      rook_start = [0, 7] # rook2
    end
    return true if @turn.pieces[:king].position == king_start && @turn.pieces[rook].position == rook_start

    false
  end

  def original_positions_right?
    rook = @turn.color == 'White' ? :rook2 : :rook

    if @turn.color == 'White'
      king_start = [7, 3]
      rook_start = [7, 7] # rook2
    else
      king_start = [0, 3]
      rook_start = [0, 0] # rook
    end
    return true if @turn.pieces[:king].position == king_start && @turn.pieces[rook].position == rook_start

    false
  end

  def original_positions?
    return true if original_positions_left? || original_positions_right?

    false
  end

  def can_castle?
    return true if can_castle_left? || can_castle_right?

    false
  end

  def can_castle_left?
    rook = @turn.color == 'White' ? :rook : :rook2

    return true if space_clear?(@turn.pieces[rook].position) &&
                   spots_safe?(@turn.pieces[rook].position) &&
                   original_positions_left?

    false
  end

  def can_castle_right?
    rook = @turn.color == 'White' ? :rook2 : :rook

    return true if space_clear?(@turn.pieces[rook].position) &&
                   spots_safe?(@turn.pieces[rook].position) &&
                   original_positions_right?

    false
  end

  def castle_left
    if @turn.color == 'White'
      king_start = [7, 3]
      king_fin = [7, 1]
      rook_start = [7, 0]
      rook_fin = [7, 2]
    else
      king_start = [0, 3]
      king_fin = [0, 5]
      rook_start = [0, 7]
      rook_fin = [0, 4]
    end

    @turn.pieces[:king].position = king_fin
    @turn.pieces[:rook].position = rook_fin
    @board.grid[king_start[0]][king_start[1]] = ' '
    @board.grid[rook_start[0]][rook_start[1]] = ' '
    @board.grid[king_fin[0]][king_fin[1]] = @turn.pieces[:king].color
    @board.grid[rook_fin[0]][rook_fin[1]] = @turn.pieces[:rook].color
  end

  def castle_right
    if @turn.color == 'White'
      king_start = [7, 3]
      king_fin = [7, 5]
      rook_start = [7, 7]
      rook_fin = [7, 4]
    else
      king_start = [0, 3]
      king_fin = [0, 1]
      rook_start = [0, 0]
      rook_fin = [0, 2]
    end

    @turn.pieces[:king].position = king_fin
    @turn.pieces[:rook].position = rook_fin
    @board.grid[king_start[0]][king_start[1]] = ' '
    @board.grid[rook_start[0]][rook_start[1]] = ' '
    @board.grid[king_fin[0]][king_fin[1]] = @turn.pieces[:king].color
    @board.grid[rook_fin[0]][rook_fin[1]] = @turn.pieces[:rook].color
  end

  def castle_direction(direction = ' ')
    puts 'Would you like to castle left or right?'
    direction = gets.chomp until %w[left right].include?(direction)
    if direction.downcase == 'left' && can_castle_left?
      castle_left
    elsif direction.downcase == 'right' && can_castle_right?
      castle_right
    else
      puts 'Please input your selection again!'
      castle_direction
    end
  end

  def castle
    castle_direction
    change_turn
  end
end
