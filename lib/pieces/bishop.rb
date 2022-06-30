require_relative 'piece'
require 'pry'

class Bishop < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♝' : '♗'
  end

  def moves(location, result = [])
    i = 1
    7.times do
      moves = [[i, i], [-i, -i], [-i, i], [i, -i]]
      moves.each do |move|
        x = location[0] + move[0]
        y = location[1] + move[1]
        result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
      end
      i += 1
    end
    result
  end

  # Good enough for now, I want to refactor later
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
    end
    true
  end

  def find_path(start, fin, path = [])
    x = fin[0] - start[0] # 1 - 4
    y = fin[1] - start[1] # 1 - 4
    i = start[0] # 4
    j = start[1]

    if x.positive? && y.positive?
      until i == fin[0] - 1
        path << [start[0] + i, start[1] + i]
        i += 1
      end
    elsif x.positive? && y.negative?
      until i == fin[0]
        path << [start[0] + i, start[1] - i]
        i += 1
      end
    elsif x.negative? && y.positive?
      until i == fin[0]
      end
    elsif x.negative? && y.negative?
      (x * x / 2).times do
        path << [start[0] - i, start[1] - i]
        i += 1
      end
    end
    path
  end
end
