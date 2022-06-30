require_relative 'piece'
require 'pry'
class Queen < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♛' : '♕'
  end

  def moves(location, result = [])
    i = 1
    7.times do
      moves = [[i, i], [-i, -i], [-i, i], [i, -i], [i, 0], [-i, 0], [0, i], [0, -i]]
      moves.each do |move|
        x = location[0] + move[0]
        y = location[1] + move[1]
        result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
      end
      i += 1
    end
    result
  end

  # spot is where im attacking, piece is where the piece is
  def path_empty?(board, spot, piece)
    x = piece[0] - spot[0]
    y = piece[1] - spot[1]

    if x.positive? && y.positive?
      until spot == [piece[0] - 1, piece[1] - 1]
        return false if board.grid[spot[0] += 1][spot[1] += 1] != ' '
      end
    elsif x.positive? && y.negative?
      until spot == [piece[0] - 1, piece[1] + 1]
        return false if board.grid[spot[0] += 1][spot[1] -= 1] != ' '
      end
    elsif x.negative? && y.positive?
      until spot == [piece[0] + 1, piece[1] - 1]
        return false if board.grid[spot[0] -= 1][spot[1] += 1] != ' '
      end
    elsif x.negative? && y.negative?
      until spot == [piece[0] + 1, piece[1] + 1]
        return false if board.grid[spot[0] -= 1][spot[1] -= 1] != ' '
      end
    elsif x.positive?
      until spot == [piece[0] - 1, piece[1]]
        return false if board.grid[spot[0] += 1][spot[1]] != ' '
      end
    elsif x.negative?
      until spot == [piece[0] + 1, piece[1]]
        return false if board.grid[spot[0] -= 1][spot[1]] != ' '
      end
    elsif y.positive?
      until spot == [piece[0], piece[1] - 1]
        return false if board.grid[spot[0]][spot[1] += 1] != ' '
      end
    elsif y.negative?
      until spot == [piece[0], piece[1] + 1]
        return false if board.grid[spot[0]][spot[1] -= 1] != ' '
      end
    end

    true
  end

  # def path(board, spot, piece, path = [])
  #   x = piece[0] - spot[0]
  #   y = piece[1] - spot[1]

  #   if x.positive? && y.positive?
  #     until spot == piece
  #       path << [spot[0] += 1, spot[1] += 1]
  #     end
  #   elsif x.positive? && y.negative?
  #     until spot == [piece[0] - 1, piece[1] + 1]
  #       path << board.grid[spot[0] += 1][spot[1] -= 1]
  #     end
  #   elsif x.negative? && y.positive?
  #     until spot == [piece[0] + 1, piece[1] - 1]
  #       path << board.grid[spot[0] -= 1][spot[1] += 1]
  #     end
  #   elsif x.negative? && y.negative?
  #     until spot == [piece[0] + 1, piece[1] + 1]
  #       path << board.grid[spot[0] -= 1][spot[1] -= 1]
  #     end
  #   elsif x.positive?
  #     until spot == [piece[0] - 1, piece[1]]
  #       path << board.grid[spot[0] += 1][spot[1]]
  #     end
  #   elsif x.negative?
  #     until spot == [piece[0] + 1, piece[1]]
  #       path << board.grid[spot[0] -= 1][spot[1]]
  #     end
  #   elsif y.positive?
  #     until spot == [piece[0], piece[1] - 1]
  #       path << board.grid[spot[0]][spot[1] += 1]
  #     end
  #   elsif y.negative?
  #     until spot == [piece[0], piece[1] + 1]
  #       path << board.grid[spot[0]][spot[1] -= 1]
  #     end
  #   end
  #   path
  # end

  # Find a method that prints out the full path with one move to a spot, maybe filter would be
  # elegant here?
  # def find_path(start, fin, path = [])  # start is 1,1 fin is 3,3
  #   all_moves = moves(start)
  #   x = fin[0] - start[0]
  #   y = fin[1] - start[1]

  #   i = 0
  #   x.times do
  #     if fin[0] >= start[0] + i && fin[1] >= start[1] + i
  #       path << [start[0] + i, start[1] + i]
  #       i += 1
  #     end
  #   end

  #   path
  # end

  def find_path(start, fin) # start is 3,3 fin is 5,1
    all_moves = moves(start)

    if start[0] > fin[0]
      max = start[0]
      min = fin[0]
    else
      max = fin[0]
      min = start[0]
    end

    # this is working for both positive and negative
    all_moves.filter do |move|
      move[0] == move[1] && move[0].between?(min, max)
    end

    # maybe write one more for one pos, one neg
    # all_moves.filter do |move|
    #   start[0] == (move[0] + move[1]) / 2 &&
    #   start[0] < move[0] &&
    #   start[1] > move[1]
    # end
  end
end
